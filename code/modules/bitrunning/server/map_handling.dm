/// Gives all current occupants a notification that the server is going down
/obj/machinery/quantum_server/proc/begin_shutdown(mob/user)
	if(isnull(generated_domain))
		return

	if(!length(avatar_connection_refs))
		balloon_alert_to_viewers("отключение домена...")
		playsound(src, 'sound/machines/terminal_off.ogg', 40, vary = TRUE)
		reset()
		return

	balloon_alert_to_viewers("оповещаем клиентов...")
	playsound(src, 'sound/machines/terminal_alert.ogg', 100, vary = TRUE)
	user.visible_message(
		span_danger("[user] начинает отключать сервер!"),
		span_notice("Вы отключаете клиентов..."),
		span_danger("Вы слышите быстрый стук клавиш по клавиатуре."),
	)

	SEND_SIGNAL(src, COMSIG_BITRUNNER_SHUTDOWN_ALERT, user)

	if(!do_after(user, 20 SECONDS, src))
		return

	reset()

/// Links all the loading processes together - does validation for booting a map
/obj/machinery/quantum_server/proc/cold_boot_map(map_key)
	if(!is_ready)
		return FALSE

	if(isnull(map_key))
		balloon_alert_to_viewers("домен не выбран!")
		return FALSE

	if(generated_domain)
		balloon_alert_to_viewers("остановите текущий домен!")
		return FALSE

	if(length(avatar_connection_refs))
		balloon_alert_to_viewers("все клиенты должны отключиться!")
		return FALSE

	is_ready = FALSE
	playsound(src, 'sound/machines/terminal_processing.ogg', 30, 2)

	/// If any one of these fail, it reverts the entire process
	if(!load_domain(map_key) || !load_map_items() || !load_mob_segments())
		balloon_alert_to_viewers("инициализация провалена!")
		scrub_vdom()
		is_ready = TRUE
		return FALSE

	SSblackbox.record_feedback("tally", "bitrunning_domain_loaded", 1, map_key)

	is_ready = TRUE

	if(prob(clamp((threat * glitch_chance), 1, 10)))
		setup_glitch()

	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 30, vary = TRUE)
	balloon_alert_to_viewers("домен загружен.")
	generated_domain.start_time = world.time
	points -= generated_domain.cost
	update_use_power(ACTIVE_POWER_USE)
	update_appearance()

	if(broadcasting)
		start_broadcasting_network(BITRUNNER_CAMERA_NET)

	return TRUE

/// Initializes a new domain if the given key is valid and the user has enough points
/obj/machinery/quantum_server/proc/load_domain(map_key)
	for(var/datum/lazy_template/virtual_domain/available in SSbitrunning.all_domains)
		if(map_key == available.key && points >= available.cost)
			generated_domain = available
			RegisterSignal(generated_domain, COMSIG_LAZY_TEMPLATE_LOADED, PROC_REF(on_template_loaded))
			generated_domain.lazy_load()
			return TRUE

	return FALSE

/// Loads in necessary map items like hololadder spawns, caches, etc
/obj/machinery/quantum_server/proc/load_map_items()
	var/turf/goal_turfs = list()
	var/turf/cache_turfs = list()
	var/turf/curiosity_turfs = list()

	for(var/obj/effect/landmark/bitrunning/thing in GLOB.landmarks_list)
		if(istype(thing, /obj/effect/landmark/bitrunning/hololadder_spawn))
			exit_turfs += get_turf(thing)
			qdel(thing) // i'm worried about multiple servers getting confused so lets clean em up
			continue

		if(istype(thing, /obj/effect/landmark/bitrunning/cache_goal_turf))
			var/turf/tile = get_turf(thing)
			goal_turfs += tile
			RegisterSignal(tile, COMSIG_ATOM_ENTERED, PROC_REF(on_goal_turf_entered))
			RegisterSignal(tile, COMSIG_ATOM_EXAMINE, PROC_REF(on_goal_turf_examined))
			qdel(thing)
			continue

		if(istype(thing, /obj/effect/landmark/bitrunning/cache_spawn))
			cache_turfs += get_turf(thing)
			qdel(thing)
			continue

		if(istype(thing, /obj/effect/landmark/bitrunning/curiosity_spawn))
			curiosity_turfs += get_turf(thing)
			qdel(thing)
			continue

		if(istype(thing, /obj/effect/landmark/bitrunning/loot_signal))
			var/turf/signaler_turf = get_turf(thing)
			signaler_turf.AddComponent(/datum/component/bitrunning_points, generated_domain)
			qdel(thing)

	if(!length(exit_turfs))
		CRASH("Failed to find exit turfs on generated domain.")
	if(!length(goal_turfs))
		CRASH("Failed to find send turfs on generated domain.")

	if(!attempt_spawn_cache(cache_turfs))
		return FALSE

	while(length(curiosity_turfs))
		var/turf/picked_turf = attempt_spawn_curiosity(curiosity_turfs)
		if(!picked_turf)
			break
		generated_domain.secondary_loot_generated += 1
		curiosity_turfs -= picked_turf

	return TRUE

/// Stops the current virtual domain and disconnects all users
/obj/machinery/quantum_server/proc/reset(fast = FALSE)
	is_ready = FALSE

	sever_connections()

	if(!fast)
		notify_spawned_threats()
		addtimer(CALLBACK(src, PROC_REF(scrub_vdom)), 15 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE)
	else
		scrub_vdom() // used in unit testing, no need to wait for callbacks

	addtimer(CALLBACK(src, PROC_REF(cool_off)), ROUND_UP(server_cooldown_time * capacitor_coefficient), TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_DELETE_ME)
	update_appearance()

	update_use_power(IDLE_POWER_USE)
	domain_randomized = FALSE
	retries_spent = 0

	stop_broadcasting_network(BITRUNNER_CAMERA_NET)

/// Tries to clean up everything in the domain
/obj/machinery/quantum_server/proc/scrub_vdom()
	sever_connections() /// just in case someone's connected
	SEND_SIGNAL(src, COMSIG_BITRUNNER_DOMAIN_SCRUBBED) // avatar cleanup just in case

	if(length(generated_domain.reservations))
		var/datum/turf_reservation/res = generated_domain.reservations[1]
		res.Release()

	var/list/creatures = spawned_threat_refs + mutation_candidate_refs
	for(var/datum/weakref/creature_ref as anything in creatures)
		var/mob/living/creature = creature_ref?.resolve()
		if(isnull(creature))
			continue

		creature.dust(just_ash = TRUE, force = TRUE) // sometimes mobs just don't die

	generated_domain.secondary_loot_generated = 0

	avatar_connection_refs.Cut()
	exit_turfs = list()
	generated_domain = null
	mutation_candidate_refs.Cut()
	spawned_threat_refs.Cut()

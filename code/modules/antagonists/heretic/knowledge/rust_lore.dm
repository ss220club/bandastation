/**
 * # The path of Rust.
 *
 * Goes as follows:
 *
 * Blacksmith's Tale
 * Grasp of Rust
 * Leeching Walk
 * > Sidepaths:
 *   Priest's Ritual
 *   Armorer's Ritual
 *
 * Mark of Rust
 * Ritual of Knowledge
 * Rust Construction
 * > Sidepaths:
 *   Lionhunter Rifle
 *
 * Aggressive Spread
 * > Sidepaths:
 *   Curse of Corrosion
 *   Mawed Crucible
 *
 * Toxic Blade
 * Entropic Plume
 * > Sidepaths:
 *   Rusted Ritual
 *   Rust Charge
 *
 * Rustbringer's Oath
 */
/datum/heretic_knowledge/limited_amount/starting/base_rust
	name = "Blacksmith's Tale"
	desc = "Открывает перед вами Путь ржавчины. \
		Позволяет трансмутировать нож с любым мусором в Ржавый клинок. \
		Одновременно можно создать только два."
	gain_text = "\"Позвольте мне рассказать вам историю\", сказал Кузнец, вглядываясь в глубину своего ржавого клинка."
	next_knowledge = list(/datum/heretic_knowledge/rust_fist)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/trash = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/rust)
	route = PATH_RUST

/datum/heretic_knowledge/rust_fist
	name = "Grasp of Rust"
	desc = "Ваша Хватка Мансуса наносит 500 единиц урона неживой материи и ржавеет любая поверхность, которой она коснется. \
		Уже заржавевшие поверхности разрушаются. Поверхности и структуры можно заставить ржаветь с помощью ПКМ."
	gain_text = "На потолке Мансуса ржавчина растет, как мох на камне."
	next_knowledge = list(/datum/heretic_knowledge/rust_regen)
	cost = 1
	route = PATH_RUST

/datum/heretic_knowledge/rust_fist/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))

/datum/heretic_knowledge/rust_fist/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, list(COMSIG_HERETIC_MANSUS_GRASP_ATTACK, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY))

/datum/heretic_knowledge/rust_fist/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER

	if(!issilicon(target) && !(target.mob_biotypes & MOB_ROBOTIC))
		return

	target.rust_heretic_act()

/datum/heretic_knowledge/rust_fist/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)
	SIGNAL_HANDLER

	// Rusting an airlock causes it to lose power, mostly to prevent the airlock from shocking you.
	// This is a bit of a hack, but fixing this would require the enture wire cut/pulse system to be reworked.
	if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = target
		airlock.loseMainPower()

	target.rust_heretic_act()
	return COMPONENT_USE_HAND

/datum/heretic_knowledge/rust_regen
	name = "Leeching Walk"
	desc = "Дает вам пассивное исцеление и устойчивость к батонам, когда вы стоите над ржавчиной."
	gain_text = "Скорость была беспрецедентной, сила - неестественной. Кузнец улыбался."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/rust_mark,
		/datum/heretic_knowledge/armor,
		/datum/heretic_knowledge/essence,
		/datum/heretic_knowledge/entropy_pulse,
	)
	cost = 1
	route = PATH_RUST

/datum/heretic_knowledge/rust_regen/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))

/datum/heretic_knowledge/rust_regen/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_LIFE))

/*
 * Signal proc for [COMSIG_MOVABLE_MOVED].
 *
 * Checks if we should have baton resistance on the new turf.
 */
/datum/heretic_knowledge/rust_regen/proc/on_move(mob/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	var/turf/mover_turf = get_turf(source)
	if(HAS_TRAIT(mover_turf, TRAIT_RUSTY))
		ADD_TRAIT(source, TRAIT_BATON_RESISTANCE, type)
		return

	REMOVE_TRAIT(source, TRAIT_BATON_RESISTANCE, type)

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Gradually heals the heretic ([source]) on rust,
 * including baton knockdown and stamina damage.
 */
/datum/heretic_knowledge/rust_regen/proc/on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	var/turf/our_turf = get_turf(source)
	if(!HAS_TRAIT(our_turf, TRAIT_RUSTY))
		return

	// Heals all damage + Stamina
	var/need_mob_update = FALSE
	need_mob_update += source.adjustBruteLoss(-2, updating_health = FALSE)
	need_mob_update += source.adjustFireLoss(-2, updating_health = FALSE)
	need_mob_update += source.adjustToxLoss(-2, updating_health = FALSE, forced = TRUE) // Slimes are people too
	need_mob_update += source.adjustOxyLoss(-0.5, updating_health = FALSE)
	need_mob_update += source.adjustStaminaLoss(-2, updating_stamina = FALSE)
	if(need_mob_update)
		source.updatehealth()
	// Reduces duration of stuns/etc
	source.AdjustAllImmobility(-0.5 SECONDS)
	// Heals blood loss
	if(source.blood_volume < BLOOD_VOLUME_NORMAL)
		source.blood_volume += 2.5 * seconds_per_tick

/datum/heretic_knowledge/mark/rust_mark
	name = "Mark of Rust"
	desc = "Ваша Хватка Мансуса теперь применяет Метку ржавчины. Метка срабатывает при атаке вашим Ржавым клинком. \
		При срабатывании органы и оборудование жертвы с вероятностью 75% получат повреждения и могут быть уничтожены."
	gain_text = "Кузнец смотрит вдаль. В давно потерянное место. \"Ржавые Холмы помогают остро нуждающимся... за определенную плату.\""
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/rust)
	route = PATH_RUST
	mark_type = /datum/status_effect/eldritch/rust

/datum/heretic_knowledge/knowledge_ritual/rust
	next_knowledge = list(/datum/heretic_knowledge/spell/rust_construction)
	route = PATH_RUST

/datum/heretic_knowledge/spell/rust_construction
	name = "Rust Construction"
	desc = "Дает вам Rust Construction - заклинание, позволяющее возвести стену из ржавого пола. \
		Любой человек, находящийся над стеной, будет отброшен в сторону (или вверх) и получит урон."
	gain_text = "В моем сознании начали плясать образы иноземных и зловещих сооружений. Покрытые с ног до головы толстым слоем ржавчины, \
		они больше не выглядели рукотворными. А может быть, они вообще никогда и не существовали."
	next_knowledge = list(/datum/heretic_knowledge/spell/area_conversion)
	spell_to_add = /datum/action/cooldown/spell/pointed/rust_construction
	cost = 1
	route = PATH_RUST

/datum/heretic_knowledge/spell/area_conversion
	name = "Aggressive Spread"
	desc = "Дает вам заклинание Aggressive Spread, которое распространяет ржавчину на близлежащие поверхности. \
		Уже заржавевшие поверхности разрушаются."
	gain_text = "Все разумные люди хорошо знают, что не стоит посещать Ржавые Холмы... Но рассказ Кузнеца был вдохновляющим."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/rust,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/curse/corrosion,
		/datum/heretic_knowledge/crucible,
		/datum/heretic_knowledge/rifle,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/rust_conversion
	cost = 1
	route = PATH_RUST

/datum/heretic_knowledge/blade_upgrade/rust
	name = "Toxic Blade"
	desc = "Ваш Ржавый клинок теперь отравляет врагов при атаке."
	gain_text = "Кузнец протягивает вам свой клинок. \"Клинок проведет тебя через плоть, если ты позволишь ему.\" \
		Тяжелая ржавчина утяжеляет клинок. Вы пристально вглядываетесь в него. Ржавые Холмы зовут тебя."
	next_knowledge = list(/datum/heretic_knowledge/spell/entropic_plume)
	route = PATH_RUST

/datum/heretic_knowledge/blade_upgrade/rust/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	// No user == target check here, cause it's technically good for the heretic?
	target.reagents?.add_reagent(/datum/reagent/eldritch, 5)

/datum/heretic_knowledge/spell/entropic_plume
	name = "Entropic Plume"
	desc = "Дарует вам Entropic Plume, заклинание, выпускающее досаждающую волну ржавчины. \
		Ослепляет, отравляет и накладывает Amok на всех попавших язычников, заставляя их дико нападать \
		на друзей или врагов. Также ржавеет и разрушает поверхности, на которые попадает."
	gain_text = "Коррозия была неостановима. Ржавчина была неприятной. \
		Кузнец ушел, ты держишь его клинок. Чемпионы надежды, Повелитель ржавчины близок!"
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/rust_final,
		/datum/heretic_knowledge/summon/rusty,
		/datum/heretic_knowledge/spell/rust_charge,
	)
	spell_to_add = /datum/action/cooldown/spell/cone/staggered/entropic_plume
	cost = 1
	route = PATH_RUST

/datum/heretic_knowledge/ultimate/rust_final
	name = "Rustbringer's Oath"
	desc = "Ритуал вознесения Пути ржавчины. \
		Принесите 3 трупа к руне трансмутации на мостик станции, чтобы завершить ритуал. \
		После завершения, ритуальное место будет бесконечно распространять ржавчину на любую поверхность, не останавливаясь ни перед чем. \
		Кроме того, вы станете чрезвычайно стойкими на ржавчине, исцеляясь втрое быстрее \
		и приобретая иммунитет ко многим эффектам и опасностям."
	gain_text = "Чемпион ржавчины. Разлагатель стали. Бойся темноты, ибо пришел ПОВЕЛИТЕЛЬ РЖАВЧИНЫ! \
		Работа Кузнеца продолжается! Ржавые Холмы, УСЛЫШЬТЕ МОЕ ИМЯ! УЗРИТЕ МОЕ ВОЗНЕСЕНИЕ!"
	route = PATH_RUST
	/// If TRUE, then immunities are currently active.
	var/immunities_active = FALSE
	/// A typepath to an area that we must finish the ritual in.
	var/area/ritual_location = /area/station/command/bridge
	/// A static list of traits we give to the heretic when on rust.
	var/static/list/conditional_immunities = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_NO_SLIP_ALL,
		TRAIT_NOBREATH,
		TRAIT_PIERCEIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_SHOCKIMMUNE,
		TRAIT_SLEEPIMMUNE,
		TRAIT_STUNIMMUNE,
	)

/datum/heretic_knowledge/ultimate/rust_final/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	// This map doesn't have a Bridge, for some reason??
	// Let them complete the ritual anywhere
	if(!GLOB.areas_by_type[ritual_location])
		ritual_location = null

/datum/heretic_knowledge/ultimate/rust_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(ritual_location)
		var/area/our_area = get_area(loc)
		if(!istype(our_area, ritual_location))
			loc.balloon_alert(user, "ритуал провален, должны быть в [initial(ritual_location.name)]!") // "must be in bridge"
			return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/rust_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce(
		text = "[generate_heretic_text()] Бойтесь разложения, ведь Повелитель ржавчины, [user.real_name] вознесся! Никто не избежит коррозии! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = ANNOUNCER_SPANOMALIES,
		color_override = "pink",
	)
	new /datum/rust_spread(loc)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	user.client?.give_award(/datum/award/achievement/misc/rust_ascension, user)

/**
 * Signal proc for [COMSIG_MOVABLE_MOVED].
 *
 * Gives our heretic ([source]) buffs if they stand on rust.
 */
/datum/heretic_knowledge/ultimate/rust_final/proc/on_move(mob/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	// If we're on a rusty turf, and haven't given out our traits, buff our guy
	var/turf/our_turf = get_turf(source)
	if(HAS_TRAIT(our_turf, TRAIT_RUSTY))
		if(!immunities_active)
			source.add_traits(conditional_immunities, type)
			immunities_active = TRUE

	// If we're not on a rust turf, and we have given out our traits, nerf our guy
	else
		if(immunities_active)
			source.remove_traits(conditional_immunities, type)
			immunities_active = FALSE

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Gradually heals the heretic ([source]) on rust.
 */
/datum/heretic_knowledge/ultimate/rust_final/proc/on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	var/turf/our_turf = get_turf(source)
	if(!HAS_TRAIT(our_turf, TRAIT_RUSTY))
		return

	var/need_mob_update = FALSE
	need_mob_update += source.adjustBruteLoss(-4, updating_health = FALSE)
	need_mob_update += source.adjustFireLoss(-4, updating_health = FALSE)
	need_mob_update += source.adjustToxLoss(-4, updating_health = FALSE, forced = TRUE)
	need_mob_update += source.adjustOxyLoss(-4, updating_health = FALSE)
	need_mob_update += source.adjustStaminaLoss(-20, updating_stamina = FALSE)
	if(need_mob_update)
		source.updatehealth()

/**
 * #Rust spread datum
 *
 * Simple datum that automatically spreads rust around it.
 *
 * Simple implementation of automatically growing entity.
 */
/datum/rust_spread
	/// The rate of spread every tick.
	var/spread_per_sec = 6
	/// The very center of the spread.
	var/turf/centre
	/// List of turfs at the edge of our rust (but not yet rusted).
	var/list/edge_turfs = list()
	/// List of all turfs we've afflicted.
	var/list/rusted_turfs = list()
	/// Static blacklist of turfs we can't spread to.
	var/static/list/blacklisted_turfs = typecacheof(list(
		/turf/open/indestructible,
		/turf/closed/indestructible,
		/turf/open/space,
		/turf/open/lava,
		/turf/open/chasm
	))

/datum/rust_spread/New(loc)
	centre = get_turf(loc)
	centre.rust_heretic_act()
	rusted_turfs += centre
	START_PROCESSING(SSprocessing, src)

/datum/rust_spread/Destroy(force)
	centre = null
	edge_turfs.Cut()
	rusted_turfs.Cut()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/rust_spread/process(seconds_per_tick)
	var/spread_amount = round(spread_per_sec * seconds_per_tick)

	if(length(edge_turfs) < spread_amount)
		compile_turfs()

	for(var/i in 0 to spread_amount)
		if(!length(edge_turfs))
			break
		var/turf/afflicted_turf = pick_n_take(edge_turfs)
		afflicted_turf.rust_heretic_act()
		rusted_turfs |= afflicted_turf

/**
 * Compile turfs
 *
 * Recreates the edge_turfs list.
 * Updates the rusted_turfs list, in case any turfs within were un-rusted.
 */
/datum/rust_spread/proc/compile_turfs()
	edge_turfs.Cut()

	var/max_dist = 1
	for(var/turf/found_turf as anything in rusted_turfs)
		if(!HAS_TRAIT(found_turf, TRAIT_RUSTY))
			rusted_turfs -= found_turf
		max_dist = max(max_dist, get_dist(found_turf, centre) + 1)

	for(var/turf/nearby_turf as anything in spiral_range_turfs(max_dist, centre, FALSE))
		if(nearby_turf in rusted_turfs || is_type_in_typecache(nearby_turf, blacklisted_turfs))
			continue

		for(var/turf/line_turf as anything in get_line(nearby_turf, centre))
			if(get_dist(nearby_turf, line_turf) <= 1)
				edge_turfs |= nearby_turf
		CHECK_TICK

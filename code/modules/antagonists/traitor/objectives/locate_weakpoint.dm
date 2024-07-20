/datum/traitor_objective_category/locate_weakpoint
	name = "Locate And Destroy Weakpoint"
	objectives = list(
		/datum/traitor_objective/locate_weakpoint = 1,
	)
	weight = OBJECTIVE_WEIGHT_UNLIKELY

/datum/traitor_objective/locate_weakpoint
	name = "Триангулируйте слабое место в структуре станции и взорвите заряд взрывчатки поблизости."
	description = "Вы получите портативное устройство, которое нужно будет использовать в %AREA1% и %AREA2%, чтобы триангулировать слабое место в конструкции станции и устроить там взрыв. Напоминаем, что как только вы начнете сканировать одну из областей, ИИ станции будет предупрежден."

	progression_minimum = 45 MINUTES
	progression_reward = list(15 MINUTES, 20 MINUTES)
	telecrystal_reward = list(3, 5)

	var/progression_objectives_minimum = 20 MINUTES

	/// Have we sent a weakpoint locator yet?
	var/locator_sent = FALSE
	/// Have we sent a bomb yet?
	var/bomb_sent = FALSE
	/// Have we located the weakpoint yet?
	var/weakpoint_found = FALSE
	/// Areas that need to be scanned
	var/list/area/scan_areas
	/// Weakpoint where the bomb should be planted
	var/area/weakpoint_area

/datum/traitor_objective/locate_weakpoint/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	if(length(possible_duplicates) > 0)
		return FALSE
	if(handler.get_completion_progression(/datum/traitor_objective) < progression_objectives_minimum)
		return FALSE
	if(SStraitor.get_taken_count(/datum/traitor_objective/locate_weakpoint) > 0)
		return FALSE
	return TRUE

/datum/traitor_objective/locate_weakpoint/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	scan_areas = list()
	/// List of high-security areas that we pick required ones from
	var/list/allowed_areas = typecacheof(list(/area/station/command,
		/area/station/comms,
		/area/station/engineering,
		/area/station/science,
		/area/station/security,
	))

	var/list/blacklisted_areas = typecacheof(list(/area/station/engineering/hallway,
		/area/station/engineering/lobby,
		/area/station/engineering/storage,
		/area/station/science/lobby,
		/area/station/science/ordnance/bomb,
		/area/station/security/prison,
	))

	var/list/possible_areas = GLOB.the_station_areas.Copy()
	for(var/area/possible_area as anything in possible_areas)
		if(!is_type_in_typecache(possible_area, allowed_areas) || initial(possible_area.outdoors) || is_type_in_typecache(possible_area, blacklisted_areas))
			possible_areas -= possible_area

	for(var/i in 1 to 2)
		scan_areas[pick_n_take(possible_areas)] = TRUE
	weakpoint_area = pick_n_take(possible_areas)

	var/area/scan_area1 = scan_areas[1]
	var/area/scan_area2 = scan_areas[2]
	replace_in_name("%AREA1%", initial(scan_area1.name))
	replace_in_name("%AREA2%", initial(scan_area2.name))
	RegisterSignal(SSdcs, COMSIG_GLOB_TRAITOR_OBJECTIVE_COMPLETED, PROC_REF(on_global_obj_completed))
	return TRUE

/datum/traitor_objective/locate_weakpoint/ungenerate_objective()
	UnregisterSignal(SSdcs, COMSIG_GLOB_TRAITOR_OBJECTIVE_COMPLETED)

/datum/traitor_objective/locate_weakpoint/on_objective_taken(mob/user)
	. = ..()

	// We don't want multiple people being able to take weakpoint objectives if they get one available at the same time
	for(var/datum/traitor_objective/locate_weakpoint/other_objective as anything in SStraitor.all_objectives_by_type[/datum/traitor_objective/locate_weakpoint])
		if(other_objective != src)
			other_objective.fail_objective()


/datum/traitor_objective/locate_weakpoint/proc/on_global_obj_completed(datum/source, datum/traitor_objective/objective)
	SIGNAL_HANDLER
	if(istype(objective, /datum/traitor_objective/locate_weakpoint))
		fail_objective()

/datum/traitor_objective/locate_weakpoint/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(!locator_sent)
		buttons += add_ui_button("", "Нажмите, чтобы материализовать локатор слабых мест станции.", "globe", "locator")
	if(weakpoint_found && !bomb_sent)
		buttons += add_ui_button("", "Нажмите, чтобы материализовать взрывчатый заряд ES8.", "bomb", "shatter_charge")
	return buttons

/datum/traitor_objective/locate_weakpoint/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if("locator")
			if(locator_sent)
				return
			locator_sent = TRUE
			var/obj/item/weakpoint_locator/locator = new(user.drop_location(), src)
			user.put_in_hands(locator)
			locator.balloon_alert(user, "локатор слабых мест материализуется в руке")

		if("shatter_charge")
			if(bomb_sent)
				return
			bomb_sent = TRUE
			var/obj/item/grenade/c4/es8/bomb = new(user.drop_location(), src)
			user.put_in_hands(bomb)
			bomb.balloon_alert(user, "заряд ES8 материализуется в руке")

/datum/traitor_objective/locate_weakpoint/proc/weakpoint_located()
	description = "Слабое место обнаружено в %AREA%. Взорвите заряд ES8 в обнаруженной зоне, чтобы вызвать взрывную волну, значительно повреждающую станцию."
	replace_in_name("%AREA%", initial(weakpoint_area.name))
	weakpoint_found = TRUE

/datum/traitor_objective/locate_weakpoint/proc/create_shockwave(center_x, center_y, center_z)
	var/turf/epicenter = locate(center_x, center_y, center_z)
	var/lowpop = (length(GLOB.clients) <= CONFIG_GET(number/minimal_access_threshold))
	if(lowpop)
		explosion(epicenter, devastation_range = 2, heavy_impact_range = 4, light_impact_range = 6, explosion_cause = src)
	else
		explosion(epicenter, devastation_range = 3, heavy_impact_range = 6, light_impact_range = 9, explosion_cause = src)
	priority_announce(
				"Внимание экипаж, похоже, что в слабом месте вашей станции взорвался мощный взрывной заряд, вызвавший серьезные структурные повреждения.",
				"[command_name()] Высокоприоритетное оповещение"
				)

	succeed_objective()

/obj/item/weakpoint_locator
	name = "structural weakpoint locator"
	desc = "Устройство, которое может определить структурное слабое место станции. Его необходимо использовать в %AREA1% и %AREA2% для триангуляции слабого места. Напоминаем, что ИИ станции будет уведомлен, как только процесс начнется!"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "weakpoint_locator"
	inhand_icon_state = "weakpoint_locator"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	var/datum/weakref/objective_weakref

/obj/item/weakpoint_locator/Initialize(mapload, datum/traitor_objective/locate_weakpoint/objective)
	. = ..()
	objective_weakref = WEAKREF(objective)
	if(!objective)
		return
	var/area/area1 = objective.scan_areas[1]
	var/area/area2 = objective.scan_areas[2]
	desc = replacetext(desc, "%AREA1%", initial(area1.name))
	desc = replacetext(desc, "%AREA2%", initial(area2.name))

/obj/item/weakpoint_locator/Destroy(force)
	objective_weakref = null
	return ..()

/obj/item/weakpoint_locator/attack_self(mob/living/user, modifiers)
	. = ..()
	if(!istype(user) || loc != user || !user.mind) //No TK cheese
		return

	var/datum/traitor_objective/locate_weakpoint/objective = objective_weakref.resolve()

	if(!objective || objective.objective_state == OBJECTIVE_STATE_INACTIVE)
		to_chat(user, span_warning("Ваше время использовать [src] еще не пришло."))
		return

	if(objective.handler.owner != user.mind)
		to_chat(user, span_warning("Вы понятия не имеете, как использовать [src]."))
		return

	var/area/user_area = get_area(user)
	if(!(user_area.type in objective.scan_areas))
		balloon_alert(user, "неверная область!")
		playsound(user, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
		return

	if(!objective.scan_areas[user_area.type])
		balloon_alert(user, "место уже отсканированно!")
		playsound(user, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
		return

	user.visible_message(span_danger("[user] нажимает несколько кнопок на [src], и предмет начинает зловеще пищать!"), span_notice("Вы активируете [src] и начинаете сканировать местность. Не выходите [get_area_name(user, TRUE)], пока сканирование не завершится!"))
	playsound(user, 'sound/machines/triple_beep.ogg', 30, TRUE)
	var/alertstr = span_userdanger("Сетевое оповещение: обнаружена попытка анализирование сети станции[user_area?" в [get_area_name(user, TRUE)]":". Невозможно определить местоположение"].")
	for(var/mob/living/silicon/ai/ai_player in GLOB.player_list)
		to_chat(ai_player, alertstr)

	if(!do_after(user, 30 SECONDS, src, IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM | IGNORE_INCAPACITATED | IGNORE_SLOWDOWNS, extra_checks = CALLBACK(src, PROC_REF(scan_checks), user, user_area, objective), hidden = TRUE))
		playsound(user, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
		return

	playsound(user, 'sound/machines/ding.ogg', 100, TRUE)
	objective.scan_areas[user_area.type] = FALSE
	for(var/area/scan_area as anything in objective.scan_areas)
		if(objective.scan_areas[scan_area])
			say("Следующее место сканирования: [initial(scan_area.name)]")
			return

	to_chat(user, span_notice("Сканирование завершено. Слабое место конструкции расположено в [initial(objective.weakpoint_area.name)]."))
	objective.weakpoint_located()

/obj/item/weakpoint_locator/proc/scan_checks(mob/living/user, area/user_area, datum/traitor_objective/locate_weakpoint/parent_objective)
	if(get_area(user) != user_area)
		return FALSE

	if(parent_objective.objective_state != OBJECTIVE_STATE_ACTIVE)
		return FALSE

	var/atom/current_loc = loc
	while(!isturf(current_loc) && !ismob(current_loc))
		current_loc = current_loc.loc

	if(current_loc != user)
		return FALSE

	return TRUE

/obj/item/grenade/c4/es8
	name = "ES8 explosive charge"
	desc = "Мощный заряд взрывчатого вещества, предназначенный для создания ударной волны в слабом месте конструкции станции."

	icon_state = "plasticx40"
	inhand_icon_state = "plasticx4"
	worn_icon_state = "x4"

	boom_sizes = list(3, 6, 9)

	/// Weakref to user's objective
	var/datum/weakref/objective_weakref

/obj/item/grenade/c4/es8/Initialize(mapload, objective)
	. = ..()
	objective_weakref = WEAKREF(objective)

/obj/item/grenade/c4/es8/Destroy()
	objective_weakref = null
	return ..()

/obj/item/grenade/c4/es8/plant_c4(atom/bomb_target, mob/living/user)
	if(!IS_TRAITOR(user))
		to_chat(user, span_warning("Похоже, вы не можете найти способ взорвать заряд."))
		return FALSE

	var/datum/traitor_objective/locate_weakpoint/objective = objective_weakref.resolve()
	if(!objective || objective.objective_state == OBJECTIVE_STATE_INACTIVE || objective.handler.owner != user.mind)
		to_chat(user, span_warning("Вы не думаете, что было бы разумно использовать [src]."))
		return FALSE

	var/area/target_area = get_area(bomb_target)
	if (target_area.type != objective.weakpoint_area)
		to_chat(user, span_warning("[src] можно взорвать только в [initial(objective.weakpoint_area.name)]."))
		return FALSE

	if(!isfloorturf(bomb_target) && !iswallturf(bomb_target))
		to_chat(user, span_warning("[src] можно ставить только на стену или пол"))
		return FALSE

	return ..()

/obj/item/grenade/c4/es8/detonate(mob/living/lanced_by)
	var/area/target_area = get_area(target)
	var/datum/traitor_objective/locate_weakpoint/objective = objective_weakref.resolve()

	if(!objective)
		return

	if (target_area.type != objective.weakpoint_area)
		var/obj/item/grenade/c4/es8/new_bomb = new(target.drop_location())
		new_bomb.balloon_alert_to_viewers("неверная локация!")
		target.cut_overlay(plastic_overlay, TRUE)
		qdel(src)
		return

	objective.create_shockwave(target.x, target.y, target.z)
	return ..()

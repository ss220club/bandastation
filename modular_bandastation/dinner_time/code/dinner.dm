/proc/run_dinner()
	var/list/dinner_places = list()
	for(var/area/locate_dinner_room in GLOB.areas)
		if(locate_dinner_room.dinner_place)
			dinner_places += locate_dinner_room
	if(isnull(dinner_places))
		stack_trace("No areas to run dinner!")
		return
	var/datum/dinner/new_dinner = new/datum/dinner()
	new_dinner.dinner_areas = dinner_places

/datum/dinner
	var/list/dinner_areas = list()

/datum/dinner/New()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(time_to_dinner)), 30 MINUTES)

/datum/dinner/proc/time_to_dinner()
	priority_announce(
		text = "Перерыв на обед! Покиньте своё рабочее помещение и отправляйтесь в ближайший кафетерий на обед. \
		У вас есть 5 минут, чтобы пообедать, после чего вы немедленно должны вернуться к работе!",
		title = "Dinner Time!",
		sound = 'sound/announcer/announcement/announce_dig.ogg',
		sender_override = "Daily Routine Announce",
		color_override = "green",
	)
	for(var/mob/living/carbon/human/hungry_human in GLOB.player_list)
		if(!is_station_level(hungry_human.z)) // только космос спасает от желания пообедать.
			continue
		if(hungry_human.stat == DEAD) // ну или смерть
			continue
		if(hungry_human.mind.antag_datums)
			continue
		hungry_human.apply_status_effect(/datum/status_effect/dinner_influence, dinner_areas)

/datum/traitor_objective/ultimate/dark_matteor
	name = "Вызовите сингулярность из темной материи, чтобы поглотить станцию."
	description = "Пройдите в %AREA% и получите контрабандные спутники и emag. Установите спутники и используйте на них emag, \
	и когда достаточно спутников будет перекалибровано с помощью emag, ОНО ПРИДЕТ. Внимание: Сингулярность из темной материи будет охотиться на всех существ, включая вас."

	//this is a prototype so this progression is for all basic level kill objectives

	///area type the objective owner must be in to receive the satellites
	var/area/satellites_spawnarea_type
	///checker on whether we have sent the satellites yet.
	var/sent_satellites = FALSE

/datum/traitor_objective/ultimate/dark_matteor/can_generate_objective(generating_for, list/possible_duplicates)
	. = ..()
	if(!.)
		return FALSE
	if(SSmapping.is_planetary())
		return FALSE //meteors can't spawn on planets
	return TRUE

/datum/traitor_objective/ultimate/dark_matteor/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	var/list/possible_areas = GLOB.the_station_areas.Copy()
	for(var/area/possible_area as anything in possible_areas)
		if(!ispath(possible_area, /area/station/maintenance/solars) && !ispath(possible_area, /area/station/solars))
			possible_areas -= possible_area
	if(length(possible_areas) == 0)
		return FALSE
	satellites_spawnarea_type = pick(possible_areas)
	replace_in_name("%AREA%", initial(satellites_spawnarea_type.name))
	return TRUE

/datum/traitor_objective/ultimate/dark_matteor/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(!sent_satellites)
		buttons += add_ui_button("", "Нажмите, чтобы призвать под с контрабандными спутниками.", "satellite", "satellite")
	return buttons

/datum/traitor_objective/ultimate/dark_matteor/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if("satellite")
			if(sent_satellites)
				return
			var/area/delivery_area = get_area(user)
			if(delivery_area.type != satellites_spawnarea_type)
				to_chat(user, span_warning("Вы должны быть в [initial(satellites_spawnarea_type.name)], чтобы получить контрабандные спутники."))
				return
			sent_satellites = TRUE
			podspawn(list(
				"target" = get_turf(user),
				"style" = STYLE_SYNDICATE,
				"spawn" = /obj/structure/closet/crate/engineering/smuggled_meteor_shields,
			))

/obj/structure/closet/crate/engineering/smuggled_meteor_shields

/obj/structure/closet/crate/engineering/smuggled_meteor_shields/PopulateContents()
	..()
	for(var/i in 1 to 11)
		new /obj/machinery/satellite/meteor_shield(src)
	new /obj/item/card/emag/meteor_shield_recalibrator(src)
	new /obj/item/paper/dark_matteor_summoning(src)

/obj/item/paper/dark_matteor_summoning
	name = "notes - dark matter meteor summoning"
	default_raw_text = {"
		Призыв метеорита тёмной материи<br>
		<br>
		<br>
		Оперативник, в этом ящике находятся 10 и один дополнительный метеорный щит украденный с линий снабжения НТ. Ваша миссия состоит
		в установке их в космосе рядом со станцией и перекалибровки их с помощью предоставленного Емага. Будьте осторожны: вам нужно 30 секунд
		для восстановления между каждым взломом, и НТ обнаружит ваше вмешательство после семи повторных калибровок. Это значит что вы
		будете иметь не менее 5 минут для работы и 1 минуту для защиты.<br>
		<br>
		Это очень рискованная операция. Вам потребуется поддержка, укрепление и решимость. Награда?
		Впечатляющая сингулярность темной материи, которая уничтожит станцию!<br>
		<br>
		<b>**Смерть Nanotrasen**</b>
"}

/obj/item/card/emag/meteor_shield_recalibrator
	name = "cryptographic satellite recalibrator"
	desc = "Этот криптографический сиквенсор был настроен, чтобы рекалибровать метеорные щиты быстрее и с меньшим риском их поломки."

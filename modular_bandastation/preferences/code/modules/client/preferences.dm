/datum/preferences
	max_save_slots = 5
	var/loadout_points = 0

/datum/preferences/load_preferences()
	. = ..()
	get_loadout_points()

/datum/preferences/proc/get_loadout_points()
	var/donation_level = parent.donator_level
	switch(donation_level)
		if(0)
			loadout_points = 5
		if(1)
			loadout_points = 8
		if(2)
			loadout_points = 11
		if(3)
			loadout_points = 14
		if(4)
			loadout_points = 17
		if(5)
			loadout_points = 20
	return loadout_points

/datum/preferences/load_preferences()
	. = ..() // Вызов базовой загрузки

	// Загрузка донаторского уровня из префов
	var/donation_level = savefile.get_entry("donator_level", 0)
	parent.donator_level = donation_level

	return TRUE

/datum/preferences/save_preferences()
	. = ..() // Вызов базового сохранения

    // Костыль 2 - проверка что это не первый вызов (ибо первый приходится на проверку кейбиндов)
	if(!parent.can_save_donator_level)
		return TRUE

	// Сохранение донаторского уровня в префы
	var/donation_level = parent.donator_level
	savefile.set_entry("donator_level", donation_level)
	savefile.save()
	return TRUE

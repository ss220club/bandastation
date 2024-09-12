/datum/preferences
	max_save_slots = 5
	var/loadout_points = 0

/datum/preferences/load_preferences()
	. = ..()
	get_loadout_points()

/datum/preferences/proc/get_loadout_points()
	var/donation_level = parent.get_donator_level()
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

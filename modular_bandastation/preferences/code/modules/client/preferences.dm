/datum/preferences
	max_save_slots = 5

/client
	var/loadout_points = 0

/datum/client_interface/
	var/loadout_points = 0

/datum/preferences/load_preferences()
	. = ..()
	var/donation_level = parent.get_donator_level()
	switch(donation_level)
		if(0)
			parent.loadout_points = 5
		if(1)
			parent.loadout_points = 8
		if(2)
			parent.loadout_points = 11
		if(3)
			parent.loadout_points = 14
		if(4)
			parent.loadout_points = 17
		if(5)
			parent.loadout_points = 20

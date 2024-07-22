/datum/preferences/load_preferences()
	. = ..()
	parent.update_donator_level()

// Removes donator_level items from the user if their donator_level is insufficient
/datum/preference/loadout/deserialize(input, datum/preferences/preferences)
	. = ..()
	var/donator_level = preferences.parent.donator_level
	var/removed_items = list()
	for(var/path in .)
		var/datum/loadout_item/item = GLOB.all_loadout_datums[path]
		if(donator_level >= item.donator_level)
			continue
		. -= path
		removed_items += item.name
	if(length(removed_items) && preferences.parent.mob)
		to_chat(preferences.parent.mob, span_warning("У вас недостаточный уровень доната, чтобы взять: [english_list(removed_items, and_text = " и ")]!"))

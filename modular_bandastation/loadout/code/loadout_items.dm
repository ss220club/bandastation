/client
	var/donator_level = 0

/datum/loadout_item
	var/donator_level = 0

/datum/loadout_item/get_item_information()
	. = ..()
	if(donator_level)
		. += "Tier [donator_level]"

// Removes donator_level items from the user if their donator_level is insufficient
/datum/preference/loadout/sanitize_loadout_list(list/passed_list, mob/optional_loadout_owner)
	. = ..()
	for(var/path in .)
		var/datum/loadout_item/item = GLOB.all_loadout_datums[path]
		if(optional_loadout_owner?.client.donator_level < item.donator_level)
			to_chat(optional_loadout_owner, span_warning("У вас недостаточный уровень доната, чтобы взять [item.name]!"))
			. -= path

// Removes item from the preferences menu, period. Use it only to remove stuff for ALL players.
/datum/loadout_item/proc/is_available()
	return TRUE

// Handles selecting from the preferences UI
/datum/preference_middleware/loadout/select_item(datum/loadout_item/selected_item)
	if(preferences.parent.donator_level < selected_item.donator_level)
		to_chat(preferences.parent.mob, span_warning("У вас недостаточный уровень доната, чтобы взять этот предмет!"))
		return
	. = ..()

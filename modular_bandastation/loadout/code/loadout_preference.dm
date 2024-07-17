/client
	var/donator_level = 0

// Removes donator_level items from the user if their donator_level is insufficient
/datum/preference/loadout/sanitize_loadout_list(list/passed_list, mob/optional_loadout_owner)
	. = ..()
	for(var/path in .)
		var/datum/loadout_item/item = GLOB.all_loadout_datums[path]
		if(optional_loadout_owner?.client.donator_level < item.donator_level)
			to_chat(optional_loadout_owner, span_warning("У вас недостаточный уровень доната, чтобы взять [item.name]!"))
			. -= path

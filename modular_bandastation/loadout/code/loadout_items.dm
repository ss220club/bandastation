/client
	var/donator_level = 0

/datum/loadout_item
	var/donator_level = 0

/datum/loadout_item/get_item_information()
	. = ..()
	if(donator_level)
		. += "Tier [donator_level]"

// Handles giving an item to the mob
/datum/loadout_item/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only)
	if(!is_available() || (donator_level && (equipper.client.donator_level < donator_level)))
		to_chat(equipper, span_warning("У вас недостаточный уровень доната, чтобы взять [name]!"))
		return
	. = ..()

// Removes item from the preferences menu, period. Use it only to remove stuff for ALL players.
/datum/loadout_item/proc/is_available()
	return TRUE

// Handles selecting from the preferences UI
/datum/preference_middleware/loadout/select_item(datum/loadout_item/selected_item)
	if(selected_item.donator_level && (preferences.parent.donator_level < selected_item.donator_level))
		to_chat(preferences.parent.mob, span_warning("У вас недостаточный уровень доната, чтобы взять этот предмет!"))
		return
	. = ..()

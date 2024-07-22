// Handles selecting from the preferences UI
/datum/preference_middleware/loadout/select_item(datum/loadout_item/selected_item)
	var/donator_level = preferences.parent.update_donator_level()
	if(donator_level >= selected_item.donator_level)
		return ..()
	to_chat(preferences.parent.mob, span_warning("У вас недостаточный уровень доната, чтобы взять [selected_item.name]!"))

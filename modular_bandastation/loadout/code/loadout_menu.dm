// Handles selecting from the preferences UI
/datum/preference_middleware/loadout/select_item(datum/loadout_item/selected_item)
	if(preferences.parent.donator_level < selected_item.donator_level)
		to_chat(preferences.parent.mob, span_warning("У вас недостаточный уровень доната, чтобы взять [selected_item.name]!"))
		return
	. = ..()

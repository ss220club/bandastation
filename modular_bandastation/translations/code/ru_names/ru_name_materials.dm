/datum/material
	// code\__DEFINES\bandastation\pronouns.dm for more info
	/// RU_NAMES_LIST_INIT("name", "именительный", "родительный", "дательный", "винительный", "творительный", "предложный")
	var/list/ru_names
	var/ru_name_nominative
	var/ru_name_genitive
	var/ru_name_dative
	var/ru_name_accusative
	var/ru_name_instrumental
	var/ru_name_prepositional

/datum/material/declent_ru(case_id, list/ru_names_override)
	var/list/list_to_use = ru_names_override || ru_names
	if(length(list_to_use))
		if(list_to_use[case_id] && list_to_use["base"] == name)
			return list_to_use[case_id] || name
	return name

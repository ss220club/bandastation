/datum/material/declent_ru(case_id, list/ru_names_override)
	if(!istype(sheet_type, /atom))
		CRASH("Sheet type couldn't be declented because it's not an /atom!")
	var/atom/sheet = sheet_type
	var/list/list_to_use = ru_names_override || sheet::ru_names
	if(length(list_to_use))
		if(list_to_use[case_id] && list_to_use["base"] == sheet::name)
			return list_to_use[case_id] || sheet::name
	return sheet::name

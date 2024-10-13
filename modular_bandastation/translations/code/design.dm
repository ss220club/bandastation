/datum/design
	var/use_declented_name = TRUE

/datum/design/New()
	. = ..()
	if(!use_declented_name || !build_path)
		return
	var/atom/design_result = build_path
	name = capitalize(design_result::ru_name_nominative) || name

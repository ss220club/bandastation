/datum/design

/datum/design/New()
	. = ..()
	var/new_name = declent_ru_initial(name)
	if(!new_name && ispath(build_path, /atom))
		var/atom/design_result = build_path
		new_name = declent_ru_initial(design_result::name)
	name = capitalize(new_name) || name

/datum/crafting_recipe

/datum/crafting_recipe/New()
	. = ..()
	var/new_name = declent_ru_initial(name)
	if(!new_name && ispath(result, /atom))
		var/atom/crafting_result = result
		new_name = declent_ru_initial(crafting_result::name)
	name = capitalize(new_name) || name

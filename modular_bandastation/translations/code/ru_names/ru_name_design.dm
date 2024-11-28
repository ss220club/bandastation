/datum/design

/datum/design/New()
	. = ..()
	name = update_to_ru() || name

/datum/design/proc/update_to_ru()
	var/new_name = declent_ru_initial(name)
	// Unique Design Name
	if(new_name)
		return new_name
	// Get built atom's name
	if(ispath(build_path, /atom))
		var/atom/design_result = build_path
		new_name = declent_ru_initial(design_result::name)
		if(new_name)
			return "[capitalize(new_name)]"

/datum/design/board/update_to_ru()
	. = ..()
	if(.)
		return .
	// If design nor board has unique name, use built atom's name
	var/obj/item/circuitboard/board = build_path
	if(!istype(board) || !ispath(board::build_path, /atom))
		return null
	var/new_name = declent_ru_initial(board::build_path)
	if(new_name)
		return "[capitalize(new_name)] (плата)"

/obj/item/circuitboard/Initialize(mapload)
	. = ..()
	// If board doesn't have unique name, use built atom's name
	if(!length(ru_names) && ispath(build_path, /atom))
		var/atom/build_item = build_path
		ru_names_rename(ru_names_toml(build_item::name))

/datum/crafting_recipe

/datum/crafting_recipe/New()
	. = ..()
	var/new_name = declent_ru_initial(name)
	if(!new_name && ispath(result, /atom))
		var/atom/crafting_result = result
		new_name = declent_ru_initial(crafting_result::name)
	name = capitalize(new_name) || name

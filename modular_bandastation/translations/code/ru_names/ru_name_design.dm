/datum/design
	/// List consists of ("name", "именительный", "родительный", "дательный", "винительный", "творительный", "предложный", "gender")
	var/list/ru_names

/datum/design/New()
	. = ..()
	if(!ispath(build_path, /atom))
		return
	var/atom/design_result = build_path
	ru_names = ru_names_toml(design_result::name)
	//name = capitalize(declent_ru_initial(design_result::name, NOMINATIVE, name))

/datum/design/declent_ru()
	. = name
	if(declent == "gender")
		. = NEUTER
	if(!length(ru_names) || ru_names["base"] != name)
		return .
	return get_declented_value(ru_names, declent, .)

/datum/crafting_recipe
	/// List consists of ("name", "именительный", "родительный", "дательный", "винительный", "творительный", "предложный", "gender")
	var/list/ru_names

/datum/crafting_recipe/New()
	. = ..()
	if(!ispath(result, /atom))
		return
	var/atom/crafting_result = result
	ru_names = ru_names_toml(crafting_result::name)
	//name = capitalize(declent_ru_initial(crafting_result::name, NOMINATIVE, name))

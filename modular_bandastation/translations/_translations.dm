GLOBAL_LIST_EMPTY(ru_attack_verbs)
GLOBAL_LIST_EMPTY(ru_eat_verbs)
GLOBAL_LIST_EMPTY(ru_say_verbs)
GLOBAL_LIST_EMPTY(ru_emote_names)
GLOBAL_LIST_EMPTY(ru_emote_messages)
GLOBAL_LIST_EMPTY(ru_reagent_descs)

/datum/modpack/translations
	name = "Переводы"
	desc = "Добавляет переводы"
	author = "Vallat, Larentoun, dj-34"

/datum/modpack/translations/post_initialize()
	// Verbs
	var/toml_path = "[PATH_TO_TRANSLATE_DATA]/ru_verbs.toml"
	if(fexists(file(toml_path)))
		var/list/verbs_toml_list = rustg_read_toml_file(toml_path)

		var/list/attack_verbs = verbs_toml_list["attack_verbs"]
		for(var/attack_key in attack_verbs)
			GLOB.ru_attack_verbs += list("[attack_key]" = attack_verbs[attack_key])

		var/list/eat_verbs = verbs_toml_list["eat_verbs"]
		for(var/eat_key in eat_verbs)
			GLOB.ru_eat_verbs += list("[eat_key]" = eat_verbs[eat_key])

		var/list/say_verbs = verbs_toml_list["say_verbs"]
		for(var/say_key in say_verbs)
			GLOB.ru_say_verbs += list("[say_key]" = say_verbs[say_key])

	// Emotes
	var/emote_path = "[PATH_TO_TRANSLATE_DATA]/ru_emotes.toml"
	if(fexists(file(emote_path)))
		var/list/emotes_toml_list = rustg_read_toml_file(emote_path)

		var/list/emote_messages = emotes_toml_list["emote_messages"]
		for(var/emote_message_key in emote_messages)
			GLOB.ru_emote_messages += list("[emote_message_key]" = emote_messages[emote_message_key])

		var/list/emote_names = emotes_toml_list["emote_names"]
		for(var/emote_name_key in emote_names)
			GLOB.ru_emote_names += list("[emote_name_key]" = emote_names[emote_name_key])

		for(var/emote_key as anything in GLOB.emote_list)
			var/list/emote_list = GLOB.emote_list[emote_key]
			for(var/datum/emote/emote in emote_list)
				emote.update_to_ru()
		for(var/emote_kb_key as anything in GLOB.keybindings_by_name)
			var/datum/keybinding/emote/emote_kb = GLOB.keybindings_by_name[emote_kb_key]
			if(!istype(emote_kb))
				continue
			emote_kb.update_to_ru()

	// Reagents desc
	var/reagents_path = "[PATH_TO_TRANSLATE_DATA]/ru_reagents.toml"
	if(fexists(file(reagents_path)))
		var/list/reagents_toml_list = rustg_read_toml_file(reagents_path)

		var/list/reagent_descs = reagents_toml_list["reagents_desc"]
		for(var/reagent_desc_key in reagent_descs)
			GLOB.ru_reagent_descs += list("[reagent_desc_key]" = reagent_descs[reagent_desc_key])

		for(var/reagent_key as anything in GLOB.chemical_reagents_list)
			var/datum/reagent/reagent = GLOB.chemical_reagents_list[reagent_key]
			reagent.update_to_ru()

ADMIN_VERB(get_data_to_toml, R_ADMIN, "DEBUG - Get data to toml", "Yeap", ADMIN_CATEGORY_DEBUG)
	var/list/data = list()
	var/pair = 1
	for(var/id in SSresearch.techweb_designs)
		var/datum/design/design = SSresearch.techweb_designs[id]
		if(!ispath(design.build_path, /atom))
			continue
		var/atom/design_result = design.build_path
		var/list/declented_list_design = ru_names_toml(design_result::name)

		// NOT TRANSLATED AT ALL
		if(!length(declented_list_design))
			// Is design name unique?
			if(LOWER_TEXT(format_text(design_result::name)) == LOWER_TEXT(design::name))
				// Need to translate only built item
				data["[pair]::: [format_text(design_result::name)]"] = list("untranslated_item" = "11111")
				pair++
				continue
			// Need to translate both built item and unique design name
			data["[pair]::: [design::name]"] = list("unique_design_name" = "11111")
			data["[pair]::: [format_text(design_result::name)]"] = list("untranslated_item" = "11111")
			pair++
			continue

		// Built item is translated
		// Are they equal in english?
		if(full_capitalize(declented_list_design["base"]) != design::name)
			// Need to translate design name
			data["[pair]::: [design::name]"] = list("design_from_result" = declented_list_design[NOMINATIVE])
			pair++

	var/file_location = "data/toml_data_for_laren.toml"
	var/payload = "[rustg_toml_encode(data)]"
	rustg_file_write(payload, file_location)

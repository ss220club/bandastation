#define LOG_CATEGORY_RU_NAMES_SUGGEST "ru_names_suggest"
#define FILE_NAME "ru_names_suggest.json"
#define FILE_PATH_TO_RU_NAMES_SUGGEST "data/[FILE_NAME]"

GLOBAL_DATUM_INIT(ru_names_suggest_panel, /datum/ru_names_suggest_panel, new)

ADMIN_VERB(ru_names_suggest_panel, R_ADMIN, "Ru-Names suggestions", "Shows player-suggested values for ru-names", ADMIN_CATEGORY_MAIN)
	GLOB.ru_names_suggest_panel.ui_interact(user.mob)

/datum/ru_names_suggest_panel
	var/list/json_data = list()

/datum/ru_names_suggest_panel/New()
	load_data()

/datum/ru_names_suggest_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/ru_names_suggest_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RuNamesSuggestPanel")
		ui.open()

/datum/ru_names_suggest_panel/ui_data(mob/user)
	. = list()
	.["json_data"] = list()
	for(var/entry_id in json_data)
		.["json_data"] += list(json_data["[entry_id]"])

/datum/ru_names_suggest_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("approve")
			approve_entry(params["entry_id"])
		if("deny")
			deny_entry(params["entry_id"])
		if("update")
			load_data()
	. = TRUE

/datum/ru_names_suggest_panel/proc/load_data()
	var/json_file = file(FILE_PATH_TO_RU_NAMES_SUGGEST)
	if(!fexists(json_file))
		CRASH("File [FILE_PATH_TO_RU_NAMES_SUGGEST] doesn't exist!")
	json_data = json_decode(file2text(json_file))

/datum/ru_names_suggest_panel/proc/write_data()
	var/json_file = file(FILE_PATH_TO_RU_NAMES_SUGGEST)
	if(!fexists(json_file))
		CRASH("File [FILE_PATH_TO_RU_NAMES_SUGGEST] doesn't exist!")
	rustg_file_write(json_encode(json_data, JSON_PRETTY_PRINT), FILE_PATH_TO_RU_NAMES_SUGGEST)

/datum/ru_names_suggest_panel/proc/approve_entry(entry_id)
	load_data()
	if(!length(json_data))
		return
	if(!json_data[entry_id])
		to_chat(usr, span_notice("Couldn't find entry #[entry_id]. Perhaps it was already approved or disapproved"))
	var/message = "approves [json_data[entry_id]["suggested_list"]] for [json_data[entry_id]["atom_path"]]"
	// Here we send message to discord

	json_data.Remove(entry_id)
	// Logging
	write_data()
	to_chat(usr, span_notice("Entry #[entry_id] approved."))
	var/log_text = "[key_name_and_tag(src)] [message]"
	logger.Log(LOG_CATEGORY_RU_NAMES_SUGGEST, log_text)

/datum/ru_names_suggest_panel/proc/deny_entry(entry_id)
	load_data()
	if(!length(json_data))
		return
	if(!json_data[entry_id])
		to_chat(usr, "Couldn't find entry #[entry_id]. Perhaps it was already approved or disapproved")
		return
	var/message = "denies [json_data[entry_id]["suggested_list"]] for [json_data[entry_id]["atom_path"]]"
	json_data.Remove(entry_id)
	write_data()
	to_chat(usr, span_notice("Entry #[entry_id] denied."))
	var/log_text = "[key_name_and_tag(src)] [message]"
	logger.Log(LOG_CATEGORY_RU_NAMES_SUGGEST, log_text)

/datum/ru_names_suggest_panel/proc/add_entry(data)
	var/json_file = file(FILE_PATH_TO_RU_NAMES_SUGGEST)
	if(!fexists(json_file))
		to_chat(usr, span_warning("Что-то пошло не так! Сообщите о том, что функционал не работает из-за отсутствия файла!"))
		CRASH("File [FILE_PATH_TO_RU_NAMES_SUGGEST] doesn't exist!")

	json_data["[usr.ckey]-[data["atom_path"]]"] = data
	rustg_file_write(json_encode(json_data, JSON_PRETTY_PRINT), FILE_PATH_TO_RU_NAMES_SUGGEST)

	var/suggested_list = "RU_NAMES_LIST_INIT(\"[data["suggested_list"]["base"]]\", \"[data["suggested_list"][NOMINATIVE]]\", \"[data["suggested_list"][GENITIVE]]\", \"[data["suggested_list"][DATIVE]]\", \"[data["suggested_list"][ACCUSATIVE]]\", \"[data["suggested_list"][INSTRUMENTAL]]\", \"[data["suggested_list"][PREPOSITIONAL]]\")"
	var/message = "suggests [suggested_list] for [data["atom_path"]]"
	var/log_text = "[key_name_and_tag(usr)] [message]"
	logger.Log(LOG_CATEGORY_RU_NAMES_SUGGEST, log_text)

	to_chat(usr, span_notice("Ваше предложение перевода успешно записано."))

/datum/log_category/ru_names_suggest
	category = LOG_CATEGORY_RU_NAMES_SUGGEST

/mob/verb/suggest_ru_name(atom/A as mob|obj|turf in view())
	set name = "Предложить перевод"

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(_suggested_ru_name), A))

/mob/proc/_suggested_ru_name(atom/suggested_atom)
	if(!client)
		return FALSE
	var/atom_name = suggested_atom.name
	var/atom/atom_type = suggested_atom.type

	// Add declents
	var/static/list/declents = list(NOMINATIVE, GENITIVE, DATIVE, ACCUSATIVE, INSTRUMENTAL, PREPOSITIONAL)
	var/list/ru_name_suggest = list("base" = atom_type::name)
	for(var/declent in declents)
		ru_name_suggest[declent] = tgui_input_text(src, "Введите [declent] падеж", "Предложение перевода для [atom_name]", atom_name)
		if(!ru_name_suggest[declent])
			to_chat(src, span_notice("Вы отменили предложение перевода."))
			return TRUE

	var/list/data = list()
	data["ckey"] = usr.ckey
	data["suggested_list"] = ru_name_suggest
	data["atom_path"] = atom_type::type
	GLOB.ru_names_suggest_panel.add_entry(data)
	return TRUE

#undef LOG_CATEGORY_RU_NAMES_SUGGEST
#undef FILE_PATH_TO_RU_NAMES_SUGGEST

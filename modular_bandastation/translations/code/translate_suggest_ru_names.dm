#define LOG_CATEGORY_RU_NAMES_SUGGEST "ru-names-suggest"

/atom/verb/verb_suggest_ru_name()
	set src in oview(14)
	set name = "Предложить перевод"

	usr.client.suggest_ru_name(name, type)

/client/proc/suggest_ru_name(atom_name, atom/atom_path)
	var/static/list/declents = list(NOMINATIVE, GENITIVE, DATIVE, ACCUSATIVE, INSTRUMENTAL, PREPOSITIONAL)
	var/list/ru_name_suggest = list()
	for(var/declent in declents)
		ru_name_suggest[declent] = tgui_input_text(src, "Введите [declent] падеж", "Предложение перевода для [atom_name]", atom_name)
		if(!ru_name_suggest[declent])
			to_chat(src, span_notice("Вы отменили предложение перевода."))
			return
	var/message = "suggests RU_NAMES_INIT_LIST(\"[atom_path::name]\", \"[ru_name_suggest[NOMINATIVE]]\", \"[ru_name_suggest[GENITIVE]]\"), \"[ru_name_suggest[DATIVE]]\", \"[ru_name_suggest[ACCUSATIVE]]\", \"[ru_name_suggest[INSTRUMENTAL]]\", \"[ru_name_suggest[PREPOSITIONAL]]\")"
	var/log_text = "[key_name_and_tag(src)] [message]"
	logger.Log(LOG_CATEGORY_RU_NAMES_SUGGEST, log_text)

#undef LOG_CATEGORY_RU_NAMES_SUGGEST

/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!client || client.interviewee)
		return

	if(href_list["toggle_ready"])
		ready = !ready
		SStitle.title_output(client, ready, "toggle_ready")

	else if(href_list["late_join"])
		GLOB.latejoin_menu.ui_interact(usr)

	else if(href_list["observe"])
		if(!SSticker || SSticker.current_state <= GAME_STATE_STARTUP)
			to_chat(usr, span_warning("Сервер ещё не загрузился!"))
			return

		make_me_an_observer()

	else if(href_list["character_setup"])
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
		preferences.update_static_data(src)
		preferences.ui_interact(src)

	else if(href_list["settings"])
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
		preferences.update_static_data(usr)
		preferences.ui_interact(usr)

	else if(href_list["manifest"])
		ViewManifest()

	else if(href_list["changelog"])
		client?.changelog()

	else if(href_list["wiki"])
		if(tgui_alert(usr, "Хотите открыть нашу вики?", "Вики", list("Да", "Нет")) != "Да")
			return
		client << link("https://tg.ss220.club")

	else if(href_list["trait_signup"])
		var/datum/station_trait/clicked_trait
		for(var/datum/station_trait/trait as anything in GLOB.lobby_station_traits)
			if(trait.name == href_list["trait_signup"])
				clicked_trait = trait

		clicked_trait.on_lobby_button_click(usr, href_list["id"])

	else if(href_list["picture"])
		if(!check_rights(R_FUN))
			log_admin("Title Screen: Possible href exploit attempt by [key_name(usr)]!")
			message_admins("Title Screen: Possible href exploit attempt by [key_name(usr)]!")
			return
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/change_title_screen)

	else if(href_list["notice"])
		if(!check_rights(R_FUN))
			log_admin("Title Screen: Possible href exploit attempt by [key_name(usr)]!")
			message_admins("Title Screen: Possible href exploit attempt by [key_name(usr)]!")
			return
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/change_title_screen_notice)

	else if(href_list["css"])
		if(!check_rights(R_DEBUG))
			log_admin("Title Screen: Possible href exploit attempt by [key_name(usr)]!")
			message_admins("Title Screen: Possible href exploit attempt by [key_name(usr)]!")
			return
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/change_title_screen_css)

	else if(href_list["focus"])
		winset(client, "map", "focus=true")

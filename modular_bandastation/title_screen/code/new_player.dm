/mob/dead/new_player/Login()
	. = ..()
	SStitle.show_title_screen_to(client)

/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!usr.client || usr.client.interviewee)
		return

	if(href_list["toggle_ready"])
		ready = !ready
		client << output(ready, "title_browser:toggle_ready")
		return

	else if(href_list["observe"])
		make_me_an_observer()
		return

	else if(href_list["job_traits"])
		show_job_traits()
		return

	else if(href_list["view_manifest"])
		ViewManifest()
		return

	else if(href_list["polls"])
		handle_player_polling()

	else if(href_list["character_setup"])
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
		preferences.update_static_data(src)
		preferences.ui_interact(src)
		return

	else if(href_list["game_options"])
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
		preferences.update_static_data(usr)
		preferences.ui_interact(usr)
		return

	else if(href_list["changelog"])
		usr.client?.changelog()

	else if(href_list["late_join"])
		GLOB.latejoin_menu.ui_interact(usr)

	else if(href_list["change_picture"])
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/change_title_screen)

	else if(href_list["leave_notice"])
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/change_title_screen_notice)

	else if(href_list["wiki"])
		if(tgui_alert(usr, "Хотите открыть нашу вики?", "Вики", list("Да", "Нет")) != "Да")
			return
		client << link("https://wiki.ss220.club")

	else if(href_list["discord"])
		if(tgui_alert(usr, "Хотите перейти в наш дискорд сервер?", "Дискорд", list("Да", "Нет")) != "Да")
			return
		client << link("https://discord.gg/ss220")

	else if(href_list["focus"])
		winset(client, "mapwindow", "focus=true")
		return

/**
 * Shows currently available job traits
 */
/mob/dead/new_player/proc/show_job_traits()
	if (!client || client.interviewee)
		return

	if(!length(GLOB.lobby_station_traits))
		to_chat(src, span_warning("There are currently no job traits available!"))
		return

	var/list/available_lobby_station_traits = list()
	for(var/datum/station_trait/trait as anything in GLOB.lobby_station_traits)
		if(!trait.can_display_lobby_button(client))
			continue

		available_lobby_station_traits += trait

	if(!LAZYLEN(available_lobby_station_traits))
		to_chat(src, span_warning("There are currently no job traits available!"))
		return

	var/datum/station_trait/clicked_trait = tgui_input_list(src, "Select a job trait to sign up for:", "Job Traits", available_lobby_station_traits)
	if(!clicked_trait)
		return

	clicked_trait.on_lobby_button_click(src)

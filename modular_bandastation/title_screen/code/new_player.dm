/mob/dead/new_player/Login()
	. = ..()
	SStitle.show_title_screen_to(client)

/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!client || client.interviewee)
		return

	if(href_list["toggle_ready"])
		ready = !ready
		client << output(ready, "title_browser:toggle_ready")
		return

	else if(href_list["late_join"])
		GLOB.latejoin_menu.ui_interact(usr)

	else if(href_list["observe"])
		make_me_an_observer()
		return

	else if(href_list["character_setup"])
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
		preferences.update_static_data(src)
		preferences.ui_interact(src)
		return

	else if(href_list["settings"])
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
		preferences.update_static_data(usr)
		preferences.ui_interact(usr)
		return

	else if(href_list["manifest"])
		ViewManifest()
		return

	else if(href_list["changelog"])
		client?.changelog()

	else if(href_list["polls"])
		handle_player_polling()

	else if(href_list["trait_signup"])
		var/datum/station_trait/clicked_trait
		for(var/datum/station_trait/trait as anything in GLOB.lobby_station_traits)
			if(trait.name == href_list["trait_signup"])
				clicked_trait = trait

		clicked_trait.on_lobby_button_click(usr, href_list["id"])

	else if(href_list["picture"])
		SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/change_title_screen)

	else if(href_list["notice"])
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
 * Checks can we show polls or not
 */
/mob/dead/new_player/proc/check_polls()
	if(!usr || !client)
		return FALSE

	if(is_guest_key(usr.key))
		return FALSE

	if(!SSdbcore.Connect())
		return FALSE

	var/isadmin = FALSE
	if(client?.holder)
		isadmin = TRUE

	var/datum/db_query/query_get_new_polls = SSdbcore.NewQuery({"
		SELECT id FROM [format_table_name("poll_question")]
		WHERE (adminonly = 0 OR :isadmin = 1)
		AND Now() BETWEEN starttime AND endtime
		AND deleted = 0
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_vote")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_textreply")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
	"}, list("isadmin" = isadmin, "ckey" = ckey))

	if(!query_get_new_polls.Execute())
		qdel(query_get_new_polls)
		return FALSE

	qdel(query_get_new_polls)
	if(QDELETED(src))
		return FALSE

	return TRUE

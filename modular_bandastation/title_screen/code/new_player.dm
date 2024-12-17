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

	else if(href_list["polls"])
		handle_player_polling()

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
		winset(client, "mapwindow", "focus=true")

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

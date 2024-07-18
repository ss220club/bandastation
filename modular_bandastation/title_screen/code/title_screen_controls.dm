/**
 * Enables an admin to upload a new titlescreen image.
 */
ADMIN_VERB(change_title_screen, R_FUN, "Title Screen: Change", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_EVENTS)
	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is changing the title screen.")
	message_admins("[key_name_admin(usr)] is changing the title screen.")

	switch(tgui_alert(usr, "Please select a new title screen.", "Title Screen", list("Change", "Reset", "Cancel")))
		if("Change")
			var/file = input(usr) as icon|null
			if(isnull(file))
				return

			SStitle.set_title_image(file)
		if("Reset")
			SStitle.set_title_image()
		if("Cancel")
			return

/**
 * Sets a titlescreen notice, a big red text on the main screen.
 */
ADMIN_VERB(change_title_screen_notice, R_FUN, "Title Screen: Set Notice", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_EVENTS)
	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is setting the title screen notice.")
	message_admins("[key_name_admin(usr)] is setting the title screen notice.")

	var/new_notice = tgui_input_text(usr, "Please input a notice to be displayed on the title screen:", "Titlescreen Notice")
	if(isnull(new_notice))
		return

	SStitle.set_notice(new_notice)
	for(var/mob/new_player in GLOB.player_list)
		to_chat(new_player, span_boldannounce("TITLE NOTICE UPDATED: [new_notice]"))
		SEND_SOUND(new_player,  sound('sound/items/bikehorn.ogg'))

/**
 * An admin debug command that enables you to change the HTML on the go.
 */
ADMIN_VERB(change_title_screen_html, R_FUN, "Title Screen: Set HTML", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_EVENTS)
	if(!check_rights(R_DEBUG))
		return

	log_admin("[key_name(usr)] is setting the title screen HTML.")
	message_admins("[key_name_admin(usr)] is setting the title screen HTML.")

	var/new_html = input(usr, "Please enter your desired HTML(WARNING: YOU WILL BREAK SHIT)", "DANGER: TITLE HTML EDIT") as message|null
	if(isnull(new_html))
		return

	SStitle.set_title_html(new_html)
	message_admins("[key_name_admin(usr)] has changed the title screen HTML.")

/**
 * Reloads the titlescreen if it is bugged for someone.
 */
/client/verb/fix_title_screen()
	set name = "Fix Lobby Screen"
	set desc = "Lobbyscreen broke? Press this."
	set category = "OOC"

	SStitle.show_title_screen_to(src)


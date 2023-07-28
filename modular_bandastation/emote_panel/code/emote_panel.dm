/datum/emote_panel/ui_static_data(mob/user)
	var/list/data = list()

	var/list/emotes = list()

	for(var/emote_path as anything in subtypesof(/datum/emote))
		var/datum/emote/emote = new emote_path()

		if(!is_type_in_typecache(user, emote.mob_type_allowed_typecache))
			continue
		if(is_type_in_typecache(user, emote.mob_type_blacklist_typecache))
			continue

		emotes += list(list(
			"key" = emote.key,
			"emote_path" = emote.type,
		))

	data["emotes"] = emotes

	return data

/datum/emote_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("play_emote")
			var/emote_path = params["emote_path"]
			var/datum/emote/emote = new emote_path()
			usr.emote(emote.key, intentional = TRUE)
			//emote.run_emote(usr, intentional = TRUE)

/datum/emote_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EmotePanel")
		ui.open()

/datum/emote_panel/ui_state(mob/user)
	return GLOB.always_state

/mob/living/verb/emote_panel()
	set name = "Emote Panel"
	set category = "IC"

	var/static/datum/emote_panel/emote_panel = new
	emote_panel.ui_interact(src)

/datum/keybinding/emote/link_to_emote(datum/emote/faketype)
	. = ..()
	full_name = capitalize(initial(faketype.name))

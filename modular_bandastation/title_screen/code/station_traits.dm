// STANDARD JOB TRAIT HANDLING
/datum/station_trait/job/on_lobby_button_click(mob/dead/new_player/user)
	if(SSticker.HasRoundStarted())
		to_chat(user, span_redtext("The round has already started!"))
		return
	if (LAZYFIND(lobby_candidates, user))
		LAZYREMOVE(lobby_candidates, user)
		to_chat(user, span_redtext("You have been removed from the [name] list of candidates."))
	else
		LAZYADD(lobby_candidates, user)
		to_chat(user, span_greentext("You have been added to the [name] list of candidates."))

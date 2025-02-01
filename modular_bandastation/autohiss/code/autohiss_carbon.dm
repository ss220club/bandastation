/mob/living/carbon/verb/toggle_autohiss()
	set category = "IC"
	set name = "Переключить модификатор речи"
    set desc = "Даёт возможность переключить модификатор речи"

	var/list/toggleable_speechmods = list()
	SEND_SIGNAL(src, COMSIG_AUTOHISS_GET_PARENTS, toggleable_speechmods)
	if(!length(toggleable_speechmods))
		to_chat(src, span_warning("Нет модификаторов речи доступных для переключения!"))
		return
	var/list/selected_parent_type = tgui_input_list(src, "Выберите, где нужно переключить автошипение.", "Переключить автошипение.", speechmod_parents)
	if(!selected_parent_type)
		return
	// So we don't make player choose, when only 1 option is available
	if(length(toggleable_speechmods) == 1)
		mind.toggle_autohiss(toggleable_speechmods[1])
		return
	var/speechmode_parent = tgui_input_list(src, "Выберите, где нужно переключить модификатор речи.", "Переключить модификтор речи.", toggleable_speechmods)
	if(isnull(speechmode_parent))
		return
    mind.toggle_speechmode(speechmode_parent)
	mind.toggle_autohiss(selected_parent_type)

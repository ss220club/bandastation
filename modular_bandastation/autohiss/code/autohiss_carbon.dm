/mob/living/carbon/verb/toggle_autohiss()
	set category = "IC"
	set name = "Переключить автошипение"
	set desc = "Переключает автошипение для органа языка, если это возможно"

	. = list()
	SEND_SIGNAL(src, COMSIG_AUTOHISS_GET_PARENTS, .)
	if(!length(.))
		to_chat(src, span_warning("Нет доступных для переключения автошипений!"))
		return
	var/list/selected_parent_type = tgui_input_list(src, "Выберите, где нужно переключить автошипение.", "Переключить автошипение.", .)
	if(!selected_parent_type)
		return
	mind.toggle_autohiss(selected_parent_type)

/mob/living/carbon/verb/toggle_autohiss()
	set category = "IC"
	set name = "Переключить автошипение"
	set desc = "Переключает автошипение для органа языка, если это возможно"

	var/obj/item/organ/tongue/tongue = get_organ_by_type(/obj/item/organ/tongue)
	if(!tongue)
		to_chat(src, span_warning("У вас нет языка, чтобы переключить автошипение!"))
		return
	if(!tongue.modifies_speech)
		to_chat(src, span_warning("Ваш язык не модифицирует речь!"))
		return

	mind.toggle_autohiss(tongue.type)

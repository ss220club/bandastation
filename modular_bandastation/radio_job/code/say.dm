/atom/movable/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	var/mob/living/carbon/human/H = usr
	if(!H?.get_assignment() || !radio_freq)
		return ""
	return @"<small>[" + H?.get_assignment(if_no_id = "Неизвестный", if_no_job = "Неизвестный", hand_first = FALSE) + @"]</small> "

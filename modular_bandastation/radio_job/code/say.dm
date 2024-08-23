/atom/movable/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	var/mob/living/carbon/human/H = usr
	if(!H.get_assignment())
		return ""
	return "[radio_freq ? " (" + H.get_assignment(if_no_id = "Unknown", if_no_job = "Unknown", hand_first = FALSE) + ")" : ""]"

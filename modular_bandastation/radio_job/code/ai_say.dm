/mob/living/silicon/ai/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	//Also includes the </a> for AI hrefs, for convenience.
	return "[radio_freq ? "(" + speaker.GetJob() + ")" : ""]" + "[speaker.GetSource() ? "</a> " : ""]"

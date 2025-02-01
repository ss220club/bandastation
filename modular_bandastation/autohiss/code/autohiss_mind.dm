/datum/mind
	/// List of types which the mind will prevent from using speechmod
	var/list/disabled_speechmode_parent_types = list()

/datum/mind/proc/toggle_autohiss(datum/speechmod_parent)
	if(speechmod_parent::type in autohiss_disabled_types)
		autohiss_disabled_types -= speechmod_parent::type
		to_chat(src, span_notice("Автошипение включено."))
		return
	autohiss_disabled_types += speechmod_parent::type
	// TODO: GIVE NAMES
	to_chat(src, span_notice("Автошипение отключено."))

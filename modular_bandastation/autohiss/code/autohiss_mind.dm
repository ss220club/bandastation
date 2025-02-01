/datum/mind
	/// Assoc list of types which the mind will prevent from using speechmod. list(type = "name")
	var/list/disabled_speechmode_parent_types = list()

/datum/mind/proc/toggle_speechmode(datum/speechmod_parent)
	// First get name
	// TODO: Send speechmod component?
	var/speechmod_name = speechmod_parent.type
	if(istype(speechmod_parent, /datum/mutation/human))
		var/datum/mutation/human/mutation = speechmod_parent
		speechmod_name = mutation.name
	if(istype(speechmod_parent, /datum/status_effect))
		var/datum/status_effect/effect = speechmod_parent
		var/atom/movable/screen/alert/status_effect/status_effect_alert = effect.alert_type
		speechmod_name = declent_ru_initial(status_effect_alert.name, GENITIVE, status_effect_alert::name)
	if(isatom(speechmod_parent))
		var/atom/speechmod_atom = speechmod_parent
		speechmod_name = declent_ru_initial(speechmod_atom::name, GENITIVE, speechmod_atom::name)

	// Then add/remove from list
	if(disabled_speechmode_parent_types[speechmod_parent.type])
		disabled_speechmode_parent_types -= speechmod_parent.type
		to_chat(src, span_notice("Автошипение включено для [speechmod_name]."))
		return
	disabled_speechmode_parent_types += list(speechmod_parent.type = speechmod_name)
	to_chat(src, span_notice("Автошипение отключено для [speechmod_name]."))

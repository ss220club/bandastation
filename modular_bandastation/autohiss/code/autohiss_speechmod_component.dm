#define REMOVE_AUTOHISS_VERB "remove_autohiss"
#define ADD_AUTOHISS_VERB "add_autohiss"

/datum/component/speechmod
	/// If this speechmod can be toggled by the player
	var/toggleable = FALSE

/datum/component/speechmod/proc/set_target_mob(mob/new_targeted)
	if(isnull(new_targeted) && targeted)
		UnregisterSignal(targeted, COMSIG_MOB_GET_AFFECTING_SPEECHMODS)
		update_mob_verb(REMOVE_AUTOHISS_VERB)
		targeted = null
		return
	RegisterSignal(new_targeted, COMSIG_MOB_GET_AFFECTING_SPEECHMODS, PROC_REF(add_to_speechmods_list))
	targeted = new_targeted
	update_mob_verb(ADD_AUTOHISS_VERB)

/datum/component/speechmod/proc/add_to_speechmods_list(mob/speechmods_target, list/speechmods_list)
	SIGNAL_HANDLER

	speechmods_list += src

/datum/component/speechmod/proc/get_parent_name()
	var/speechmod_name = parent.type
	if(istype(parent, /datum/mutation/human))
		var/datum/mutation/human/mutation = parent
		speechmod_name = mutation.name
	if(istype(parent, /datum/status_effect))
		var/datum/status_effect/effect = parent
		var/atom/movable/screen/alert/status_effect/status_effect_alert = effect.alert_type
		speechmod_name = declent_ru_initial(status_effect_alert.name, NOMINATIVE, status_effect_alert::name)
	if(isatom(parent))
		var/atom/speechmod_atom = parent
		speechmod_name = declent_ru_initial(speechmod_atom::name, NOMINATIVE, speechmod_atom::name)
	return speechmod_name

/datum/component/speechmod/handle_speech(datum/source, list/speech_args)
	if(targeted.mind?.disabled_speechmode_parent_types?[parent.type])
		return
	. = ..()

/datum/component/speechmod/proc/update_mob_verb(new_status)
	if(!targeted)
		return
	var/list/datum/component/speechmod/speechmods = list()
	SEND_SIGNAL(targeted, COMSIG_MOB_GET_AFFECTING_SPEECHMODS, speechmods)
	switch(new_status)
		if(ADD_AUTOHISS_VERB)
			if(length(speechmods) == 1)
				add_verb(targeted, /mob/proc/toggle_autohiss)
		if(REMOVE_AUTOHISS_VERB)
			if(length(speechmods) == 1)
				remove_verb(targeted, /mob/proc/toggle_autohiss)

/datum/component/speechmod/Destroy()
	update_mob_verb(REMOVE_AUTOHISS_VERB)
	. = ..()

#undef REMOVE_AUTOHISS_VERB
#undef ADD_AUTOHISS_VERB

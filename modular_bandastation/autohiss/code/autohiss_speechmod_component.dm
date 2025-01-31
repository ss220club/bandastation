/datum/component/speechmod
	var/autohiss_toggleable = FALSE

/datum/component/speechmod/Initialize(replacements, end_string, end_string_chance, slots, uppercase, should_modify_speech, autohiss_toggleable)
	. = ..()
	src.autohiss_toggleable = autohiss_toggleable

/datum/component/speechmod/proc/set_target_mob(mob/owner)
	if(!istype(owner))
		UnregisterSignal(targeted, COMSIG_AUTOHISS_HANDLER)
	targeted = owner
	if(!istype(targeted))
		return
	RegisterSignal(targeted, COMSIG_AUTOHISS_HANDLER, PROC_REF(get_me_there))

/datum/component/speechmod/proc/get_me_there(mob/target, list/speechmod_parents)
	SIGNAL_HANDLER

	if(autohiss_toggleable)
		speechmod_parents += parent.type

/datum/component/speechmod/handle_speech(datum/source, list/speech_args)
	if(parent.type in targeted.mind?.autohiss_disabled_types)
		return
	. = ..()

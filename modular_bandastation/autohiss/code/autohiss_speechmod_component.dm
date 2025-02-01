/datum/component/speechmod
	/// If this speechmod can be toggled by the player
	var/toggleable = FALSE

/datum/component/speechmod/proc/set_target_mob(mob/new_targeted)
	if(!isnull(new_targeted) && targeted)
		UnregisterSignal(targeted, COMSIG_AUTOHISS_GET_PARENTS)
	else
		RegisterSignal(new_targeted, COMSIG_AUTOHISS_GET_PARENTS, PROC_REF(add_to_autohiss_list))
	targeted = new_targeted

/datum/component/speechmod/proc/add_to_autohiss_list(mob/target, list/speechmod_parents)
	SIGNAL_HANDLER

	if(toggleable)
		speechmod_parents += parent

/datum/component/speechmod/handle_speech(datum/source, list/speech_args)
	if(targeted.mind?.disabled_speechmode_parent_types?[parent.type])
		return
	. = ..()

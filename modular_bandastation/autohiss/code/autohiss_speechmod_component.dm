/datum/component/speechmod/handle_speech(datum/source, list/speech_args)
	// Autohiss can only be disabled for natural tongues
	if(!istype(parent, /obj/item/organ/tongue))
		return ..()
	if(!targeted.mind)
		return ..()
	if(parent.type in targeted.mind.autohiss_disabled_types)
		return
	. = ..()

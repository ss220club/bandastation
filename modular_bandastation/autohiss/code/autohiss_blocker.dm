/datum/mind
	/// List of tongues which the mind will prevent from using speechmod (Auto-hiss)
	var/list/autohiss_disabled_types = list()

/datum/mind/proc/toggle_autohiss(obj/item/organ/tongue/tongue)
	if(tongue::type in autohiss_disabled_types)
		autohiss_disabled_types -= tongue::type
		to_chat(src, span_notice("Вы включили автошипение для языков типа [declent_ru_initial(tongue::name, declent = GENITIVE, override_backup = tongue::name)]."))
		return
	autohiss_disabled_types += tongue::type
	to_chat(src, span_notice("Вы отключили автошипение для языков типа [declent_ru_initial(tongue::name, declent = GENITIVE, override_backup = tongue::name)]."))

/datum/preference/toggle/autohiss_enabled
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "autohiss_enabled"
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = TRUE

/datum/preference/toggle/autohiss_enabled/apply_to_human(mob/living/carbon/human/target, value)
	if(value)
		return
	var/obj/item/organ/tongue/tongue = target.get_organ_by_type(/obj/item/organ/tongue)
	if(!tongue)
		CRASH("Tried to remove autohiss from a mob with no tongue!")
	RegisterSignal(target, COMSIG_MOB_MIND_TRANSFERRED_INTO, PROC_REF(on_mind_transfer), override = TRUE)

/datum/preference/toggle/autohiss_enabled/proc/on_mind_transfer(mob/living/carbon/human/current_mob, mob/previous_mob)
	SIGNAL_HANDLER
	var/obj/item/organ/tongue/tongue = current_mob.get_organ_by_type(/obj/item/organ/tongue)
	if(!tongue)
		CRASH("Tried to remove autohiss from a mob with no tongue on signal!")
	current_mob.mind.autohiss_disabled_types += tongue.type
	UnregisterSignal(current_mob, COMSIG_MOB_MIND_TRANSFERRED_INTO)

/datum/preference/toggle/autohiss_enabled/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/datum/species/specie = preferences.read_preference(/datum/preference/choiced/species)
	return specie.mutanttongue?.modifies_speech

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

/datum/component/speechmod/handle_speech(datum/source, list/speech_args)
	// Autohiss can only be disabled for natural tongues
	if(!istype(parent, /obj/item/organ/tongue))
		return ..()
	if(!targeted.mind)
		return ..()
	if(parent.type in targeted.mind.autohiss_disabled_types)
		return
	. = ..()

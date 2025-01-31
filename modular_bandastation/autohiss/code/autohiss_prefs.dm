/datum/preference/toggle/autohiss_enabled
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "autohiss_enabled"
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = TRUE

/datum/preference/toggle/autohiss_enabled/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/datum/species/specie = preferences.read_preference(/datum/preference/choiced/species)
	return specie.mutanttongue?.modifies_speech

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

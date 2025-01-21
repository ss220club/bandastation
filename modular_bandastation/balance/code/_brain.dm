/obj/item/organ/brain/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/brain_permanent_death))
        decay_factor = STANDARD_ORGAN_DECAY * 2

/datum/surgery/brain_surgery/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/organ/brain/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
		return !(brain.organ_flags & ORGAN_FAILING) && !CONFIG_GET(flag/brain_permanent_death)

/datum/config_entry/flag/brain_permanent_death

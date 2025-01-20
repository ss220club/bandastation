/obj/item/organ/brain
	var/perma_death = FALSE

/obj/item/organ/brain/Initialize(mapload)
	. = ..()
	var/config_value = CONFIG_GET(number/revival_brain_life)
	if(config_value > 0)
		perma_death = TRUE
	if(perma_death)
		decay_factor = STANDARD_ORGAN_DECAY * config_value

//Убивает игрока при смерти органа
/obj/item/organ/brain/on_death(seconds_per_tick, times_fired)
	. = ..()
	//Если орган мертв и включена пермасмерть
	if(organ_flags & ORGAN_FAILING && perma_death && damage >= maxHealth && !suicided)
		//Сделать ДНР
		var/mob/living/carbon/brain_owner = owner
		if(brainmob)
			// If it's a ling decoy brain, nothing to transfer, just throw it out
			if(decoy_override)
				if(brainmob?.key)
					stack_trace("Decoy override brain with a key assigned - This should never happen.")

			// Not a ling - assume direct control
			else
				if(brain_owner.key)
					brain_owner.ghostize()

				if(brainmob.mind)
					brainmob.mind.transfer_to(brain_owner)
				else
					brain_owner.key = brainmob.key

				brain_owner.set_suicide(HAS_TRAIT(brainmob, TRAIT_SUICIDED))

			QDEL_NULL(brainmob)
		else if(brain_owner)
			brain_owner.set_suicide(TRUE)

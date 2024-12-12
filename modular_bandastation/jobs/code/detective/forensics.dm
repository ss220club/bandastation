// Check for fiberless flag to skip adding fibers
/datum/forensics/add_fibers(mob/living/carbon/human/suspect)
	if(suspect.gloves && (suspect.gloves.clothing_flags & FIBERLESS))
		return FALSE

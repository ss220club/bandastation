/obj/item/bodypart/receive_damage(brute = 0, burn = 0, blocked = 0, updating_health = TRUE, forced = FALSE, required_bodytype = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null, damage_source)
	. = .. ()

	if(brute)
		src.pain += brute * ADVMED_PAIN_APPLICATION_MODIFIER
	if(burn)
		src.pain += burn * ADVMED_PAIN_APPLICATION_MODIFIER * 1.5

	var/mob/living/carbon/human/afflicted = src.loc
	var/damage = 0
	switch(src.body_zone)
		if(BODY_ZONE_HEAD)
			if(!HAS_TRAIT(src, TRAIT_HEAD_INJURY_BLOCKED))
				if(prob(brute))
					damage = brute * 0.5
					afflicted.adjustOrganLoss(ORGAN_SLOT_BRAIN, damage, 200)
					if(afflicted.stat == CONSCIOUS)
						visible_message(
							span_danger("[afflicted] is knocked senseless!"),
							span_userdanger("You're knocked senseless!"),
						)
						afflicted.set_confusion_if_lower(20 SECONDS)
						afflicted.adjust_eye_blur(20 SECONDS)
					if(prob(10))
						var/mob/living/carbon/affected_mob = new (src)
						affected_mob.gain_trauma(/datum/brain_trauma/mild/concussion)
				else
					damage = brute * 0.2
					afflicted.adjustOrganLoss(ORGAN_SLOT_BRAIN, damage, 200)
		if(BODY_ZONE_CHEST)
			if(prob(brute))
				damage =  brute * 0.3
				afflicted.adjustOrganLoss(ORGAN_SLOT_STOMACH, damage, 200)
			else if(prob(brute))
				damage =  brute * 0.2
				afflicted.adjustOrganLoss(ORGAN_SLOT_LUNGS, damage, 200)
			else if(prob(brute))
				damage =  brute * 0.4
				afflicted.adjustOrganLoss(ORGAN_SLOT_LIVER, damage, 200)

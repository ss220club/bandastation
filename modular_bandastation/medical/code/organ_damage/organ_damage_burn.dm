/mob/living/proc/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(!can_adjust_fire_loss(amount, forced, required_bodytype))
		return 0
	. = fireloss
	fireloss = clamp((fireloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	. -= fireloss

	if(BODY_ZONE_CHEST)
		if(prob(amount))
			adjustOrganLoss(ORGAN_SLOT_LUNGS, fireloss * 0.2,required_organ_flag = ORGAN_ORGANIC)

	if(. == 0) // no change, no need to update
		return
	if(updating_health)
		updatehealth()

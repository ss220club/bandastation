/obj/item/organ/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE) //use for damaging effects
	if(!damage_amount) //Micro-optimization.
		return FALSE
	maximum = clamp(maximum, 0, maxHealth) // the logical max is, our max
	if(maximum < damage)
		return FALSE
	if(required_organ_flag && !(organ_flags & required_organ_flag))
		return FALSE
	src.damage = clamp(src.damage + damage_amount, 0, maximum)
	. = (src.prev_damage - src.damage) // return net damage
	var/message = check_damage_thresholds(owner)
	src.prev_damage = src.damage

	if(damage >= maxHealth)
		organ_flags |= ORGAN_FAILING
	else
		organ_flags &= ~ORGAN_FAILING

	if(message && owner && owner.stat <= SOFT_CRIT)
		to_chat(owner, message)

/obj/item/bodypart
	var/pain = 0

/obj/item/organ/internal
	var/pain = 0

/obj/item/organ/adjustOrganScarring(slot)
	var/obj/item/organ/affected_organ = get_organ_slot(slot)
	if(!affected_organ || (status_flags & GODMODE))
		return FALSE
	if(required_organ_flag && !(affected_organ.organ_flags & required_organ_flag))
		return FALSE
	affected_organ.maxHealth = affected_organ.maxHealth - affected_organ.maxHealth * 0.1

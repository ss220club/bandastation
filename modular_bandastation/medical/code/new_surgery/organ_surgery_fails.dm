/datum/surgery_step/lobectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		display_results(
			user,
			target,
			span_warning("You screw up, failing to excise [human_target]'s damaged lobe!"),
			span_warning("[user] screws up!"),
			span_warning("[user] screws up!"),
		)
		display_pain(target, "You feel a sharp stab in your chest; the wind is knocked out of you and it hurts to catch your breath!")
		human_target.losebreath += 4
		human_target.adjustOrganLoss(ORGAN_SLOT_LUNGS, 10)
		human_target.adjustOrganScarring(ORGAN_SLOT_LUNGS)
	return FALSE

/datum/surgery_step/coronary_bypass/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(
			user,
			target,
			span_warning("You screw up in attaching the graft, and it tears off, tearing part of the heart!"),
			span_warning("[user] screws up, causing blood to spurt out of [target_human]'s chest profusely!"),
			span_warning("[user] screws up, causing blood to spurt out of [target_human]'s chest profusely!"),
		)
		display_pain(target, "Your chest burns; you feel like you're going insane!")
		target_human.adjustOrganLoss(ORGAN_SLOT_HEART, 20)
		target_human.adjustOrganScarring(ORGAN_SLOT_HEART)
		var/obj/item/bodypart/target_bodypart = target_human.get_bodypart(target_zone)
		target_bodypart.adjustBleedStacks(30)
	return FALSE

/datum/surgery_step/fix_ears/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_by_type(/obj/item/organ/internal/brain))
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head, into your brain!")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
		target.adjustOrganScarring(ORGAN_SLOT_EARS)
	else
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head!") // dunno who can feel pain w/o a brain but may as well be consistent.
		target.adjustOrganScarring(ORGAN_SLOT_EARS)
	return FALSE

/datum/surgery_step/fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_by_type(/obj/item/organ/internal/brain))
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head, into your brain!")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
		target.adjustOrganScarring(ORGAN_SLOT_EYES)
	else
		display_results(
			user,
			target,
			span_warning("You accidentally stab [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
		)
		display_pain(target, "You feel a visceral stabbing pain right through your head!") // dunno who can feel pain w/o a brain but may as well be consistent.
		target.adjustOrganScarring(ORGAN_SLOT_EYES)
	return FALSE

/datum/surgery_step/gastrectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/target_human = target
	target_human.adjustOrganLoss(ORGAN_SLOT_STOMACH, 15)
	target_human.adjustOrganScarring(ORGAN_SLOT_STOMACH)
	display_results(
		user,
		target,
		span_warning("You cut the wrong part of [target]'s stomach!"),
		span_warning("[user] cuts the wrong part of [target]'s stomach!"),
		span_warning("[user] cuts the wrong part of [target]'s stomach!"),
	)
	display_pain(target, "Your stomach throbs with pain; it's not getting any better!")

/datum/surgery_step/hepatectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/human_target = target
	human_target.adjustOrganLoss(ORGAN_SLOT_LIVER, 15)
	human_target.adjustOrganScarring(ORGAN_SLOT_LIVER)
	display_results(
		user,
		target,
		span_warning("You cut the wrong part of [target]'s liver!"),
		span_warning("[user] cuts the wrong part of [target]'s liver!"),
		span_warning("[user] cuts the wrong part of [target]'s liver!"),
	)
	display_pain(target, "You feel a sharp stab inside your abdomen!")

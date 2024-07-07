#define SURGERY_SLOWDOWN_CAP_MULTIPLIER 2.5
#define SURGERY_SPEED_MORBID_CURIOSITY 0.7
#define SURGERY_STATE_STARTED "surgery_started"
#define SURGERY_STATE_FAILURE "surgery_failed"
#define SURGERY_STATE_SUCCESS "surgery_success"
#define SURGERY_SPEED_DISSECTION_MODIFIER 0.8
#define SURGERY_SPEED_TRAIT_ANALGESIA 0.8

/datum/surgery_step/initiate(mob/living/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	// Only followers of Asclepius have the ability to use Healing Touch and perform miracle feats of surgery.
	// Prevents people from performing multiple simultaneous surgeries unless they're holding a Rod of Asclepius.

	surgery.step_in_progress = TRUE
	var/speed_mod = 1
	var/fail_prob = 0//100 - fail_prob = success_prob
	var/advance = FALSE

	if(preop(user, target, target_zone, tool, surgery) == SURGERY_STEP_FAIL)
		update_surgery_mood(target, SURGERY_STATE_FAILURE)
		surgery.step_in_progress = FALSE
		return FALSE

	update_surgery_mood(target, SURGERY_STATE_STARTED)
	play_preop_sound(user, target, target_zone, tool, surgery) // Here because most steps overwrite preop

	if(tool)
		speed_mod = tool.toolspeed

	if(HAS_TRAIT(target, TRAIT_SURGICALLY_ANALYZED))
		speed_mod *= SURGERY_SPEED_DISSECTION_MODIFIER

	if(check_morbid_curiosity(user, tool, surgery))
		speed_mod *= SURGERY_SPEED_MORBID_CURIOSITY

	if(HAS_TRAIT(target, TRAIT_ANALGESIA))
		speed_mod *= SURGERY_SPEED_TRAIT_ANALGESIA

	var/implement_speed_mod = 1
	if(implement_type) //this means it isn't a require hand or any item step.
		implement_speed_mod = implements[implement_type] / 100.0

	speed_mod /= (get_location_modifier(target) * (1 + surgery.speed_modifier) * implement_speed_mod) * target.mob_surgery_speed_mod
	var/modded_time = time * speed_mod

	var/turf/user_turf = user.loc
	fail_prob = 70
	if(tool)
		fail_prob -= (1/tool.toolspeed) * 10
	else
		fail_prob += 10
	fail_prob = fail_prob - 3 * user_turf.get_lumcount()
	if (HAS_TRAIT(target, TRAIT_ANALGESIA))
		fail_prob -= 30
	else if (target.has_status_effect(/datum/status_effect/painkiller/high))
		fail_prob -= 20
	else if (target.has_status_effect(/datum/status_effect/painkiller/medium))
		fail_prob -= 15
	else if (target.has_status_effect(/datum/status_effect/painkiller/low))
		fail_prob -= 10
	else if (target.get_drunk_amount() > 0)
		fail_prob -= target.get_drunk_amount()/4
	else
		fail_prob += 15
	if (HAS_TRAIT(user, TRAIT_SURGEON_SKILL))
		fail_prob -= 30
	if (HAS_TRAIT(user, TRAIT_PROFESSIONAL_SURGEON))
		fail_prob -= 15

	var/necro_prob = 0
	var/obj/item/clothing/gloves/gloves = user.get_item_by_slot(ITEM_SLOT_HANDS)
	var/obj/item/clothing/mask/mask = user.get_item_by_slot(ITEM_SLOT_MASK)
	if(GET_ATOM_BLOOD_DNA_LENGTH(target.loc))
		necro_prob += 10
	if(isnull(gloves))
		necro_prob += 20
	else
		if(GET_ATOM_BLOOD_DNA_LENGTH(gloves))
			necro_prob += 30
	if(isnull(mask))
		necro_prob += 5
	else
		if(GET_ATOM_BLOOD_DNA_LENGTH(mask))
			necro_prob += 10
	if(GET_ATOM_BLOOD_DNA_LENGTH(tool))
		necro_prob += 30
	if(user.get_item_by_slot() == /obj/item/clothing/mask/surgical)
		necro_prob -= 5
	else
		necro_prob += 5
	if(target.reagents.get_reagent_amount(/datum/reagent/space_cleaner/sterilizine) )
		necro_prob -= 10
	if(target.get_drunk_amount() > 0)
		necro_prob -= 5
	if(HAS_TRAIT(target, TRAIT_ANALGESIA))
		necro_prob -= 10
	necro_prob += (gloves.armor_type.bio / 10)
	necro_prob += (mask.armor_type.bio / 10)

	fail_prob = fail_prob + min(max(0, modded_time - (time * SURGERY_SLOWDOWN_CAP_MULTIPLIER)),99)//if modded_time > time * modifier, then fail_prob = modded_time - time*modifier. starts at 0, caps at 99
	modded_time = min(modded_time, time * SURGERY_SLOWDOWN_CAP_MULTIPLIER)//also if that, then cap modded_time at time*modifier

	if(iscyborg(user))//any immunities to surgery slowdown should go in this check.
		modded_time = time * tool.toolspeed

	var/was_sleeping = (target.stat != DEAD && target.IsSleeping())

	if (prob(necro_prob))
		var/founded_necrosis = FALSE
		var/datum/wound/necrosis/basic_necro/trauma
		var/obj/item/bodypart/limb = target_zone
		var/wounds = limb.wounds
		for(var/limb_wound in wounds)
			var/datum/wound/current_wound = limb_wound
			if(istype(current_wound, /datum/wound/necrosis/basic_necro))
				founded_necrosis = TRUE
				trauma = current_wound
		if (founded_necrosis)
			trauma.necrosing_progress += necro_prob
		else
			var/wound_type = /datum/wound/necrosis/basic_necro/moderate
			var/datum/wound/necrosis/basic_necro/moderate_wound = new wound_type()
			moderate_wound.apply_wound(target_zone,silent = TRUE,wound_source = "during surgery")

	if(do_after(user, modded_time, target = target, interaction_key = user.has_status_effect(/datum/status_effect/hippocratic_oath) ? target : DOAFTER_SOURCE_SURGERY)) //If we have the hippocratic oath, we can perform one surgery on each target, otherwise we can only do one surgery in total.

		var/chem_check_result = chem_check(target)
		if((prob(100-fail_prob) || (iscyborg(user) && !silicons_obey_prob)) && chem_check_result && !try_to_fail)

			if(success(user, target, target_zone, tool, surgery))
				update_surgery_mood(target, SURGERY_STATE_SUCCESS)
				play_success_sound(user, target, target_zone, tool, surgery)
				advance = TRUE
		else
			if(failure(user, target, target_zone, tool, surgery, fail_prob))
				play_failure_sound(user, target, target_zone, tool, surgery)
				update_surgery_mood(target, SURGERY_STATE_FAILURE)
				advance = TRUE
			if(chem_check_result)
				return .(user, target, target_zone, tool, surgery, try_to_fail) //automatically re-attempt if failed for reason other than lack of required chemical
		if(advance && !repeatable)
			surgery.status++
			if(surgery.status > surgery.steps.len)
				surgery.complete(user)

	else if(!QDELETED(target))
		update_surgery_mood(target, SURGERY_STATE_FAILURE)

	if(target.stat == DEAD && was_sleeping && user.client)
		user.client.give_award(/datum/award/achievement/jobs/sandman, user)

	surgery.step_in_progress = FALSE
	return advance

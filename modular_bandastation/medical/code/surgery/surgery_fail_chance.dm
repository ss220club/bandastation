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
	var/fail_prob = 50//100 - fail_prob = success_prob
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
	if(tool)
		fail_prob -= (1/tool.toolspeed) * 10
	else
		fail_prob += 10
	fail_prob -= 3 * user_turf.luminosity()
	if (HAS_TRAIT(target, TRAIT_ANALGESIA))
		fail_prob -= 100

	fail_prob = fail_prob + min(max(0, modded_time - (time * SURGERY_SLOWDOWN_CAP_MULTIPLIER)),99)//if modded_time > time * modifier, then fail_prob = modded_time - time*modifier. starts at 0, caps at 99
	modded_time = min(modded_time, time * SURGERY_SLOWDOWN_CAP_MULTIPLIER)//also if that, then cap modded_time at time*modifier

	if(iscyborg(user))//any immunities to surgery slowdown should go in this check.
		modded_time = time * tool.toolspeed

	var/was_sleeping = (target.stat != DEAD && target.IsSleeping())

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

/datum/surgery_step/proc/get_failure_probability(mob/living/user, mob/living/target, obj/item/tool)
	var/fail_prob = 70
	var/turf/user_turf = user.loc
	if(tool)
		fail_prob -= (1/tool.toolspeed) * 10
	else
		fail_prob += 10
	fail_prob -= 20 * user_turf.get_lumcount()
	if (HAS_TRAIT(target, TRAIT_ANALGESIA))
		fail_prob -= 100

	return fail_prob

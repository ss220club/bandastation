/datum/surgery_step/proc/get_failure_probability(mob/living/user, mob/living/target, obj/item/tool, var/modded_time)
	var/success_prob = implements[implement_type]
	var/turf/user_turf = user.loc
	if(tool)
		success_prob += (1/tool.toolspeed) * 10
	var/light_amount = user_turf.get_lumcount()
	if (light_amount >= 0.6)
		success_prob += clamp(light_amount, 0.6, 1) * 20
	if ((!(target.stat == UNCONSCIOUS || target.IsSleeping()) && target.stat != DEAD) && !HAS_TRAIT(target, TRAIT_ANALGESIA))
		success_prob -= 80
	var/fail_prob = 100 - success_prob
	fail_prob *= modded_time / time

	return fail_prob

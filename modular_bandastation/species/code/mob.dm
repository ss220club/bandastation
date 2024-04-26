/mob/proc/has_mouth()
	return FALSE

/obj/item/reagent_containers/canconsume(mob/eater, mob/user)
	. = ..()
	if(!eater.has_mouth())
		if(eater == user)
			balloon_alert(eater, "you have no mouth")
		else
			balloon_alert(user, "[eater] has no mouth")
		return FALSE

///Checks whether or not the eater can actually consume the food
/datum/component/edible/CanConsume(mob/living/eater, mob/living/feeder)
	if(!iscarbon(eater))
		return FALSE
	var/mob/living/carbon/C = eater
	if(!C.has_mouth())
		return FALSE
	. = ..()

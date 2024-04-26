/mob/living/carbon/has_mouth()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	if(head && head.mouth)
		return TRUE

/mob/living/carbon/vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/toxic, lost_nutrition = 10, distance = 1, purge_ratio = 0.1)
	if(!has_mouth())
		return TRUE

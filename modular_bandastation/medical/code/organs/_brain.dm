/obj/item/organ/brain/Initialize(mapload)
	. = ..()
	var/config_value = CONFIG_GET(number/revival_brain_life)
	if(config_value > 0)
		perma_death = TRUE
	if(perma_death)
		decay_factor = STANDARD_ORGAN_DECAY * config_value

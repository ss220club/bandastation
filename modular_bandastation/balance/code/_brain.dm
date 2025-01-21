/obj/item/organ/brain/Initialize(mapload)
	. = ..()
	var/new_death_time = CONFIG_GET(number/revival_brain_life)
	var/perma_death = CONFIG_GET(flag/brain_permanent_death)
	if(new_death_time)
		var/standart_death_time = 30 MINUTES
		// DА => SDT ; NDR => NDT => DF/SDT = NDT/NDR => NDR = (SDT*NDT)DF
		var/relative_data = standart_death_time / new_death_time
		var/new_decay_rate = relative_data * decay_factor
		decay_factor = new_decay_rate

/datum/config_entry/flag/brain_permanent_death

/datum/wound/burn/flesh/handle_process(seconds_per_tick, times_fired)

	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	. = ..()
	for(var/datum/reagent/reagent as anything in victim.reagents.reagent_list)
		if(reagent.chemical_flags & REAGENT_AFFECTS_WOUNDS)
			reagent.on_burn_wound_processing(src)

	if(HAS_TRAIT(victim, TRAIT_VIRUS_RESISTANCE))
		sanitization += 0.9

	if(limb.current_gauze)
		limb.seep_gauze(WOUND_BURN_SANITIZATION_RATE * seconds_per_tick)

	if(flesh_healing > 0) // good bandages multiply the length of flesh healing
		var/bandage_factor = limb.current_gauze?.burn_cleanliness_bonus || 1
		flesh_damage = max(flesh_damage - (0.5 * seconds_per_tick), 0)
		flesh_healing = max(flesh_healing - (0.5 * bandage_factor * seconds_per_tick), 0) // good bandages multiply the length of flesh healing

	// if we have little/no infection, the limb doesn't have much burn damage, and our nutrition is good, heal some flesh
	if(infestation <= WOUND_INFECTION_MODERATE && (limb.burn_dam < 5) && (victim.nutrition >= NUTRITION_LEVEL_FED))
		flesh_healing += 0.2

	// here's the check to see if we're cleared up
	if((flesh_damage <= 0) && (infestation <= WOUND_INFECTION_MODERATE))
		to_chat(victim, span_green("The burns on your [limb.plaintext_zone] have cleared up!"))
		qdel(src)
		return

	infestation += infestation_rate * seconds_per_tick
	switch(infestation)
		if(0 to WOUND_INFECTION_MODERATE)
			return

		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			if(SPT_PROB(15, seconds_per_tick))
				victim.adjustToxLoss(0.2)
				if(prob(6))
					to_chat(victim, span_warning("The blisters on your [limb.plaintext_zone] ooze a strange pus..."))

		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			if (prob(100) >= 66.6)
				var/wound_type = /datum/wound/necrosis/basic_necro/moderate
				var/datum/wound/necrosis/basic_necro/moderate_wound = new wound_type()
				moderate_wound.apply_wound(limb,silent = TRUE,wound_source = "Burning infection progress")
				moderate_wound.necrosing_progress = 5
			return

		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			if (prob(100) >= 33.3)
				var/wound_type = /datum/wound/necrosis/basic_necro/moderate
				var/datum/wound/necrosis/basic_necro/moderate_wound = new wound_type()
				moderate_wound.apply_wound(limb,silent = TRUE,wound_source = "Burning infection progress")
				moderate_wound.necrosing_progress = 5
			return

		if(WOUND_INFECTION_SEPTIC to INFINITY)
			var/wound_type = /datum/wound/necrosis/basic_necro/severe
			var/datum/wound/necrosis/basic_necro/severe_wound = new wound_type()
			severe_wound.apply_wound(limb,silent = TRUE,wound_source = "Burning infection progress")
			severe_wound.necrosing_progress = 5

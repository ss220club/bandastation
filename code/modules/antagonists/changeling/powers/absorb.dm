/datum/action/changeling/absorb_dna
	name = "Absorb DNA"
	desc = "Поглотить ДНК нашей жертвы. Для поглощения нужно душить их."
	button_icon_state = "absorb_dna"
	chemical_cost = 0
	dna_cost = CHANGELING_POWER_INNATE
	req_human = TRUE
	///if we're currently absorbing, used for sanity
	var/is_absorbing = FALSE

/datum/action/changeling/absorb_dna/can_sting(mob/living/carbon/owner)
	if(!..())
		return

	if(is_absorbing)
		owner.balloon_alert(owner, "уже поглощаем!")
		return

	if(!owner.pulling || !iscarbon(owner.pulling))
		owner.balloon_alert(owner, "нужно взять в захват!")
		return
	if(owner.grab_state <= GRAB_NECK)
		owner.balloon_alert(owner, "нужно усилить захват!")
		return

	var/mob/living/carbon/target = owner.pulling
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(owner)
	return changeling.can_absorb_dna(target)

/datum/action/changeling/absorb_dna/sting_action(mob/owner)
	SHOULD_CALL_PARENT(FALSE) // the only reason to call parent is for proper blackbox logging, and we do that ourselves in a snowflake way

	var/datum/antagonist/changeling/changeling = IS_CHANGELING(owner)
	var/mob/living/carbon/human/target = owner.pulling
	is_absorbing = TRUE

	if(!attempt_absorb(target))
		return

	SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "4"))
	owner.visible_message(span_danger("[owner] sucks the fluids from [target]!"), span_notice("We have absorbed [target]."))
	to_chat(target, span_userdanger("Вы были поглащены генокрадом!"))

	var/true_absorbtion = (!isnull(target.client) || !isnull(target.mind) || !isnull(target.last_mind))
	if (!true_absorbtion)
		to_chat(owner, span_changeling(span_bold("You absorb [target], but their weak DNA is not enough to satisfy your hunger.")))

	if(!changeling.has_profile_with_dna(target.dna))
		changeling.add_new_profile(target)
		if (true_absorbtion)
			changeling.true_absorbs++

	if(owner.nutrition < NUTRITION_LEVEL_WELL_FED)
		owner.set_nutrition(min((owner.nutrition + target.nutrition), NUTRITION_LEVEL_WELL_FED))

	// Absorb a lizard, speak Draconic.
	owner.copy_languages(target, LANGUAGE_ABSORB)

	if(target.mind && owner.mind)//if the victim and owner have minds
		absorb_memories(target)

	is_absorbing = FALSE

	changeling.adjust_chemicals(10)
	if (true_absorbtion)
		changeling.can_respec++

	if(target.stat != DEAD)
		target.investigate_log("has died from being changeling absorbed.", INVESTIGATE_DEATHS)
	target.death(FALSE)
	target.Drain()
	return TRUE

/datum/action/changeling/absorb_dna/proc/absorb_memories(mob/living/carbon/human/target)
	var/datum/mind/suckedbrain = target.mind

	var/datum/antagonist/changeling/changeling = IS_CHANGELING(owner)

	for(var/memory_type in suckedbrain.memories)
		var/datum/memory/stolen_memory = suckedbrain.memories[memory_type]
		changeling.stolen_memories[stolen_memory.name] = stolen_memory.generate_story(STORY_CHANGELING_ABSORB, STORY_FLAG_NO_STYLE)
	suckedbrain.wipe_memory()

	for(var/datum/antagonist/antagonist_datum as anything in suckedbrain.antag_datums)
		var/list/all_objectives = antagonist_datum.objectives.Copy()
		if(antagonist_datum.antag_memory)
			changeling.antag_memory += "[capitalize(target.declent_ru(NOMINATIVE))], воспоминания: [antagonist_datum.antag_memory]."
		if(!LAZYLEN(all_objectives))
			continue
		changeling.antag_memory += " Задачи:"
		var/obj_count = 1
		for(var/datum/objective/objective as anything in all_objectives)
			if(!objective) //nulls? in my objective list? it's more likely than you think.
				continue
			changeling.antag_memory += " Задача #[obj_count++]: [objective.explanation_text]."
			var/list/datum/mind/other_owners = objective.get_owners() - suckedbrain
			if(!other_owners.len)
				continue
			for(var/datum/mind/conspirator as anything in other_owners)
				changeling.antag_memory += " Objective Conspirator: [conspirator.name]."
	changeling.antag_memory += " Это все, что имел [target]. "

	//Some of target's recent speech, so the changeling can attempt to imitate them better.
	//Recent as opposed to all because rounds tend to have a LOT of text.

	var/list/recent_speech = target.copy_recent_speech()

	if(recent_speech.len)
		changeling.antag_memory += "<B>Некоторые образцы речи [target.declent_ru(GENITIVE)], мы должны изучить их, чтобы лучше изображать [target.p_them()]!</B><br>"
		to_chat(owner, span_boldnotice("Некоторые образцы речи [target.declent_ru(GENITIVE)], мы должны изучить их, чтобы лучше изображать [target.p_them()]!"))
		for(var/spoken_memory in recent_speech)
			changeling.antag_memory += "\"[spoken_memory]\"<br>"
			to_chat(owner, span_notice("\"[spoken_memory]\""))
		changeling.antag_memory += "<B>У нас нет больше знаний о образцах речи [target.declent_ru(GENITIVE)].</B><br>"
		to_chat(owner, span_boldnotice("У нас больше нет знаний о образцах речи [target.declent_ru(GENITIVE)]."))


	var/datum/antagonist/changeling/target_ling = IS_CHANGELING(target)
	if(target_ling)//If the target was a changeling, suck out their extra juice and objective points!
		to_chat(owner, span_boldnotice("[capitalize(target.declent_ru(NOMINATIVE))] были одними из нас. Мы поглотили их силу."))

		// Gain half of their genetic points.
		var/genetic_points_to_add = round(target_ling.total_genetic_points / 2)
		changeling.genetic_points += genetic_points_to_add
		changeling.total_genetic_points += genetic_points_to_add

		// And half of their chemical charges.
		var/chems_to_add = round(target_ling.total_chem_storage / 2)
		changeling.adjust_chemicals(chems_to_add)
		changeling.total_chem_storage += chems_to_add

		// And of course however many they've absorbed, we've absorbed
		changeling.absorbed_count += target_ling.absorbed_count

		// Lastly, make them not a ling anymore. (But leave their objectives for round-end purposes).
		var/list/copied_objectives = target_ling.objectives.Copy()
		target.mind.remove_antag_datum(/datum/antagonist/changeling)
		var/datum/antagonist/fallen_changeling/fallen = target.mind.add_antag_datum(/datum/antagonist/fallen_changeling)
		fallen.objectives = copied_objectives

/datum/action/changeling/absorb_dna/proc/attempt_absorb(mob/living/carbon/human/target)
	for(var/absorbing_iteration in 1 to 3)
		switch(absorbing_iteration)
			if(1)
				to_chat(owner, span_notice("Это существо совместимо. Мы должны стоять неподвижно..."))
			if(2)
				owner.visible_message(span_warning("[capitalize(owner.declent_ru(NOMINATIVE))] вытягивает жало-хоботок!"), span_notice("Мы вытягиваем жало-хоботок."))
			if(3)
				owner.visible_message(span_danger("[capitalize(owner.declent_ru(NOMINATIVE))] пронзает [target.declent_ru(ACCUSATIVE)] жалом-хоботком!"), span_notice("Мы пронзаем [target.declent_ru(ACCUSATIVE)] жалом-хоботком."))
				to_chat(target, span_userdanger("Вы чувствуете острую колющую боль!"))
				target.take_overall_damage(40)

		SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "[absorbing_iteration]"))
		if(!do_after(owner, 15 SECONDS, target, hidden = TRUE))
			owner.balloon_alert(owner, "прервано!")
			is_absorbing = FALSE
			return FALSE
	return TRUE

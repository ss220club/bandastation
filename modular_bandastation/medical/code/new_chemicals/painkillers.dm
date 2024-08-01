/datum/reagent/medicine/mine_salve
	name = "Miner's Salve"
	description = "A powerful painkiller. Restores bruising and burns in addition to making the patient believe they are fully healed. Also great for treating severe burn wounds in a pinch."
	reagent_state = LIQUID
	color = "#6D6374"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	ph = 2.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_AFFECTS_WOUNDS
	metabolized_traits = list()

/datum/reagent/medicine/mine_salve/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	var/need_mob_update
	affected_mob.apply_status_effect(/datum/status_effect/painkiller/low)
	need_mob_update = affected_mob.adjustBruteLoss(-0.25 * REM * seconds_per_tick, FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjustFireLoss(-0.25 * REM * seconds_per_tick, FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/morphine
	name = "Morphine"
	description = "A painkiller that allows the patient to move at full speed even when injured. Causes drowsiness and eventually unconsciousness in high doses. Overdose will cause a variety of effects, ranging from minor to lethal."
	reagent_state = LIQUID
	color = "#A9FBFB"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 8.96
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/opioids = 10)
	metabolized_traits = list()

/datum/reagent/medicine/morphine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/painkiller/medium)
	if(current_cycle > 5)
		affected_mob.add_mood_event("numb", /datum/mood_event/narcotic_medium, name)
	switch(current_cycle)
		if(12)
			to_chat(affected_mob, span_warning("You start to feel tired...") )
		if(13 to 25)
			affected_mob.adjust_drowsiness(2 SECONDS * REM * seconds_per_tick)
		if(25 to INFINITY)
			affected_mob.Sleeping(40 * REM * seconds_per_tick)

/datum/reagent/medicine/muscle_stimulant
	name = "Muscle Stimulant"
	description = "A potent chemical that allows someone under its influence to be at full physical ability even when under massive amounts of pain."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	addiction_types = list(/datum/addiction/opioids = 5)
	metabolized_traits = list()

/datum/reagent/medicine/muscle_stimulant/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/painkiller/medium)

/datum/reagent/drug/bath_salts
	name = "Bath Salts"
	description = "Makes you impervious to stuns and grants a stamina regeneration buff, but you will be a nearly uncontrollable tramp-bearded raving lunatic."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 20
	taste_description = "salt" // because they're bathsalts?
	addiction_types = list(/datum/addiction/stimulants = 25)  //8 per 2 seconds
	ph = 8.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STUNIMMUNE, TRAIT_SLEEPIMMUNE, TRAIT_STIMULATED)

/datum/reagent/drug/bath_salts/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/painkiller/high)
	var/high_message = pick("You feel amped up.", "You feel ready.", "You feel like you can push it to the limit.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[high_message]"))
	affected_mob.add_mood_event("salted", /datum/mood_event/stimulant_heavy)
	var/need_mob_update
	need_mob_update = affected_mob.adjustStaminaLoss(-6 * REM * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 4 * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	affected_mob.adjust_hallucinations(10 SECONDS * REM * seconds_per_tick)
	if(need_mob_update)
		. = UPDATE_MOB_HEALTH
	if(!HAS_TRAIT(affected_mob, TRAIT_IMMOBILIZED) && !ismovable(affected_mob.loc))
		step(affected_mob, pick(GLOB.cardinals))
		step(affected_mob, pick(GLOB.cardinals))


/datum/reagent/drug/pumpup
	name = "Pump-Up"
	description = "Take on the world! A fast acting, hard hitting drug that pushes the limit on what you can handle."
	reagent_state = LIQUID
	color = "#e38e44"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	overdose_threshold = 30
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/stimulants = 6) //2.6 per 2 seconds
	metabolized_traits = list(TRAIT_BATON_RESISTANCE, TRAIT_STIMULATED)

/datum/reagent/drug/pumpup/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)
	affected_mob.apply_status_effect(/datum/status_effect/painkiller/high)
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[pick("Go! Go! GO!", "You feel ready...", "You feel invincible...")]"))
	if(SPT_PROB(7.5, seconds_per_tick))
		affected_mob.losebreath++
		affected_mob.adjustToxLoss(2, updating_health = FALSE, required_biotype = affected_biotype)
		return UPDATE_MOB_HEALTH

/datum/reagent/drug/maint/sludge
	name = "Maintenance Sludge"
	description = "An unknown sludge that you most likely gotten from an assistant, a bored chemist... or cooked yourself. Half refined, it fills your body with itself, making it more resistant to wounds, but causes toxins to accumulate."
	reagent_state = LIQUID
	color = "#203d2c"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	overdose_threshold = 25
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/maintenance_drugs = 8)
	metabolized_traits = list(TRAIT_HARDLY_WOUNDED)

/datum/reagent/drug/maint/sludge/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/painkiller/high)
	if(affected_mob.adjustToxLoss(0.5 * REM * seconds_per_tick, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

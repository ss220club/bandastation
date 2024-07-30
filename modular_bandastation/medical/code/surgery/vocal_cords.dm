// Surgery to change TTS voice
/datum/surgery/vocal_cords
	name = "Vocal cords surgery"

	possible_locs = list(BODY_ZONE_PRECISE_MOUTH)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/tune_vocal_cords,
		/datum/surgery_step/close,
	)

/datum/surgery/vocal_cords/can_start(mob/user, mob/living/carbon/target)
	// not sure about tts restrictions
	return ..()

// tune vocal cords
/datum/surgery_step/tune_vocal_cords
	name = "tune vocal cords (scalpel)"
	implements = list(
		TOOL_SCALPEL = 100,
		/obj/item/knife = 50,
		/obj/item/shard = 45,
		/obj/item = 30)
	time = 64


/datum/surgery_step/tune_vocal_cords/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to tune [target]'s vocal cords..."),
		span_notice("[user] begins to tune [target]'s vocal cords."),
		span_notice("[user] begins to perform surgery on [target]'s vocal cords.")
	)

/datum/surgery_step/tune_vocal_cords/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You succeed in tuning [target]'s vocal cords."),
		span_notice("[user] successfully tunes [target]'s vocal cords!"),
		span_notice("[user] completes the surgery on [target]'s vocal cords."),
	)
	target.change_tts_seed(user, TRUE)
	return ..()

/datum/surgery_step/tune_vocal_cords/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_warning("You accidentally stab [target] right in the throat!"),
		span_warning("[user] accidentally stabs [target] right in the throat!"),
		span_warning("[user] accidentally stabs [target] right in the throat!"),
	)
	display_pain(target, "You feel a visceral stabbing pain right into your throat!")
	target.apply_damage(20, BRUTE, BODY_ZONE_HEAD, sharpness=TRUE)
	return FALSE

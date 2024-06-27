/datum/surgery_step/debride
	name = "excise infection (hemostat)"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_SCALPEL = 85,
		TOOL_SAW = 60,
		TOOL_WIRECUTTER = 40)
	time = 30
	repeatable = TRUE
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	failure_sound = 'sound/surgery/organ1.ogg'
	surgery_effects_mood = TRUE

	var/necrosis_removed = 4

/datum/surgery_step/debride/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/necrosis/basic_necro/necro_wound
	var/list_data = target.get_wounded_bodyparts()
	for(var/obj/item/bodypart/limb in (list_data))
		for(var/limb_wound in limb.wounds)
			var/datum/wound/current_wound = limb_wound
			if(istype(current_wound, /datum/wound/necrosis/basic_necro/))
				necro_wound = current_wound
	var/datum/wound/burn/flesh/burn_wound = surgery.operated_wound
	if(burn_wound)
		var/progress_text = get_progress(user, target, burn_wound)
		display_results(
			user,
			target,
			span_notice("You successfully excise some of the infected flesh from [target]'s [target.parse_zone_with_bodypart(target_zone)][progress_text]."),
			span_notice("[user] successfully excises some of the infected flesh from [target]'s [target.parse_zone_with_bodypart(target_zone)] with [tool]!"),
			span_notice("[user] successfully excises some of the infected flesh from  [target]'s [target.parse_zone_with_bodypart(target_zone)]!"),
		)
		log_combat(user, target, "excised infected flesh in", addition="COMBAT MODE: [uppertext(user.combat_mode)]")
		surgery.operated_bodypart.receive_damage(brute=3, wound_bonus=CANT_WOUND)
		burn_wound.infestation -= infestation_removed
		burn_wound.sanitization += sanitization_added
		necro_wound.necrosing_progress -= necrosis_removed
		if(burn_wound.infestation <= 0)
			repeatable = FALSE
	else
		to_chat(user, span_warning("[target] has no infected flesh there!"))
	return ..()

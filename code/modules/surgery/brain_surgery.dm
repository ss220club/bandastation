/datum/surgery/brain_surgery
	name = "Операция на мозге"
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = NONE
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/fix_brain,
		/datum/surgery_step/close,
	)

/datum/surgery_step/fix_brain
	name = "Проведите коррекцию мозговой функции (гемостат)"
	implements = list(
		TOOL_HEMOSTAT = 85,
		TOOL_SCREWDRIVER = 35,
		/obj/item/pen = 15) //don't worry, pouring some alcohol on their open brain will get that chance to 100
	repeatable = TRUE
	time = 100 //long and complicated
	preop_sound = 'sound/surgery/hemostat1.ogg'
	success_sound = 'sound/surgery/hemostat1.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'

/datum/surgery/brain_surgery/can_start(mob/user, mob/living/carbon/target)
	return target.get_organ_slot(ORGAN_SLOT_BRAIN) && ..()

/datum/surgery_step/fix_brain/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете восстанавливать мозг у [target]..."),
		span_notice("[user] начинает восстанавливать мозг у [target]."),
		span_notice("[user] начинает проводить операцию на мозге у [target]."),
	)
	display_pain(target, "Ваша голова раскалывается от невыразимой боли!")

/datum/surgery_step/fix_brain/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("Вы успешно восстановили функции мозга у [target]."),
		span_notice("[user] успешно восстановили функции мозга у [target]!"),
		span_notice("[user] завершает операцию на мозге у [target]."),
	)
	display_pain(target, "Боль в голове утихает, мыслить становится немного легче!")
	if(target.mind?.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	target.setOrganLoss(ORGAN_SLOT_BRAIN, target.get_organ_loss(ORGAN_SLOT_BRAIN) - 50) //we set damage in this case in order to clear the "failing" flag
	target.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(target.get_organ_loss(ORGAN_SLOT_BRAIN) > 0)
		to_chat(user, "Мозг у [target] выглядит так, будто его дальнейшее восстановление возможно.")
	return ..()

/datum/surgery_step/fix_brain/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_slot(ORGAN_SLOT_BRAIN))
		display_results(
			user,
			target,
			span_warning("Вы ошибаетесь, нанеся ещё больше повреждений!"),
			span_warning("[user] ошибается, нанеся повреждения мозгу!"),
			span_notice("[user] завершает операцию на мозге у [target]."),
		)
		display_pain(target, "Голова раскалывается от ужасной боли; от одной мысли об этом уже начинает болеть голова!")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
		target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	else
		user.visible_message(span_warning("[user] внезапно замечает, что мозг над которым велась операция, более не здесь."), span_warning("Вы вдруг замечаете, что мозг, над которым вы работали, более не здесь."))
	return FALSE

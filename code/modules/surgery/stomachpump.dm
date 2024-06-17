/datum/surgery/stomach_pump
	name = "Очистка желудка"
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/stomach_pump,
		/datum/surgery_step/close,
	)

/datum/surgery/stomach_pump/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/stomach/target_stomach = target.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(HAS_TRAIT(target, TRAIT_HUSK))
		return FALSE
	if(!target_stomach)
		return FALSE
	return ..()

//Working the stomach by hand in such a way that you induce vomiting.
/datum/surgery_step/stomach_pump
	name = "промойте желудок (рука)"
	accept_hand = TRUE
	repeatable = TRUE
	time = 20
	success_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/stomach_pump/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете промывать желудок у [target]..."),
		span_notice("[user] начинает промывать желудок у [target]."),
		span_notice("[user] начинает нажимать на грудь [target]."),
	)
	display_pain(target, "Вы чувствуете жуткое бурление в желудке! Вас сейчас вырвет!")

/datum/surgery_step/stomach_pump/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(
			user,
			target,
			span_notice("[user] вызывает рвоту у [target_human], избавляя желудок от некоторых химикатов!"),
			span_notice("[user] вызывает рвоту у [target_human], избавляя желудок от некоторых химикатов!"),
			span_notice("[user] вызывает рвоту у [target_human]!"),
		)
		target_human.vomit((MOB_VOMIT_MESSAGE | MOB_VOMIT_STUN), lost_nutrition = 20, purge_ratio = 0.67) //higher purge ratio than regular vomiting
	return ..()

/datum/surgery_step/stomach_pump/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(
			user,
			target,
			span_warning("Вы ошибаетесь, оставив ушиб на груди [target_human]!"),
			span_warning("[user] ошибается, оставив ушиб на груди [target_human]!"),
			span_warning("[user] ошибается!"),
		)
		target_human.adjustOrganLoss(ORGAN_SLOT_STOMACH, 5)
		target_human.adjustBruteLoss(5)

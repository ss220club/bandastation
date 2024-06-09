
/////BURN FIXING SURGERIES//////

//the step numbers of each of these two, we only currently use the first to switch back and forth due to advancing after finishing steps anyway
#define REALIGN_INNARDS 1
#define WELD_VEINS 2

///// Repair puncture wounds
/datum/surgery/repair_puncture
	name = "Обработка сквозного ранения"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	targetable_wound = /datum/wound/pierce/bleed
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/repair_innards,
		/datum/surgery_step/seal_veins,
		/datum/surgery_step/close,
	)

/datum/surgery/repair_puncture/can_start(mob/living/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return .

	var/datum/wound/pierce/bleed/pierce_wound = target.get_bodypart(user.zone_selected).get_wound_type(targetable_wound)
	ASSERT(pierce_wound, "[type] on [target] has no pierce wound when it should have been guaranteed to have one by can_start")
	return pierce_wound.blood_flow > 0

//SURGERY STEPS

///// realign the blood vessels so we can reweld them
/datum/surgery_step/repair_innards
	name = "восстановление кровеносных сосудов (гемостат)"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_SCALPEL = 85,
		TOOL_WIRECUTTER = 40)
	time = 3 SECONDS
	preop_sound = 'sound/surgery/hemostat1.ogg'

/datum/surgery_step/repair_innards/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/datum/wound/pierce/bleed/pierce_wound = surgery.operated_wound
	if(!pierce_wound)
		user.visible_message(span_notice("[user] ищет у [target] в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i>."), span_notice("Вы ищете у [target] в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i>..."))
		return

	if(pierce_wound.blood_flow <= 0)
		to_chat(user, span_notice("У [target] в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> нет сквозного ранения, которое нуждается в обработке!"))
		surgery.status++
		return

	display_results(
		user,
		target,
		span_notice("Вы начинаете приводить в порядок поврежденные кровеносные сосуды в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> у [target]..."),
		span_notice("[user] начинает приводить в порядок поврежденные кровеносные сосуды в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> у [target] при помощи [tool.name]."),
		span_notice("[user] начинает приводить в порядок поврежденные кровеносные сосуды в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете ужасную колющую боль в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i>!")

/datum/surgery_step/repair_innards/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/pierce/bleed/pierce_wound = surgery.operated_wound
	if(!pierce_wound)
		to_chat(user, span_warning("У [target] нет сквозного ранения, которое нуждается в обработке!"))
		return ..()

	display_results(
		user,
		target,
		span_notice("Вы успешно восстанавливаете некоторые кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] успешно восстанавливает некоторые кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target] при помощи [tool.name]!"),
		span_notice("[user] успешно восстанавливает некоторые кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	log_combat(user, target, "excised infected flesh in", addition="COMBAT MODE: [uppertext(user.combat_mode)]")
	surgery.operated_bodypart.receive_damage(brute=3, wound_bonus=CANT_WOUND)
	pierce_wound.adjust_blood_flow(-0.25)
	return ..()

/datum/surgery_step/repair_innards/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	. = ..()
	display_results(
		user,
		target,
		span_notice("Вы повреждаете некоторые кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] повреждает некоторые кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target] при помощи [tool.name]!"),
		span_notice("[user] повреждает некоторые кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	surgery.operated_bodypart.receive_damage(brute=rand(4,8), sharpness=SHARP_EDGED, wound_bonus = 10)

///// Sealing the vessels back together
/datum/surgery_step/seal_veins
	name = "проведите венозное сваривание (каутеризатор)" // if your doctor says they're going to weld your blood vessels back together, you're either A) on SS13, or B) in grave mortal peril
	implements = list(
		TOOL_CAUTERY = 100,
		/obj/item/gun/energy/laser = 90,
		TOOL_WELDER = 70,
		/obj/item = 30)
	time = 4 SECONDS
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'

/datum/surgery_step/seal_veins/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/datum/surgery_step/seal_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/datum/wound/pierce/bleed/pierce_wound = surgery.operated_wound
	if(!pierce_wound)
		user.visible_message(span_notice("[user] ищет у [target] в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i>."), span_notice("Вы ищете у [target] в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i>..."))
		return
	display_results(
		user,
		target,
		span_notice("Вы начинаете восстанавливать некоторые из поврежденных кровеносных сосудов в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> у [target]..."),
		span_notice("[user] начинает восстанавливать некоторые из поврежденных кровеносных сосудов в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> у [target] при помощи [tool.name]."),
		span_notice("[user] начинает восстанавливать некоторые из поврежденных кровеносных сосудов в <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> у [target]."),
	)
	display_pain(target, "В <i>[target.parse_zone_with_bodypart(user.zone_selected)]</i> все горит!")

/datum/surgery_step/seal_veins/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/pierce/bleed/pierce_wound = surgery.operated_wound
	if(!pierce_wound)
		to_chat(user, span_warning("У [target] нет сквозного ранения!"))
		return ..()

	display_results(
		user,
		target,
		span_notice("Вы успешно восстановили некоторые из поврежденных кровеносных сосудов в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target] при помощи [tool.name]."),
		span_notice("[user] успешно восстановил некоторые из поврежденных кровеносных сосудов в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target] при помощи [tool.name]!"),
		span_notice("[user] успешно восстановил некоторые из поврежденных кровеносных сосудов в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	log_combat(user, target, "dressed burns in", addition="COMBAT MODE: [uppertext(user.combat_mode)]")
	pierce_wound.adjust_blood_flow(-0.5)
	if(pierce_wound.blood_flow > 0)
		surgery.status = REALIGN_INNARDS
		to_chat(user, span_notice("<i>Кажется, что кровеносные сосуды все еще смещены...</i>"))
	else
		to_chat(user, span_green("Вы восстановили все внутренние повреждения в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"))
	return ..()

#undef REALIGN_INNARDS
#undef WELD_VEINS

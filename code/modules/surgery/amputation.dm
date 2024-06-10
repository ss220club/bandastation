
/datum/surgery/amputation
	name = "Ампутация"
	requires_bodypart_type = NONE
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/sever_limb,
	)

/datum/surgery/amputation/can_start(mob/user, mob/living/patient)
	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		return FALSE
	return ..()

/datum/surgery_step/sever_limb
	name = "отрежьте конечность (циркулярная пила)"
	implements = list(
		/obj/item/shears = 300,
		TOOL_SCALPEL = 100,
		TOOL_SAW = 100,
		/obj/item/shovel/serrated = 75,
		/obj/item/melee/arm_blade = 80,
		/obj/item/fireaxe = 50,
		/obj/item/hatchet = 40,
		/obj/item/knife/butcher = 25)
	time = 64
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете отрезать <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает отрезать <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
		span_notice("[user] начинает отрезать <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	display_pain(target, "Вы чувствуете жуткую боль в <i>[parse_zone(target_zone)]</i>!")


/datum/surgery_step/sever_limb/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("Вы отрезали <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] отрезал <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
		span_notice("[user] отрезал <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	display_pain(target, "Вы больше не чувствуете свою отрезанную <i>[target.parse_zone_with_bodypart(target_zone)]</i>!")

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID) && ishuman(user))
		var/mob/living/carbon/human/morbid_weirdo = user
		morbid_weirdo.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
	return ..()

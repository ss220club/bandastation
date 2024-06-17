
//make incision
/datum/surgery_step/incise
	name = "сделайте надрез (скальпель)"
	implements = list(
		TOOL_SCALPEL = 100,
		/obj/item/melee/energy/sword = 75,
		/obj/item/knife = 65,
		/obj/item/shard = 45,
		/obj/item = 30) // 30% success with any sharp item.
	time = 16
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	surgery_effects_mood = TRUE

/datum/surgery_step/incise/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете делать надрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает делать надрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает делать надрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете колющую боль в <i>[target.parse_zone_with_bodypart(target_zone)]</i>.")

/datum/surgery_step/incise/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE

	return TRUE

/datum/surgery_step/incise/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if ishuman(target)
		var/mob/living/carbon/human/human_target = target
		if (!HAS_TRAIT(human_target, TRAIT_NOBLOOD))
			display_results(
				user,
				target,
				span_notice("Вокруг <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [human_target] образуется лужа крови."),
				span_notice("Вокруг <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [human_target] образуется лужа крови."),
				span_notice("Вокруг <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [human_target] образуется лужа крови."),
			)
			var/obj/item/bodypart/target_bodypart = target.get_bodypart(target_zone)
			if(target_bodypart)
				target_bodypart.adjustBleedStacks(10)
	return ..()

/datum/surgery_step/incise/nobleed/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете <i>осторожно</i> делать надрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает <i>осторожно</i> делать надрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает <i>осторожно</i> делать надрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете <i>осторожный</i> колющий удар в <i>[target.parse_zone_with_bodypart(target_zone)]</i>.")

//clamp bleeders
/datum/surgery_step/clamp_bleeders
	name = "зажмите кровеносные сосуды (гемостат)"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_WIRECUTTER = 60,
		/obj/item/stack/package_wrap = 35,
		/obj/item/stack/cable_coil = 15)
	time = 24
	preop_sound = 'sound/surgery/hemostat1.ogg'

/datum/surgery_step/clamp_bleeders/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете зажимать кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает зажимать кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает зажимать кровеносные сосуды в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете укол, послче чего кровотечение в вашей <i>[target.parse_zone_with_bodypart(target_zone)]</i> замедляется.")

/datum/surgery_step/clamp_bleeders/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(locate(/datum/surgery_step/saw) in surgery.steps)
		target.heal_bodypart_damage(20, 0, target_zone = target_zone)
	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_bodypart = human_target.get_bodypart(target_zone)
		if(target_bodypart)
			target_bodypart.adjustBleedStacks(-3)
	return ..()

//retract skin
/datum/surgery_step/retract_skin
	name = "раздвиньте кожу (ретрактор)"
	implements = list(
		TOOL_RETRACTOR = 100,
		TOOL_SCREWDRIVER = 45,
		TOOL_WIRECUTTER = 35,
		/obj/item/stack/rods = 35)
	time = 24
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'

/datum/surgery_step/retract_skin/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете раздвигать кожу в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинаете раздвигать кожу в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинаете раздвигать кожу в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете сильную жгучую боль, распространяющуюся по всей <i>[target.parse_zone_with_bodypart(target_zone)]</i>, по мере того, как кожа возвращается в прежнее состояние!")

//close incision
/datum/surgery_step/close
	name = "закройте разрез (каутеризатор)"
	implements = list(
		TOOL_CAUTERY = 100,
		/obj/item/gun/energy/laser = 90,
		TOOL_WELDER = 70,
		/obj/item = 30) // 30% success with any hot item.
	time = 24
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'

/datum/surgery_step/close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете обрабатывать разрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает обрабатывать разрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает обрабатывать разрез в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Ваша <i>[target.parse_zone_with_bodypart(target_zone)]</i> прижигается!")

/datum/surgery_step/close/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/datum/surgery_step/close/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(locate(/datum/surgery_step/saw) in surgery.steps)
		target.heal_bodypart_damage(45, 0, target_zone = target_zone)
	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_bodypart = human_target.get_bodypart(target_zone)
		if(target_bodypart)
			target_bodypart.adjustBleedStacks(-3)
	return ..()



//saw bone
/datum/surgery_step/saw
	name = "распилите кость (циркулярная пила)"
	implements = list(
		TOOL_SAW = 100,
		/obj/item/shovel/serrated = 75,
		/obj/item/melee/arm_blade = 75,
		/obj/item/fireaxe = 50,
		/obj/item/hatchet = 35,
		/obj/item/knife/butcher = 35,
		/obj/item = 25) //20% success (sort of) with any sharp item with a force >= 10
	time = 54
	preop_sound = list(
		/obj/item/circular_saw = 'sound/surgery/saw.ogg',
		/obj/item/melee/arm_blade = 'sound/surgery/scalpel1.ogg',
		/obj/item/fireaxe = 'sound/surgery/scalpel1.ogg',
		/obj/item/hatchet = 'sound/surgery/scalpel1.ogg',
		/obj/item/knife/butcher = 'sound/surgery/scalpel1.ogg',
		/obj/item = 'sound/surgery/scalpel1.ogg',
	)
	success_sound = 'sound/surgery/organ2.ogg'
	surgery_effects_mood = TRUE

/datum/surgery_step/saw/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете распиливать кость в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает распиливать кость в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает распиливать кость в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете ужасную боль внутри <i>[target.parse_zone_with_bodypart(target_zone)]</i>!")

/datum/surgery_step/saw/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !(tool.get_sharpness() && (tool.force >= 10)))
		return FALSE
	return TRUE

/datum/surgery_step/saw/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	target.apply_damage(50, BRUTE, "[target_zone]", wound_bonus=CANT_WOUND)
	display_results(
		user,
		target,
		span_notice("Вы вскрываете <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] вскрывает <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
		span_notice("[user] вскрывает <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	display_pain(target, "Такое ощущение, что в <i>[target.parse_zone_with_bodypart(target_zone)]</i> что-то сломано!")
	return ..()

//drill bone
/datum/surgery_step/drill
	name = "просверлите кость (хирургическая дрель)"
	implements = list(
		TOOL_DRILL = 100,
		/obj/item/screwdriver/power = 80,
		/obj/item/pickaxe/drill = 60,
		TOOL_SCREWDRIVER = 25,
		/obj/item/kitchen/spoon = 20)
	time = 30

/datum/surgery_step/drill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете сверлить прямо в кости в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает сверлить прямо в кости в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает сверлить прямо в кости в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете ужасную пронзительную боль в <i>[target.parse_zone_with_bodypart(target_zone)]</i>!")

/datum/surgery_step/drill/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("Вы просверлили <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] просверливает <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
		span_notice("[user] просверливает <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	return ..()

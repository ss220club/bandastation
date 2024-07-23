//open shell
/datum/surgery_step/mechanic_open
	name = "unscrew shell (screwdriver or scalpel)"
	implements = list(
		TOOL_SCREWDRIVER = 100,
		TOOL_SCALPEL = 75, // med borgs could try to unscrew shell with scalpel
		/obj/item/knife = 50,
		/obj/item = 10) // 10% success with any sharp item.
	time = 24
	preop_sound = 'sound/items/screwdriver.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете откручивать корпус в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает откручивать корпус в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает откручивать корпус в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы ощущаете, как <i>[target.parse_zone_with_bodypart(target_zone)]</i> немеет по мере откручивания сенсорной панели.", TRUE)

/datum/surgery_step/mechanic_open/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	if(tool.usesound)
		preop_sound = tool.usesound

	return TRUE

//close shell
/datum/surgery_step/mechanic_close
	name = "screw shell (screwdriver or scalpel)"
	implements = list(
		TOOL_SCREWDRIVER = 100,
		TOOL_SCALPEL = 75,
		/obj/item/knife = 50,
		/obj/item = 10) // 10% success with any sharp item.
	time = 24
	preop_sound = 'sound/items/screwdriver.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете закручивать корпус в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает закручивать корпус в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает закручивать корпус в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы ощущаете, как начинаете получать показания датчиков из <i>[target.parse_zone_with_bodypart(target_zone)]</i>, после того, как панель закрутили обратно.", TRUE)

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	if(tool.usesound)
		preop_sound = tool.usesound

	return TRUE

//prepare electronics
/datum/surgery_step/prepare_electronics
	name = "prepare electronics (multitool or hemostat)"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 75)
	time = 24
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете подготовку электроники в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает подготовку электроники в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает подготовку электроники в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете слабое жужжание в <i>[target.parse_zone_with_bodypart(target_zone)]</i>, когда электроника перезагружается.", TRUE)

//unwrench
/datum/surgery_step/mechanic_unwrench
	name = "unwrench bolts (wrench or retractor)"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 75)
	time = 24
	preop_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете откручивать болты в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает откручивать болты в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает откручивать болты в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете вибрацию в <i>[target.parse_zone_with_bodypart(target_zone)]</i>, когда болты начинают ослабевать.", TRUE)

/datum/surgery_step/mechanic_unwrench/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound

	return TRUE

//wrench
/datum/surgery_step/mechanic_wrench
	name = "wrench bolts (wrench or retractor)"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 75)
	time = 24
	preop_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете закручивать болты в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает закручивать болты в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает закручивать болты в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы чувствуете вибрацию в <i>[target.parse_zone_with_bodypart(target_zone)]</i>, когда болты начинают затягиваться.", TRUE)

/datum/surgery_step/mechanic_wrench/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound

	return TRUE

//open hatch
/datum/surgery_step/open_hatch
	name = "открытойте люк (рука)"
	accept_hand = TRUE
	time = 10
	preop_sound = 'sound/items/ratchet.ogg'
	preop_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете открывать держатели люка в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает открывать держатели люка в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает открывать держатели люка в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Вы получаете последние показания датчиков из вашей <i>[target.parse_zone_with_bodypart(target_zone)]</i>, когда открывается люк.", TRUE)

/datum/surgery_step/open_hatch/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound

	return TRUE

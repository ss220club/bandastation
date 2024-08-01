/datum/surgery/cavity_implant
	name = "Полостное имплантирование"
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/handle_cavity,
		/datum/surgery_step/close)

GLOBAL_LIST_INIT(heavy_cavity_implants, typecacheof(list(/obj/item/transfer_valve)))

//handle cavity
/datum/surgery_step/handle_cavity
	name = "вставьте предмет"
	accept_hand = 1
	implements = list(/obj/item = 100)
	repeatable = TRUE
	time = 32
	preop_sound = 'sound/surgery/organ1.ogg'
	success_sound = 'sound/surgery/organ2.ogg'
	var/obj/item/item_for_cavity

/datum/surgery_step/handle_cavity/tool_check(mob/user, obj/item/tool)
	if(tool.tool_behaviour == TOOL_CAUTERY || istype(tool, /obj/item/gun/energy/laser))
		return FALSE
	return !tool.get_temperature()

/datum/surgery_step/handle_cavity/preop(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/chest/target_chest = target.get_bodypart(BODY_ZONE_CHEST)
	item_for_cavity = target_chest.cavity_item
	if(tool)
		display_results(
			user,
			target,
			span_notice("Вы начинаете вставлять [tool.name] в <i>[target_zone]</i> у [target]..."),
			span_notice("[user] начинает вставлять [tool.name] в <i>[target_zone]</i> у [target]."),
			span_notice("[user] начинает вставлять [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "что-то"] в <i>[target_zone]</i> у [target]."),
		)
		display_pain(target, "Вы чувствуете, как что-то вставляют в ваш <i>[target_zone]</i>, это чертовски больно!")
	else
		display_results(
			user,
			target,
			span_notice("Вы проверяете на наличие предметов в <i>[target_zone]</i> у [target]..."),
			span_notice("[user] проверяет на наличие предметов в <i>[target_zone]</i> у [target]."),
			span_notice("[user] ищет что-то в <i>[target_zone]</i> [target]."),
		)

/datum/surgery_step/handle_cavity/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery = FALSE)
	var/obj/item/bodypart/chest/target_chest = target.get_bodypart(BODY_ZONE_CHEST)
	if(tool)
		if(item_for_cavity || ((tool.w_class > WEIGHT_CLASS_NORMAL) && !is_type_in_typecache(tool, GLOB.heavy_cavity_implants)) || HAS_TRAIT(tool, TRAIT_NODROP) || isorgan(tool))
			to_chat(user, span_warning("Кажется, вы не можете поместить [tool.name] в <i>[target_zone]</i> у [target]!"))
			return FALSE
		else
			display_results(
				user,
				target,
				span_notice("Вы помещаете [tool.name] в <i>[target_zone]</i> у [target]."),
				span_notice("[user] помещает [tool.name] в <i>[target_zone]</i> у [target]!"),
				span_notice("[user] помещает [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "что-то"] в <i>[target_zone]</i> у [target]."),
			)
			user.transferItemToLoc(tool, target, TRUE)
			target_chest.cavity_item = tool
			return ..()
	else
		if(item_for_cavity)
			display_results(
				user,
				target,
				span_notice("Вы вытягиваете [item_for_cavity] из <i>[target_zone]</i> у [target]."),
				span_notice("[user] вытягивает [item_for_cavity] из <i>[target_zone]</i> у [target]!"),
				span_notice("[user] вытягивает [item_for_cavity.w_class > WEIGHT_CLASS_SMALL ? item_for_cavity : "что-то"] из <i>[target_zone]</i> у [target]."),
			)
			display_pain(target, "Что-то вытащили из вашей <i>[target_zone]</i>! Это чертовски больно!")
			user.put_in_hands(item_for_cavity)
			target_chest.cavity_item = null
			return ..()
		else
			to_chat(user, span_warning("Вы не нашли ничего в <i>[target_zone]</i> у [target]."))
			return FALSE

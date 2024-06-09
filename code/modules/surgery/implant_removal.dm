/datum/surgery/implant_removal
	name = "Извлечение имплантов"
	target_mobtypes = list(/mob/living)
	possible_locs = list(BODY_ZONE_CHEST)
	surgery_flags = SURGERY_REQUIRE_RESTING
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/extract_implant,
		/datum/surgery_step/close,
	)

//extract implant
/datum/surgery_step/extract_implant
	name = "извлеките имплант (гемостат)"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_CROWBAR = 65,
		/obj/item/kitchen/fork = 35)
	time = 64
	success_sound = 'sound/surgery/hemostat1.ogg'
	var/obj/item/implant/implant

/datum/surgery_step/extract_implant/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/object in target.implants)
		implant = object
		break
	if(implant)
		display_results(
			user,
			target,
			span_notice("Вы начинаете извлекать [implant] из <i>[target_zone]</i> у [target]..."),
			span_notice("[user] начинает извлекать [implant] из <i>[target_zone]</i> у [target]."),
			span_notice("[user] начинает что-то извлекать из <i>[target_zone]</i> у [target]."),
		)
		display_pain(target, "Вы чуствуете острую боль в <i>[target_zone]</i>!")
	else
		display_results(
			user,
			target,
			span_notice("Вы ищете имплант в <i>[target_zone]</i> у [target]..."),
			span_notice("[user] ищет имплант в <i>[target_zone]</i> у [target]."),
			span_notice("[user] ищет что-то в <i>[target_zone]</i> у [target]."),
		)

/datum/surgery_step/extract_implant/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(implant)
		display_results(
			user,
			target,
			span_notice("Вы успешно извлекли [implant] из <i>[target_zone]</i> у [target]."),
			span_notice("[user] успешно извлек [implant] из <i>[target_zone]</i> у [target]!"),
			span_notice("[user] успешно извлек что-то из <i>[target_zone]</i> у [target]!"),
		)
		display_pain(target, "Вы чувствуете, как [implant.name] извлекли из вас!")
		implant.removed(target)

		if (QDELETED(implant))
			return ..()

		var/obj/item/implantcase/case
		for(var/obj/item/implantcase/implant_case in user.held_items)
			case = implant_case
			break
		if(!case)
			case = locate(/obj/item/implantcase) in get_turf(target)
		if(case && !case.imp)
			case.imp = implant
			implant.forceMove(case)
			case.update_appearance()
			display_results(
				user,
				target,
				span_notice("Вы помещаете [implant] в [case]."),
				span_notice("[user] помещает [implant] в [case]!"),
				span_notice("[user] помещает что-то в [case]!"),
			)
		else
			qdel(implant)

	else
		to_chat(user, span_warning("Вы не можете найти ничего в <i>[target_zone]</i> у [target]!"))
	return ..()

/datum/surgery/implant_removal/mechanic
	name = "Удаление имплантов"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	target_mobtypes = list(/mob/living/carbon/human) // Simpler mobs don't have bodypart types
	surgery_flags = parent_type::surgery_flags | SURGERY_REQUIRE_LIMB
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/extract_implant,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close)

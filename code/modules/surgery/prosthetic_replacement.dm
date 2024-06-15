/datum/surgery/prosthetic_replacement
	name = "Замена протеза"
	surgery_flags = NONE
	requires_bodypart_type = NONE
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
		/datum/surgery_step/add_prosthetic,
	)

/datum/surgery/prosthetic_replacement/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	if(!iscarbon(target))
		return FALSE
	var/mob/living/carbon/carbon_target = target
	if(!carbon_target.get_bodypart(user.zone_selected)) //can only start if limb is missing
		return TRUE
	return FALSE



/datum/surgery_step/add_prosthetic
	name = "установите протез"
	implements = list(
		/obj/item/bodypart = 100,
		/obj/item/borg/apparatus/organ_storage = 100,
		/obj/item/chainsaw = 100,
		/obj/item/melee/synthetic_arm_blade = 100)
	time = 32
	var/organ_rejection_dam = 0

/datum/surgery_step/add_prosthetic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/borg/apparatus/organ_storage))
		if(!tool.contents.len)
			to_chat(user, span_warning("Внутри [tool.name] ничего нет!"))
			return SURGERY_STEP_FAIL
		var/obj/item/organ_storage_contents = tool.contents[1]
		if(!isbodypart(organ_storage_contents))
			to_chat(user, span_warning("[organ_storage_contents] не может быть прикреплен!"))
			return SURGERY_STEP_FAIL
		tool = organ_storage_contents
	if(isbodypart(tool))
		var/obj/item/bodypart/bodypart_to_attach = tool
		if(IS_ORGANIC_LIMB(bodypart_to_attach))
			organ_rejection_dam = 10
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				var/obj/item/bodypart/chest/target_chest = human_target.get_bodypart(BODY_ZONE_CHEST)
				if((!(bodypart_to_attach.bodyshape & target_chest.acceptable_bodyshape)) && (!(bodypart_to_attach.bodytype & target_chest.acceptable_bodytype)))
					to_chat(user, span_warning("[bodypart_to_attach] не соответствует патологии пациента."))
					return SURGERY_STEP_FAIL
				if(bodypart_to_attach.check_for_frankenstein(target))
					organ_rejection_dam = 30

			if(!bodypart_to_attach.can_attach_limb(target))
				target.balloon_alert(user, "это не подходит к <i>[target.parse_zone_with_bodypart(target_zone)]</i>!")
				return SURGERY_STEP_FAIL

		if(target_zone == bodypart_to_attach.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
			display_results(
				user,
				target,
				span_notice("Вы начинаете заменять <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target] на [tool.name]..."),
				span_notice("[user] начинает заменять <i>[target.parse_zone_with_bodypart(target_zone)]</i> у <i>[target.parse_zone_with_bodypart(target_zone)]</i> на [tool.name]."),
				span_notice("[user] начинает заменять <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
			)
		else
			to_chat(user, span_warning("[tool.name] не подходит для <i>[target.parse_zone_with_bodypart(target_zone)]</i>."))
			return SURGERY_STEP_FAIL
	else if(target_zone == BODY_ZONE_L_ARM || target_zone == BODY_ZONE_R_ARM)
		display_results(
			user,
			target,
			span_notice("Вы начинаете прикреплять [tool.name] к [target]..."),
			span_notice("[user] начинает прикреплять [tool.name] к <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
			span_notice("[user] начинает прикреплять что-то к <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		)
	else
		to_chat(user, span_warning("[tool.name] должен быть установлен в руку."))
		return SURGERY_STEP_FAIL

/datum/surgery_step/add_prosthetic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(istype(tool, /obj/item/borg/apparatus/organ_storage))
		tool.icon_state = initial(tool.icon_state)
		tool.desc = initial(tool.desc)
		tool.cut_overlays()
		tool = tool.contents[1]
	if(isbodypart(tool) && user.temporarilyRemoveItemFromInventory(tool))
		var/obj/item/bodypart/bodypart_to_attach = tool
		bodypart_to_attach.try_attach_limb(target)
		if(bodypart_to_attach.check_for_frankenstein(target))
			bodypart_to_attach.bodypart_flags |= BODYPART_IMPLANTED
		if(organ_rejection_dam)
			target.adjustToxLoss(organ_rejection_dam)
		display_results(
			user,
			target,
			span_notice("Вы успешно заменили <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
			span_notice("[user] успешно заменил <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target] на [tool.name]!"),
			span_notice("[user] успешно заменил <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
		)
		display_pain(target, "Вы наполняетесь позитивными ощущениями, потому что вы снова чувствуете ваш <i>[target.parse_zone_with_bodypart(target_zone)]</i>!", TRUE)
		return
	else
		var/obj/item/bodypart/bodypart_to_attach = target.newBodyPart(target_zone, FALSE, FALSE)
		bodypart_to_attach.try_attach_limb(target)
		bodypart_to_attach.bodypart_flags |= BODYPART_PSEUDOPART | BODYPART_IMPLANTED
		user.visible_message(span_notice("[user] заканчивает прикреплять [tool.name]!"), span_notice("Вы прикрепили [tool.name]."))
		display_results(
			user,
			target,
			span_notice("Вы прикрепили [tool.name]."),
			span_notice("[user] заканчивает прикреплять [tool.name]!"),
			span_notice("[user] завершает операцию по прикреплению!"),
		)
		display_pain(target, "Вы испытываете странные ощущения от своего нового <i>[target.parse_zone_with_bodypart(target_zone)]</i>.", TRUE)
		if(istype(tool, /obj/item/chainsaw))
			qdel(tool)
			var/obj/item/chainsaw/mounted_chainsaw/new_arm = new(target)
			target_zone == BODY_ZONE_R_ARM ? target.put_in_r_hand(new_arm) : target.put_in_l_hand(new_arm)
			return
		else if(istype(tool, /obj/item/melee/synthetic_arm_blade))
			qdel(tool)
			var/obj/item/melee/arm_blade/new_arm = new(target,TRUE,TRUE)
			target_zone == BODY_ZONE_R_ARM ? target.put_in_r_hand(new_arm) : target.put_in_l_hand(new_arm)
			return
	return ..() //if for some reason we fail everything we'll print out some text okay?

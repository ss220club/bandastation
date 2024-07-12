#define MARK_TOOTH 1

/datum/surgery/dental_implant
	name = "Зубное имплантирование"
	possible_locs = list(BODY_ZONE_PRECISE_MOUTH)
	steps = list(
		/datum/surgery_step/drill/pill,
		/datum/surgery_step/insert_pill,
		/datum/surgery_step/search_teeth,
		/datum/surgery_step/close,
	)

/datum/surgery_step/drill/pill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	var/count = 0
	var/obj/item/bodypart/head/teeth_receptangle = target.get_bodypart(BODY_ZONE_HEAD)

	ASSERT(teeth_receptangle)

	for(var/obj/item/reagent_containers/pill/dental in teeth_receptangle)
		count++

	if(teeth_receptangle.teeth_count == 0)
		to_chat(user, span_notice("[user] has no teeth, doofus!"))
		return SURGERY_STEP_FAIL

	if(count >= teeth_receptangle.teeth_count)
		to_chat(user, span_notice("[user]'s teeth have all been replaced with pills already!"))
		return SURGERY_STEP_FAIL

/datum/surgery_step/insert_pill
	name = "вставьте таблетку"
	implements = list(/obj/item/reagent_containers/pill = 100)
	time = 16

/datum/surgery_step/insert_pill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)

	display_results(
		user,
		target,
		span_notice("Вы начинаете вставлять [tool.name] в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]..."),
		span_notice("[user] начинает вставлять [tool.name] в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] начинает вставлять что-то в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
	)
	display_pain(target, "Что-то засовывают вам в <i>[target.parse_zone_with_bodypart(target_zone)]</i>!")

/datum/surgery_step/insert_pill/success(mob/user, mob/living/carbon/target, target_zone, obj/item/reagent_containers/pill/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(!istype(tool))
		return FALSE

	// Pills go into head
	user.transferItemToLoc(tool, target.get_bodypart(BODY_ZONE_HEAD), TRUE)

	var/datum/action/item_action/activate_pill/pill_action = new(tool)
	pill_action.name = "Активируйте [tool.name]"
	pill_action.build_all_button_icons()
	pill_action.target = tool
	pill_action.Grant(target) //The pill never actually goes in an inventory slot, so the owner doesn't inherit actions from it

	display_results(
		user,
		target,
		span_notice("Вы вставили [tool.name] в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]."),
		span_notice("[user] вставил [tool.name] в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
		span_notice("[user] вставил что-то в <i>[target.parse_zone_with_bodypart(target_zone)]</i> у [target]!"),
	)
	return ..()

/datum/action/item_action/activate_pill
	name = "Активировать таблетку"
	check_flags = NONE

/datum/action/item_action/activate_pill/IsAvailable(feedback)
	if(owner.stat > SOFT_CRIT)
		return FALSE
	return ..()

/datum/action/item_action/activate_pill/Trigger(trigger_flags)
	if(!..())
		return FALSE
	owner.balloon_alert_to_viewers("[owner] grinds their teeth!", "You grit your teeth.")
	if(!do_after(owner, owner.stat * (2.5 SECONDS), owner,  IGNORE_USER_LOC_CHANGE | IGNORE_INCAPACITATED))
		return FALSE
	var/obj/item/item_target = target
	to_chat(owner, span_notice("Вы стискиваете зубы и ломаете вживленный [item_target.name]!"))
	owner.log_message("проглотил вживленную таблетку, [target]", LOG_ATTACK)
	if(item_target.reagents.total_volume)
		item_target.reagents.trans_to(owner, item_target.reagents.total_volume, transferred_by = owner, methods = INGEST)
	qdel(target)
	return TRUE

/datum/surgery_step/search_teeth
	name = "search teeth (hand)"
	accept_hand = TRUE
	time = 2 SECONDS
	repeatable = TRUE

/datum/surgery_step/search_teeth/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin looking in [target]'s mouth for implantable teeth..."),
		span_notice("[user] begins to look in [target]'s mouth."),
		span_notice("[user] begins to examine [target]'s teeth."),
	)
	display_pain(target, "You feel fingers poke around at your teeth.")

/datum/surgery_step/search_teeth/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("[user] marks a tooth in [target]'s mouth."),
		span_notice("[user] marks a tooth in [target]'s mouth."),
		span_notice("[user] prods a tooth in [target]'s mouth."),
	)
	surgery.status = MARK_TOOTH
	return ..()

#undef MARK_TOOTH

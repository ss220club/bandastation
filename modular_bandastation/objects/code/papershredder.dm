/obj/item
	var/can_be_papershredded = FALSE
	var/shredded_paper_amount

/obj/item/photo
	can_be_papershredded = TRUE
	shredded_paper_amount = 1

/obj/item/paper
	can_be_papershredded = TRUE
	shredded_paper_amount = 1

/obj/item/paper/paperslip/corporate
	can_be_papershredded = FALSE

/obj/item/newspaper
	can_be_papershredded = TRUE
	shredded_paper_amount = 3

/obj/item/shredded_paper
	can_be_papershredded = TRUE
	shredded_paper_amount = 1

/obj/item/folder
	can_be_papershredded = TRUE
	shredded_paper_amount = 4

/obj/item/book
	can_be_papershredded = TRUE
	shredded_paper_amount = 5

/obj/machinery/papershredder
	name = "\improper paper shredder"
	desc = "Для тех документов, что вы не хотите видеть."
	icon = 'modular_bandastation/objects/icons/papershredder.dmi'
	icon_state = "papershredder0"
	density = TRUE
	anchored = TRUE
	var/max_paper = 15
	var/paper_amount = 0

/obj/machinery/papershredder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, rmb_text = "Опустошить корзину с измельчённой бумагой")
	register_context()

/obj/machinery/papershredder/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "Открутить" : "Прикрутить"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.can_be_papershredded)
		context[SCREENTIP_CONTEXT_LMB] = "Измельчить [held_item.declent_ru(ACCUSATIVE)]"
		return CONTEXTUAL_SCREENTIP_SET
	return NONE

/obj/machinery/papershredder/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	empty_contents(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/papershredder/attackby(obj/item/item, mob/user, params)
	if(!item.can_be_papershredded)
		user.balloon_alert(user, "невозможно измельчить!")
		return ..()
	if(paper_amount == max_paper)
		to_chat(user, span_warning("[capitalize(declent_ru(NOMINATIVE))] полон. Пожалуйста, опустошите его прежде чем продолжить."))
		return
	var/paper_result = item.shredded_paper_amount
	paper_amount += paper_result
	qdel(item)
	playsound(loc, 'modular_bandastation/objects/sounds/pshred.ogg', 75, 1)
	update_icon_state()
	add_fingerprint(user)

/obj/machinery/papershredder/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/papershredder/examine(mob/user)
	. = ..()
	. += span_info("Нажмите <b>ПКМ</b> чтобы опустошить [src.declent_ru(ACCUSATIVE)].")

/obj/machinery/papershredder/proc/empty_contents(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_RESTRAINED))
		to_chat(user, span_warning("Вам нужны свободные руки, чтобы сделать это."))
		return

	if(!paper_amount)
		to_chat(user, span_notice("[capitalize(src.declent_ru(NOMINATIVE))] пуст."))
		return

	get_shredded_paper()
	update_icon_state()

/obj/machinery/papershredder/proc/get_shredded_paper()
	if(!paper_amount)
		return
	paper_amount--
	return new /obj/item/shredded_paper(get_turf(src))

/obj/machinery/papershredder/update_icon_state()
	icon_state = "papershredder[clamp(round(paper_amount/3), 0, 5)]"
	return ..()

/obj/item/shredded_paper
	name = "shredded paper"
	icon = 'modular_bandastation/objects/icons/papershredder.dmi'
	icon_state = "shredp"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	layer = BELOW_MOB_LAYER
	max_integrity = 25
	throw_range = 3
	throw_speed = 2

/obj/item/shredded_paper/Initialize()
	. = ..()
	if(prob(65))
		color = pick("#8b8b8b","#e7e4e4", "#c9c9c9")

/obj/item/shredded_paper/attackby(obj/item/attacking_item, mob/user, params)
	if(burn_paper_product_attackby_check(attacking_item, user))
		return
	. = ..()

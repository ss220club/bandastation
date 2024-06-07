/obj/machinery/papershredder
	name = "paper shredder"
	desc = "For those documents you don't want seen."
	icon = 'modular_bandastation/objects/icons/papershredder.dmi'
	icon_state = "papershredder0"
	density = TRUE
	anchored = TRUE
	var/max_paper = 15
	var/paperamount = 0
	var/list/shred_amounts = list(
		/obj/item/photo = 1,
		/obj/item/shredded_paper = 1,
		/obj/item/paper = 1,
		/obj/item/newspaper = 3,
		/obj/item/card/id = 3,
		/obj/item/folder = 4,
		/obj/item/book = 5
		)

/obj/machinery/papershredder/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/storage))
		add_fingerprint(user)
		empty_bin(user, item)
		return
	var/paper_result
	if(item.type in shred_amounts)
		paper_result = shred_amounts[item.type]
	if(!paper_result)
		. = ..()
		return
	if(paperamount == max_paper)
		to_chat(user, span_warning("[src] is full; please empty it before you continue."))
		return
	paperamount += paper_result
	qdel(item)
	playsound(loc, 'modular_bandastation/objects/sounds/pshred.ogg', 75, 1)
	if(paperamount > max_paper)
		to_chat(user, span_danger("[src] was too full, and shredded paper goes everywhere!"))
		for(var/i in 1 to paperamount-max_paper)
			var/obj/item/shredded_paper/shredp = get_shredded_paper()
			shredp.loc = get_turf(src)
			shredp.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), 1, 1)
		paperamount = max_paper
	update_icon()
	add_fingerprint(user)

/obj/machinery/papershredder/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/papershredder/examine(mob/user)
	. = ..()
	. += span_notice("<b>Alt-Click</b> to empty [src].")

/obj/machinery/papershredder/click_alt(mob/user)
	. = ..()
	empty_contents(user)

/obj/machinery/papershredder/proc/empty_contents(mob/user)
	if(HAS_TRAIT(user, TRAIT_RESTRAINED))
		to_chat(user, span_notice("You need your hands free for this."))
		return

	if(!paperamount)
		to_chat(user, span_notice("[src] is empty."))
		return

	empty_bin(user)

/obj/machinery/papershredder/proc/empty_bin(mob/living/user, obj/item/storage/empty_into, /datum/storage/content)

	// Sanity.
	if(empty_into && !istype(empty_into))
		empty_into = null

	if(empty_into.contents >= empty_into.atom_storage.max_total_storage)
		user.balloon_alert(user, "[empty_into] is full.")
		return

	while(paperamount)
		var/obj/item/shredded_paper/SP = get_shredded_paper()
		if(!SP)
			break
		if(empty_into)
			empty_into.atom_storage.dump_content_at(empty_into)
	if(empty_into)
		if(paperamount)
			to_chat(user, span_notice("You fill [empty_into] with as much shredded paper as it will carry."))
		else
			to_chat(user, span_notice("You empty [src] into [empty_into]."))

	else
		to_chat(user, span_notice("You empty [src]."))
	update_icon()

/obj/machinery/papershredder/proc/get_shredded_paper()
	if(!paperamount)
		return
	paperamount--
	return new /obj/item/shredded_paper(get_turf(src))

/obj/machinery/papershredder/update_icon_state()
	icon_state = "papershredder[clamp(round(paperamount/3), 0, 5)]"
	return ..()

/obj/item/shredded_paper/attackby(obj/item/shredp as obj, mob/user)
	if(HAS_TRAIT(shredp, ON_FIRE))
		add_fingerprint(user)
		user.visible_message(
			span_danger("\The [user] burns right through [src.name], turning it to ash. It flutters through the air before settling on the floor in a heap."),
			span_danger("You burn right through [src.name], turning it to ash. It flutters through the air before settling on the floor in a heap."))
		fire_act()
	else
		..()

/obj/item/shredded_paper
	name = "shredded paper"
	icon = 'modular_bandastation/objects/icons/papershredder.dmi'
	icon_state = "shredp"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	layer = 4
	max_integrity = 25
	throw_range = 3
	throw_speed = 2

/obj/item/shredded_paper/Initialize()
	. = ..()
	if(prob(65))
		color = pick("#8b8b8b","#e7e4e4", "#c9c9c9")

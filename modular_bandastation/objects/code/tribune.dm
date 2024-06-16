/obj/structure/tribune
	name = "tribune"
	icon = 'modular_bandastation/objects/icons/tribune.dmi'
	icon_state = "nt_tribune"
	desc = "A sturdy wooden tribune. When you look at it, you want to start making a speech."
	density = TRUE
	anchored = FALSE
	max_integrity = 100
	resistance_flags = FLAMMABLE
	can_buckle = TRUE
	flags_1 = ON_BORDER_1
	var/buildstacktype = /obj/item/stack/sheet/mineral/wood
	var/buildstackamount = 5

/obj/structure/tribune/wrench_act(mob/user, obj/item/tool)
	. = TRUE
	default_unfasten_wrench(user, tool)

/obj/structure/tribune/screwdriver_act(mob/user, obj/item/tool)
	. = TRUE
	if(obj_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("Try as you might, you can't figure out how to deconstruct [src]."))
		return
	to_chat(user, span_notice("You start disassembling [src]..."))
	if(tool.use_tool(src, user, 2 SECONDS, volume=50))
		deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/tribune/atom_deconstruct(disassembled = TRUE)
	. = ..()
	var/turf/target_turf = get_turf(src)
	if(buildstacktype)
		new buildstacktype(target_turf, buildstackamount)

/obj/structure/tribune/proc/after_rotation(mob/user)
	add_fingerprint(user)

/obj/structure/tribune/Initialize(mapload) //Only for mappers
	..()
	handle_layer()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)

	if(flags_1 & ON_BORDER_1)
		AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/tribune/setDir(newdir)
	..()
	handle_layer()

/obj/structure/tribune/Move(newloc, direct, movetime)
	. = ..()
	handle_layer()

/obj/structure/tribune/proc/handle_layer()
	if(dir == NORTH)
		layer = LOW_OBJ_LAYER
	else
		layer = ABOVE_MOB_LAYER

/obj/structure/tribune/click_alt(mob/user)
	. = ..()
	if(!Adjacent(user))
		return
	if(anchored)
		to_chat(user, span_warning("It is fastened to the floor!"))
		return
	setDir(turn(dir, 90))
	after_rotation(user)

/obj/structure/tribune/proc/can_be_reached(mob/user)
	var/checking_dir = get_dir(user, src)
	if(!(checking_dir & dir))
		return TRUE
	checking_dir = REVERSE_DIR(checking_dir)
	for(var/obj/blocker in loc)
		if(!blocker.CanPass(user, checking_dir))
			return FALSE
	return TRUE

/obj/structure/tribune/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
	return TRUE

/obj/structure/tribune/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(!(to_dir & dir))
		return TRUE
	return ..()

/obj/structure/tribune/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving.movement_type & PHASING)
		return

	if(leaving == src)
		return // Let's not block ourselves.

	if (leaving.pass_flags & pass_flags_self)
		return

	if(direction == dir && density)
		leaving.Bump(src)
		return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/tribune/centcom
	name = "CentCom tribune"
	icon_state = "nt_tribune_cc"
	desc = "A richly decorated tribune. Just looking at her makes your heart skip a beat."
	obj_flags = INDESTRUCTIBLE

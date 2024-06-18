// Tribune
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

// Platform
/obj/structure/platform
	name = "platform"
	icon = 'modular_bandastation/objects/icons/platform.dmi'
	icon_state = "metal"
	desc = "A metal platform."
	flags_1 = ON_BORDER_1
	density = TRUE
	anchored = TRUE
	var/climbable = TRUE
	max_integrity = 200
	armor_type = /datum/armor/structure_platform
	var/corner = FALSE
	var/material_type = /obj/item/stack/sheet/iron
	var/material_amount = 4
	var/decon_speed

/datum/armor/structure_platform
	melee = 10
	bullet = 10
	laser = 10
	energy = 50
	bomb = 20
	fire = 30
	acid = 30

/obj/structure/platform/Initialize()
	. = ..()
	if(climbable)
		AddElement(/datum/element/climbable)

/obj/structure/platform/proc/CheckLayer()
	if(dir == SOUTH)
		layer = ABOVE_MOB_LAYER
	else if(corner || dir == NORTH)
		layer = BELOW_MOB_LAYER

/obj/structure/platform/setDir(newdir)
	. = ..()
	CheckLayer()

/obj/structure/platform/Initialize()
	. = ..()
	CheckLayer()
	if(density && flags_1 & ON_BORDER_1) // blocks normal movement from and to the direction it's facing.
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/platform/New()
	..()
	if(corner)
		decon_speed = 20
		density = FALSE
		climbable = FALSE
	else
		decon_speed = 30
	CheckLayer()

/obj/structure/platform/examine(mob/user)
	. = ..()
	. += span_notice("[src] is [anchored == TRUE ? "screwed" : "unscrewed"] [anchored == TRUE ? "to" : "from"] the floor.")
	. += span_notice("<b>Alt-Click</b> to rotate.")

/obj/structure/platform/proc/rotate(mob/user)
	if(user.incapacitated())
		return

	if(anchored)
		to_chat(user, span_warning("[src] cannot be rotated while it is screwed to the floor!"))
		return FALSE

	var/target_dir = turn(dir, 90)

	setDir(target_dir)
	air_update_turf(1)
	add_fingerprint(user)
	return TRUE

/obj/structure/platform/click_alt(mob/user)
	. = ..()
	rotate(user)

// Construction
/obj/structure/platform/screwdriver_act(mob/user, obj/item/I)
	. = TRUE
	to_chat(user, span_notice("You begin [anchored == TRUE ? "unscrewing" : "screwing"] [src.name] [anchored == TRUE ? "from" : "to"] to the floor..."))
	if(!I.use_tool(src, user, decon_speed))
		return
	to_chat(user, span_notice("You [anchored == TRUE ? "unscrew" : "screw"] [src.name] [anchored == TRUE ? "from" : "to"] the floor."))
	anchored = !anchored

/obj/structure/platform/wrench_act(mob/living/user, obj/item/tool)
	if(anchored)
		user.balloon_alert(user, "Unscrew it first.")
		return
	if(!anchored)
		user.balloon_alert(user, "Deconstructed.")
		playsound(src, 'sound/items/deconstruct.ogg', 50, 1)
		new material_type(user.loc, material_amount)
		qdel(src)


/obj/structure/platform/proc/can_be_reached(mob/user)
	var/checking_dir = get_dir(user, src)
	if(!(checking_dir & dir))
		return TRUE
	checking_dir = REVERSE_DIR(checking_dir)
	for(var/obj/blocker in loc)
		if(!blocker.CanPass(user, checking_dir))
			return FALSE
	return TRUE

/obj/structure/platform/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
	return TRUE

/obj/structure/platform/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(!(to_dir & dir))
		return TRUE
	return ..()

/obj/structure/platform/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src)
		return // Let's not block ourselves.

	if(!(direction & dir))
		return

	if (!density)
		return

	if (leaving.throwing)
		return

	if (leaving.movement_type & (PHASING|MOVETYPES_NOT_TOUCHING_GROUND))
		return

	if (leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

// Platform types
/obj/structure/platform/reinforced
	name = "reinforced platform"
	desc = "A robust platform made of plasteel, more resistance for hazard sites."
	icon_state = "plasteel"
	material_type = /obj/item/stack/sheet/plasteel
	max_integrity = 300
	armor_type = /datum/armor/structure_rplatform

/datum/armor/structure_rplatform
	melee = 20
	bullet = 30
	laser = 30
	energy = 100
	bomb = 50
	fire = 100
	acid = 100

// Platform corners
/obj/structure/platform/corner
	name = "platform corner"
	desc = "A metal platform corner."
	icon_state = "metalcorner"
	corner = TRUE
	material_amount = 2

/obj/structure/platform/reinforced/corner
	name = "reinforced platform corner"
	desc = "A robust platform corner made of plasteel, more resistance for hazard sites."
	icon_state = "plasteelcorner"
	corner = TRUE
	material_amount = 2

// Fountain
/obj/structure/statue/fountain
	name = "фонтан"
	desc = "Фонтан, собранный из настоящего, тёсанного камня."
	icon = 'modular_bandastation/objects/icons/fountain.dmi'
	icon_state = "fountain_g"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	pixel_x = -16

/obj/structure/statue/fountain/aged
	name = "старый фонтан"
	desc = "Фонтан, собранный из настоящего, тёсанного камня. Его помотало временем."
	icon = 'modular_bandastation/objects/icons/fountain.dmi'
	icon_state = "fountain"

// Archive structure
/obj/structure/archives
	name = "Desk"
	icon = 'icons/obj/antags/cult/structures.dmi'
	desc = "A desk covered in arcane manuscripts and tomes in unknown languages. Looking at the text makes your skin crawl."
	icon_state = "tomealtar"
	light_range = 1.5
	light_color = LIGHT_COLOR_FIRE
	density = TRUE
	anchored = TRUE

/obj/structure/archives/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, 10 SECONDS)
	return ITEM_INTERACT_SUCCESS

// Display Cases
/obj/structure/displaycase/hos
	alert = TRUE
	start_showpiece_type = /obj/item/food/donut/choco
	req_access = list(ACCESS_HOS)

// Mattress
/obj/structure/bed/mattress
	name = "матрас"
	icon = 'modular_bandastation/objects/icons/mattress.dmi'
	icon_state = "mattress"
	desc = "Голый матрас. Выглядит не очень удобным, но может быть лучше чем лежать на полу."
	anchored = FALSE

/obj/structure/bed/mattress/dirty
	name = "грязный матрас"
	icon_state = "dirty_mattress"
	desc = "Грязный, вонючий матрас, заляпанный различными жидкостями. Здесь не то что прилечь нельзя, к этому вовсе прикасаться не хочется..."

// Beach umbrella
/obj/structure/fluff/beach_umbrella
	name = "пляжный зонтик"
	desc = "Зонтик, предназначенный для защиты от солнца на пляже."
	icon = 'modular_bandastation/objects/icons/umbrella.dmi'
	icon_state = "brella"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella/security
	icon_state = "hos_brella"

/obj/structure/fluff/beach_umbrella/science
	icon_state = "rd_brella"

/obj/structure/fluff/beach_umbrella/engine
	icon_state = "ce_brella"

/obj/structure/fluff/beach_umbrella/cap
	icon_state = "cap_brella"

/obj/structure/fluff/beach_umbrella/syndi
	icon_state = "syndi_brella"

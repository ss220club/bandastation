/obj/item/gun/energy/laser/awaymission_aeg
	name = "Exploreverse Mk.I"
	desc = "Прототип оружия с миниатюрным реактором для исследований в крайне отдаленных секторах. \
	\n Данная модель использует экспериментальную систему обратного восполнения, работающую на принципе огромной аккумуляции энергии, но крайне уязвимую к радиопомехам, которыми кишит сектор станции, попростую не работая там."
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon_state = "laser_gate"
	inhand_icon_state = "laser_gate"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/awaymission_aeg)
	can_select = FALSE
	selfcharge = TRUE
	ammo_x_offset = 0
	can_charge = 0

/obj/item/ammo_casing/energy/lasergun/awaymission_aeg
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)

/*/obj/item/gun/energy/can_shoot()
    if (!istype(ammo_type, /list) || !ammo_type.len)
        return FALSE

    var/obj/item/ammo_casing/energy/shot = ammo_type[select]

    return !QDELETED(cell) ? (cell.charge >= shot.e_cost) : FALSE
*/
/obj/item/gun/energy/laser/awaymission_aeg/Initialize(mapload)
	. = ..()
	on_changed_z_level()

/obj/item/gun/energy/proc/instant_discharge()
	if(!cell)
		return
	cell.charge = 0
	recharge_newshot(no_cyborg_drain = TRUE)
	update_appearance()

/obj/item/gun/energy/laser/awaymission_aeg/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	. = ..()
	if(onAwayMission())
		selfcharge = TRUE
		if(ismob(loc))
			to_chat(loc, span_notice("[src.name] активируется, начиная аккумулировать энергию из материи сущего."))
	else
		selfcharge = FALSE
		instant_discharge()
		if(ismob(loc))
			to_chat(loc, span_danger("[src.name] деактивируется, так как он подавляется системами станции."))

/obj/item/gun/energy/laser/awaymission_aeg/mk2
	name = "Exploreverse Mk.II"
	desc = "Второй прототип оружия с миниатюрным реактором и забавным рычагом для исследований в крайне отдаленных секторах. \
	\nДанная модель оснащена системой ручного восполнения энергии \"Za.E.-8 A.L'sya\", \
	позволяющей в короткие сроки восполнить необходимую электроэнергию с помощью ручного труда и конвертации личной энергии подключенного к системе зарядки. \
	\nТеперь еще более нелепый дизайн с торчащими проводами!"
	icon_state = "laser_gate_mk2"

/obj/item/gun/energy/laser/awaymission_aeg/mk2/attack_self(mob/living/user)
	. = ..()
	var/msg_for_all = span_warning("[user] усердно давит на рычаг зарядки [src.name], но он не поддается!")
	var/msg_for_user = span_notice("Вы пытаетесь надавить на рычаг зарядки [src.name], но он заблокирован.")
	var/msg_recharge_all = span_notice("[user] усердно давит на рычаг зарядки [src.name]...")
	var/msg_recharge_user = span_notice("Вы со всей силы давите на рычаг зарядки [src.name], пытаясь зарядить её...")

	if(!onAwayMission())
		user.visible_message(msg_for_all, msg_for_user)
		return FALSE

	if(cell.charge >= cell.maxcharge)
		user.visible_message(msg_for_all, msg_for_user)
		return FALSE

	if(user.nutrition <= NUTRITION_LEVEL_STARVING)
		user.visible_message(
			span_warning("[user] слабо давит на рычаг зарядки [src.name], но бесполезно: слишком мало сил!"),
			span_notice("Вы пытаетесь надавить на рычаг зарядки [src.name], но не можете из-за голода и усталости!")
		)
		return FALSE

	user.visible_message(msg_recharge_all, msg_recharge_user)
	playsound(src, 'sound/effects/sparks3.ogg', 10, 1)
	do_sparks(1, 1, src)

	if(!do_after(user, 3 SECONDS, target = src))
		return
	cell.give(1000)
	user.adjust_nutrition(-10)

/datum/design/gate_gun_mk1
	name = "Gate Energy Gun MK1"
	desc = "Энергетическое оружие с экспериментальным миниатюрным реактором. Работает только во вратах."
	id = "gate_gun"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.75,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.75,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.25
	)
	build_path = /obj/item/gun/energy/laser/awaymission_aeg
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/gate_gun_mk2
	name = "Gate Energy Gun MK2"
	desc = "Энергетическое оружие с экспериментальным миниатюрным реактором и рычагом для ручной зарядки. Работает только во вратах."
	id = "gate_gun_mk2"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.25,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5
	)
	build_path = /obj/item/gun/energy/laser/awaymission_aeg/mk2
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/techweb_node/awaymission_aeg
	id = "gate_gun"
	display_name = "Awaymission Laser Weaponary Research"
	description = "Изучайте врата ещё продуктивнее и безопаснее с этой технологией."
	prereq_ids = list(TECHWEB_NODE_ELECTRIC_WEAPONS)
	design_ids = list(
		"gate_gun_mk2",
		"gate_gun",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

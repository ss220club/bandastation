/obj/item/melee/baton/security/electrostaff
	name = "электропосох"
	desc = "Шоковая палка, только более мощная, двуручная и доступная наиболее авторитетным членам силовых структур Nanotrasen. А еще у неё нет тупого конца."
	lefthand_file = 'modular_bandastation/objects/icons/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/melee_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/melee.dmi'
	icon_state = "electrostaff_orange"
	inhand_icon_state = "electrostaff_orange"
	base_icon_state = "electrostaff_orange"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	throwforce = 7
	attack_verb_simple = list("бьёт", "ударяет")
	attack_verb_continuous = list("бьёт", "ударяет")
	cooldown = 3.5 SECONDS
	unique_reskin = list(
		"Оранжевое свечение" = "electrostaff_orange",
		"Красное свечение" = "electrostaff_red",
		"Фиолетовое свечение" = "electrostaff_purple",
		"Синее свечение" = "electrostaff_blue",
	)
	preload_cell_type = /obj/item/stock_parts/cell/high
	block_chance = 30

/obj/item/melee/baton/security/electrostaff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		wieldsound = 'modular_bandastation/objects/sounds/weapons/melee/electrostaff/on.ogg', \
		require_twohands = TRUE, \
	)

/obj/item/melee/baton/security/electrostaff/update_icon(updates)
	if(active)
		icon_state = inhand_icon_state = "[base_icon_state]_active"
		return ..()
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		icon_state = inhand_icon_state = "[base_icon_state]"
		return ..()

/obj/item/melee/baton/security/electrostaff/examine(mob/user)
	. = ..()
	. -= span_notice("This item can be recharged in a recharger. Using a screwdriver on this item will allow you to access its power cell, which can be replaced.")
	. += span_notice("Данный предмет не имеет внешних разъемов для зарядки. Используйте <b>отвертку</b> для доступа к внутренней батарее, чтобы заменить или зарядить её.")

/obj/item/melee/baton/security/electrostaff/reskin_obj(mob/user)
	. = ..()
	switch(icon_state)
		if("Оранжевое свечение")
			icon_state = "electrostaff_orange"
		if("Красное свечение")
			icon_state = "electrostaff_red"
		if("Фиолетовое свечение")
			icon_state = "electrostaff_purple"
		if("Синее свечение")
			icon_state = "electrostaff_blue"
	inhand_icon_state = icon_state
	base_icon_state = icon_state
	user.update_held_items()

/obj/item/weaponcrafting/gunkit/electrostaff
	name = "\improper electrostaff parts kit"
	desc = "Возьмите 2 оглушающие дубинки. Соедините их вместе, поместив внутрь батарею. Используйте остальные инструменты (лишних винтиков быть не должно)."

/datum/design/electrostaff
	name = "Electrostaff Parts Kit"
	desc = "Оперативный ответ."
	id = "electrostaff"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/weaponcrafting/gunkit/electrostaff
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS,
	)
	departmental_flags = DEPARTMENT_SECURITY

/datum/crafting_recipe/electrostaff
	name = "Electrostaff"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = list(/obj/item/melee/baton/security/electrostaff)
	reqs = list(/obj/item/melee/baton/security = 2,
				/obj/item/stock_parts/cell/high = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/assembly/signaler/anomaly/flux = 1,
				/obj/item/weaponcrafting/gunkit/electrostaff = 1)
	time = 10 SECONDS
	category = CAT_WEAPON_MELEE

/datum/techweb_node/electrostaff
	id = "electrostaff"
	display_name = "Advanced Security Baton Technology"
	description = "Настоящая двуручная дубинка службы безопасности."
	prereq_ids = list("weaponry")
	design_ids = list(
		"electrostaff"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

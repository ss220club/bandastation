#define CALIBER_44 ".44"
#define CALIBER_127 "12.7"
#define CALIBER_PEA "pea"
#define CALIBER_PNEUMA "pneuma"

// Base heavy revolver
/obj/item/gun/ballistic/revolver/reclinable
	var/snapback_sound = 'modular_bandastation/objects/sounds/weapons/cylinder/snapback_rsh12.ogg'
	var/reclined_sound = 'modular_bandastation/objects/sounds/weapons/cylinder/reclined_rsh12.ogg'
	var/reclined = FALSE

/obj/item/gun/ballistic/revolver/reclinable/attack_self(mob/living/user)
	reclined = !reclined
	playsound(user, reclined ? reclined_sound : snapback_sound, 50, 1)
	update_icon()

	if(reclined)
		return ..()

/obj/item/gun/ballistic/revolver/reclinable/update_icon_state()
	icon_state = initial(icon_state) + (reclined ? "_reclined" : "")
	return ..()

/obj/item/gun/ballistic/revolver/reclinable/attackby(obj/item/A, mob/user, params)
	if(!reclined)
		return
	return ..()

/obj/item/gun/ballistic/revolver/reclinable/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(!reclined)
		return ..()

	to_chat(user, span_danger("*click*"))
	playsound(user, dry_fire_sound, 100, 1)

// Colt Anaconda .44
/obj/item/gun/ballistic/revolver/reclinable/anaconda
	name = "Анаконда"
	desc = "Крупнокалиберный револьвер двадцатого века. Несмотря на то, что оружие хранилось в хороших условиях, старина даёт о себе знать."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/d44
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	icon_state = "anaconda"
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/gunshot_anaconda.ogg'
	inhand_icon_state = "anaconda"

/obj/item/gun/ballistic/revolver/reclinable/anaconda/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_box/box_d44))
		return
	return ..()

/obj/item/ammo_box/magazine/internal/cylinder/d44
	name = ".44 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/d44
	caliber = CALIBER_44
	max_ammo = 6

/obj/item/ammo_casing/d44
	desc = "A .44 bullet casing."
	caliber = CALIBER_44
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "casing44"
	projectile_type = /obj/projectile/bullet/d44

/obj/projectile/bullet/d44
	name = ".44 bullet"
	icon_state = "bullet"
	damage = 50
	damage_type = BRUTE
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	spread = 20

/obj/item/ammo_box/speed_loader_d44
	name = "speed loader (.44)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/d44
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	caliber = CALIBER_44
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "44"

/obj/item/ammo_box/box_d44
	name = "ammo box (.44)"
	desc = "Contains up to 24 .44 cartridges, intended to either be inserted into a speed loader or into the gun manually."
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = /obj/item/ammo_casing/d44
	max_ammo = 24
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "44_box"

// RSH-12 12.7
/obj/item/gun/ballistic/revolver/reclinable/rsh12
	name = "РШ-12"
	desc = "Тяжёлый револьвер винтовочного калибра с откидным стволом. По слухам, всё ещё находится на вооружении у СССП."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rsh12
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	icon_state = "rsh12"
	inhand_icon_state = "rsh12"
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/gunshot_rsh12.ogg'

/obj/item/gun/ballistic/revolver/reclinable/rsh12/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_box/box_mm127))
		return
	return ..()

/obj/item/ammo_box/magazine/internal/cylinder/rsh12
	name = "12.7mm revolver cylinder"
	ammo_type = /obj/item/ammo_casing/mm127
	caliber = CALIBER_127
	max_ammo = 5

/obj/item/ammo_casing/mm127
	desc = "A 12.7mm bullet casing."
	caliber = CALIBER_127
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "casing127mm"
	projectile_type = /obj/projectile/bullet/mm127

/obj/projectile/bullet/mm127
	name = "127mm bullet"
	icon_state = "bullet"
	damage = 75
	hitsound_wall = "ricochet"

/obj/item/ammo_box/speed_loader_mm127
	name = "speed loader (12.7mm)"
	desc = "Designed to quickly reload... is it a revolver speedloader with rifle cartidges in it?"
	ammo_type = /obj/item/ammo_casing/mm127
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "mm127"

/obj/item/ammo_box/box_mm127
	name = "ammo box (12.7)"
	desc = "Contains up to 100 12.7mm cartridges."
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = /obj/item/ammo_casing/mm127
	max_ammo = 100
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "mm127_box"

// Горохострел
/obj/item/gun/ballistic/revolver/pea_shooter
	name = "Горохострел"
	desc = "Живой горох! Может стрелять горошинами, которые наносят слабый урон самооценке."
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	icon_state = "peas_shooter"
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/peas_shooter_gunshot.ogg'
	drop_sound = 'modular_bandastation/objects/sounds/weapons/drop/peas_shooter_drop.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/peas_shooter
	inhand_icon_state = "peas_shooter"

/obj/item/ammo_box/magazine/internal/peas_shooter
	name = "peacock shooter magazine"
	desc = "Хранилище горошин для горохострела, вмещает до 6 горошин за раз."
	ammo_type = /obj/item/ammo_casing/peas_shooter
	max_ammo = 6
	caliber = CALIBER_PEA

/obj/item/ammo_casing/peas_shooter
	name = "pea bullet"
	desc = "Пуля из гороха, не может нанести какого-либо ощутимого урона."
	projectile_type = /obj/projectile/bullet/midbullet_r/peas_shooter
	icon_state = "peashooter_bullet"
	caliber = CALIBER_PEA

// Пуля горохострела
/obj/projectile/bullet/midbullet_r/peas_shooter
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "peashooter_bullet"
	stamina = 5

// Тактическая бита Флота Nanotrasen
/obj/item/melee/baseball_bat/homerun/central_command
	name = "тактическая бита Флота Nanotrasen"
	desc = "Выдвижная тактическая бита Центрального Командования Nanotrasen. \
	В официальных документах эта бита проходит под элегантным названием \"Высокоскоростная система доставки СРП\". \
	Выдаваясь только самым верным и эффективным офицерам Nanotrasen, это оружие является одновременно символом статуса \
	и инструментом высшего правосудия."
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL

	var/on = FALSE
	/// Force when concealed
	force = 5
	/// Force when extended
	var/force_on = 20

	lefthand_file = 'modular_bandastation/objects/icons/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/melee_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/melee.dmi'
	/// Icon state when concealed
	icon_state = "centcom_bat_0"
	inhand_icon_state = "centcom_bat_0"
	/// Icon state when extended
	var/icon_state_on = "centcom_bat_1"
	var/inhand_icon_state_on = "centcom_bat_1"
	/// Sound to play when concealing or extending
	var/extend_sound = 'sound/weapons/batonextend.ogg'
	/// Attack verbs when concealed (created on Initialize)
	attack_verb_simple = list("hit", "poked")
	/// Attack verbs when extended (created on Initialize)
	var/list/attack_verb_simple_on = list("smacked", "struck", "cracked", "beaten")

/obj/item/melee/baseball_bat/homerun/central_command/pickup(mob/living/user)
	. = ..()
	if(user.faction == FACTION_STATION)
		user.AdjustParalyzed(10 SECONDS)
		user.drop_all_held_items(src, force)
		to_chat(user, span_userdanger("Это - оружие истинного правосудия. Тебе не дано обуздать его мощь."))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(rand(force/2, force), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			user.adjustBruteLoss(rand(force/2, force))

/obj/item/melee/baseball_bat/homerun/central_command/attack_self(mob/user)
	on = !on

	if(on)
		to_chat(user, span_userdanger("Вы активировали [src.name] - время для правосудия!"))
		icon_state = icon_state_on
		inhand_icon_state = inhand_icon_state_on
		w_class = WEIGHT_CLASS_HUGE
		force = force_on
		attack_verb_simple = attack_verb_simple_on
	else
		user.balloon_alert(user, "Вы деактивировали [src.name].")
		icon_state = initial(icon_state)
		inhand_icon_state = initial(inhand_icon_state)
		w_class = initial(w_class)
		force = initial(force)
		attack_verb_simple = initial(attack_verb_simple)

	homerun_able = on
	// Update mob hand visuals
	if(ishuman(user))
		user.update_held_items()
	playsound(loc, extend_sound, 50, TRUE)
	add_fingerprint(user)

/obj/item/melee/baseball_bat/homerun/central_command/attack(mob/living/target, mob/living/user)
	if(on)
		homerun_ready = TRUE
	. = ..()

//Pneumagun
/obj/item/gun/ballistic/automatic/pneumaticgun
	name = "Пневморужье"
	desc = "Стандартное пневморужье"
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	icon_state = "pneumagun"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/pneuma
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/gunshot_pneumatic.ogg'
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1

// Базовые боеприпасы для пневморужья
/obj/item/ammo_box/magazine/pneuma
	name = "магазин пневморужья"
	desc = "Наполняется шариками с реагентом."
	caliber = CALIBER_PNEUMA
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "pneumamag_g"
	ammo_type = /obj/item/ammo_casing/pneuma
	max_ammo = 12
	multiload = 0
	unique_reskin = list(
		"Красная обойма" = "pneumaball_r",
		"Зелёная обойма" = "pneumaball_g",
	)

/obj/item/ammo_box/magazine/pneuma/reskin_obj(mob/user)
	. = ..()
	switch(icon_state)
		if("Красная обойма")
			icon_state = "pneumaball_r"
		if("Зелёная обойма")
			icon_state = "pneumaball_g"

/obj/item/ammo_casing/pneuma
	name = "пневматический шарик"
	desc = "Пустой пневматический шарик."
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "pneumaball_g"
	caliber = CALIBER_PNEUMA
	projectile_type = /obj/projectile/bullet/pneumaball
	harmful = FALSE

/obj/projectile/bullet/pneumaball
	name = "пневматический шарик"
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "pneumaball_g"
	stamina = 7
	damage = 1

// Боеприпасы для перцового типа пневморужья
/obj/item/ammo_box/magazine/pneuma/pepper
	ammo_type = /obj/item/ammo_casing/pneuma/pepper
	icon_state = "pneumamag_r"

/obj/item/ammo_casing/pneuma/pepper
	desc = "Шарик с капсаицином. Эффективно подходит для задержания преступников, не носящих очки."
	projectile_type = /obj/projectile/bullet/pneumaball/pepper
	icon_state = "pneumaball_r"

/obj/projectile/bullet/pneumaball/pepper
	icon_state = "pneumaball_r"

/obj/projectile/bullet/pneumaball/pepper/New()
	..()
	reagents.add_reagent("condensedcapsaicin", 15)

/datum/supply_pack/security/armory/pneumagun
	name = "Pneumatic Pepper Rifles Crate"
	contains = list(
		/obj/item/gun/ballistic/automatic/pneumaticgun = 2,
		/obj/item/ammo_box/magazine/pneuma/pepper = 2,
	)
	cost = CARGO_CRATE_VALUE * 2.5
	crate_name = "pneumatic pepper rifles pack"

/datum/supply_pack/security/armory/pneumapepperballs
	name = "Pneumatic Pepper Rifle Ammunition Crate"
	contains = list(
		/obj/item/ammo_box/magazine/pneuma/pepper = 3,
	)
	cost = CARGO_CRATE_VALUE * 1.25
	crate_name = "pneumatic pepper ammunition pack"

/obj/item/melee/stylet
	name = "выкидной нож"
	desc = "Маленький складной нож скрытого ношения. \
	Нож в итальянском стиле, который исторически стал предметом споров и даже запретов \
	Его лезвие практически мгновенно выбрасывается при нажатии кнопки-качельки."
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY

	var/on = FALSE
	force = 2
	var/force_on = 8

	lefthand_file = 'modular_bandastation/objects/icons/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/melee_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/melee.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	icon_state = "stylet_0"
	inhand_icon_state = "stylet_0"
	var/icon_state_on = "stylet_1"
	var/inhand_icon_state_on = "stylet_1"
	var/extend_sound = 'modular_bandastation/objects/sounds/weapons/styletext.ogg'
	attack_verb_simple = list("hit", "poked")
	var/list/attack_verb_simple_on = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/melee/stylet/update_icon_state()
	. = ..()
	if(on)
		icon_state = "stylet_1"
		inhand_icon_state = "stylet_1"
	else
		icon_state = "stylet_0"
		inhand_icon_state = "stylet_1"

/obj/item/melee/stylet/attack_self(mob/user)
	on = !on

	if(on)
		user.balloon_alert(user, "Вы разложили [src]")
		update_icon(UPDATE_ICON_STATE)
		w_class = WEIGHT_CLASS_SMALL
		force = force_on
		attack_verb_simple = attack_verb_simple_on
	else
		user.balloon_alert(user, "Вы сложили [src].")
		update_icon(UPDATE_ICON_STATE)
		w_class = initial(w_class)
		force = initial(force)
		attack_verb_simple = initial(attack_verb_simple)

	// Update mob hand visuals
	if(ishuman(user))
		user.update_held_items()
	playsound(loc, extend_sound, 50, TRUE)
	add_fingerprint(user)

#undef CALIBER_44
#undef CALIBER_127
#undef CALIBER_PEA
#undef CALIBER_PNEUMA

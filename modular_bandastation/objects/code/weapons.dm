#define CALIBER_44 ".44"
#define CALIBER_127 "12.7"
#define CALIBER_PEA "pea"
#define CALIBER_PNEUMA "pneuma"
#define CALIBER_9X19RMM "9x19rmm"
#define CALIBER_9X19BMM "9x19bmm"
#define CALIBER_9X19MM "9x19mm"
#define CALIBER_9X19AMM "9x19amm"

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
	. = ..()
	icon_state = (initial(icon_state)) + (reclined ? "_reclined" : "")

/obj/item/gun/ballistic/revolver/reclinable/attackby(obj/item/A, mob/user, params)
	if(!reclined)
		return
	return ..()

/obj/item/gun/ballistic/revolver/reclinable/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(!reclined)
		return ..()

	user.balloon_alert(user, "*click*")
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
	fire_sound_volume = 30

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

/obj/projectile/bullet/mm127/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!isliving(target))
		return
	var/mob/living/carbon/M = target
	if(M.move_resist == INFINITY)
		return
	var/atom/target_throw = get_edge_target_turf(M, get_dir(src, get_step_away(M, starting)))
	M.throw_at(target_throw, 2, 2)

// Горохострел
/obj/item/gun/ballistic/revolver/pea_shooter
	name = "горохострел"
	desc = "Живой горох! Может стрелять горошинами, которые наносят слабый урон самооценке."
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	icon_state = "pea_shooter"
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/peas_shooter_gunshot.ogg'
	drop_sound = 'modular_bandastation/objects/sounds/weapons/drop/peas_shooter_drop.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/peas_shooter
	inhand_icon_state = "pea_shooter"

/obj/item/ammo_box/magazine/internal/peas_shooter
	name = "peacock shooter magazine"
	desc = "Хранилище горошин для горохострела, вмещает до 6 горошин за раз."
	ammo_type = /obj/item/ammo_casing/peas_shooter
	max_ammo = 6
	caliber = CALIBER_PEA

/obj/item/ammo_casing/peas_shooter
	name = "pea bullet"
	desc = "Пуля из гороха, не может нанести какого-либо ощутимого урона."
	projectile_type = /obj/projectile/bullet/peas_shooter
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "pea_bullet"
	caliber = CALIBER_PEA

// Пуля горохострела
/obj/projectile/bullet/peas_shooter
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "pea_bullet"
	damage = 5
	damage_type = STAMINA
	wound_bonus = -100

/obj/projectile/bullet/peas_shooter/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(istype(target, /mob/living/carbon) | isliving(target))
		var/mob/living/carbon/M = target
		if(prob(15))
			M.emote("moan")
	return

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
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "nothing"
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
	if(!HAS_TRAIT(user, R_ADMIN))
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
		to_chat(user, span_userdanger("Вы разложили [src.name] - время для правосудия!"))
		icon_state = icon_state_on
		inhand_icon_state = inhand_icon_state_on
		w_class = WEIGHT_CLASS_HUGE
		force = force_on
		attack_verb_simple = attack_verb_simple_on
	else
		to_chat(user, span_userdanger("Вы сложили [src.name]."))
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
	inhand_icon_state = "pneumagun"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/pneuma
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/gunshot_pneumatic.ogg'
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	special_mags = TRUE
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pneumaticgun/loaded
	spawnwithmagazine = TRUE
	spawn_magazine_type = /obj/item/ammo_box/magazine/pneuma

/obj/item/gun/ballistic/automatic/pneumaticgun/loaded/pepper
	spawn_magazine_type = /obj/item/ammo_box/magazine/pneuma/pepper

// Базовые боеприпасы для пневморужья
/obj/item/ammo_box/magazine/pneuma
	name = "магазин пневморужья"
	desc = "Наполняется шариками с реагентом."
	caliber = CALIBER_PNEUMA
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "pneumag"
	base_icon_state = "pneumag"
	ammo_type = /obj/item/ammo_casing/pneuma
	max_ammo = 12
	multiload = 0

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
	icon_state = "pneumar"
	base_icon_state = "pneumar"

/obj/item/ammo_casing/pneuma/pepper
	desc = "Шарик с капсаицином. Эффективно подходит для задержания преступников, не носящих очки."
	projectile_type = /obj/projectile/bullet/pneumaball/pepper
	icon_state = "pneumaball_r"

/obj/projectile/bullet/pneumaball/pepper
	icon_state = "pneumaball_r"
	var/pneuma_reagent = /datum/reagent/consumable/condensedcapsaicin
	var/reagent_volume = 5

/obj/projectile/bullet/pneumaball/pepper/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/carbon/M = target
		var/datum/reagent/R = new pneuma_reagent
		R.expose_mob(M, VAPOR, reagent_volume)

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

/obj/item/knife/stylet
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

/obj/item/knife/stylet/update_icon()
	. = ..()
	if(on)
		icon_state = inhand_icon_state = "stylet_1"
	else
		icon_state = inhand_icon_state = "stylet_0"

/obj/item/knife/stylet/attack_self(mob/user)
	on = !on

	if(on)
		to_chat(user, span_notice("Вы разложили [src.name]."))
		update_icon()
		w_class = WEIGHT_CLASS_SMALL
		force = force_on
		attack_verb_simple = attack_verb_simple_on
	else
		to_chat(user, span_notice("Вы сложили [src.name]."))
		update_icon()
		w_class = initial(w_class)
		force = initial(force)
		attack_verb_simple = initial(attack_verb_simple)

	// Update mob hand visuals
	if(ishuman(user))
		user.update_held_items()
	playsound(loc, extend_sound, 50, TRUE)
	add_fingerprint(user)

// Beretta M9
/obj/item/gun/ballistic/automatic/pistol/beretta
	name = "беретта M9"
	desc = "Один из самых распространенных и узнаваемых пистолетов во вселенной. К сожалению, из-за особенности ствола, на пистолет нельзя приделать глушитель. Старая добрая классика."
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon_state = "beretta"
	inhand_icon_state = "beretta"
	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/beretta
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/beretta_shot.ogg'
	fire_sound_volume = 30

/obj/item/gun/ballistic/automatic/pistol/beretta/desert
	icon_state = "beretta_desert"

/obj/item/gun/ballistic/automatic/pistol/beretta/black
	icon_state = "beretta_black"

/obj/item/gun/ballistic/automatic/pistol/beretta/add_seclight_point()
	. = ..()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_y = 12, \
		overlay_x = 17, \
	)

/obj/item/ammo_box/magazine/beretta
	name = "beretta rubber 9x19mm magazine"
	desc = "Магазин резиновых патронов калибра 9x19mm."
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "berettar-10"
	base_icon_state = "berettar"
	ammo_type = /obj/item/ammo_casing/beretta/mmrub919
	max_ammo = 10
	multiload = 0
	caliber = CALIBER_9X19RMM
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/beretta/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/beretta/mm919
	name = "beretta lethal 9x19mm magazine"
	desc = "Магазин летальных патронов калибра 9x19mm."
	icon_state = "berettal-10"
	base_icon_state = "berettal"
	ammo_type = /obj/item/ammo_casing/beretta/mm919
	multiple_sprites = AMMO_BOX_PER_BULLET
	caliber = CALIBER_9X19MM

/obj/item/ammo_box/magazine/beretta/mm919/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/beretta/mmbsp919
	name = "beretta bluespace 9x19mm magazine"
	desc = "Магазин экспериментальных блюспейс патронов калибра 9x19mm. Из-за особенности корпуса вмещает только блюспейс патроны."
	icon_state = "berettab-10"
	base_icon_state = "berettab"
	ammo_type = /obj/item/ammo_casing/beretta/mmbsp919
	multiple_sprites = AMMO_BOX_PER_BULLET
	caliber = CALIBER_9X19BMM

/obj/item/ammo_box/magazine/beretta/mmbsp919/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/beretta/mmap919
	name = "beretta armor-piercing 9x19mm magazine"
	desc = "Магазин бронебойных патронов калибра 9x19mm."
	icon_state = "berettaap-10"
	base_icon_state = "berettaap"
	caliber = CALIBER_9X19AMM
	ammo_type = /obj/item/ammo_casing/beretta/mmap919
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/beretta/mmap919/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_casing/beretta/mmbsp919
	caliber = CALIBER_9X19BMM
	name = "9x19mm bluespace bullet casing"
	desc = "A 9x19mm bluespace bullet casing."
	projectile_type = /obj/projectile/bullet/mmbsp919

/obj/projectile/bullet/mmbsp919
	name = "9x19 bluespace bullet"
	damage = 18
	speed = 0.2

/obj/item/ammo_casing/beretta/mmap919
	caliber = CALIBER_9X19AMM
	name = "9x19mm armor-piercing bullet casing"
	desc = "A 9x19 armor-piercing bullet casing."
	projectile_type = /obj/projectile/bullet/mmap919

/obj/projectile/bullet/mmap919
	name = "9x19mm armor-piercing bullet"
	damage = 18
	armour_penetration = 15

/obj/item/ammo_casing/beretta/mmrub919
	name = "9x19mm rubber bullet casing"
	caliber = CALIBER_9X19RMM
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "casingmm919"
	desc = "A 9x19 rubber bullet casing."
	projectile_type = /obj/projectile/bullet/mmrub919

/obj/projectile/bullet/mmrub919
	name = "beretta rubber bullet"
	damage = 5
	stamina = 30

/obj/item/ammo_casing/beretta/mm919
	name = "9x19mm lethal bullet casing"
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "casingmm919"
	desc = "A 9x19 lethal bullet casing."
	projectile_type = /obj/projectile/bullet/mm919
	caliber = CALIBER_9X19MM

/obj/projectile/bullet/mm919
	name = "beretta lethal bullet"
	damage = 20

/obj/item/ammo_box/beretta
	name = "box of rubber 9x19mm cartridges"
	desc = "Содержит до 30 резиновых патронов калибра 9x19mm."
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = /obj/item/ammo_casing/beretta/mmrub919
	max_ammo = 30
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "9mmr_box"

/obj/item/ammo_box/beretta/mm919
	name = "box of lethal 9x19mm cartridges"
	desc = "Содержит до 20 летальных патронов калибра 9x19mm."
	ammo_type = /obj/item/ammo_casing/beretta/mm919
	max_ammo = 20
	icon_state = "9mm_box"

/obj/item/ammo_box/beretta/mmbsp919
	name = "box of bluespace 9x19mm cartridges"
	desc = "Содержит до 20 блюспейс патронов калибра 9x19mm."
	ammo_type = /obj/item/ammo_casing/beretta/mmbsp919
	max_ammo = 20
	icon_state = "9mmb_box"

/obj/item/ammo_box/beretta/mmap919
	name = "box of armor-penetration 9x19mm cartridges"
	desc = "Содержит до 20 бронебойных патронов калибра 9x19mm."
	ammo_type = /obj/item/ammo_casing/beretta/mmap919
	max_ammo = 20
	icon_state = "9mmap_box"

/datum/supply_pack/security/armory/beretta
	name = "Beretta M9 Crate"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/beretta = 2,)
	cost = CARGO_CRATE_VALUE * 3.25
	crate_name = "beretta m9 pack"

/datum/supply_pack/security/armory/berettarubberammo
	name = "Beretta M9 Rubber Ammunition Crate"
	contains = list(
		/obj/item/ammo_box/beretta = 2,
		/obj/item/ammo_box/magazine/beretta = 2,
	)
	cost = CARGO_CRATE_VALUE * 1.75
	crate_name = "beretta rubber ammunition pack"

/datum/supply_pack/security/armory/berettalethalammo
	name = "Beretta M9 Lethal Ammunition Crate"
	contains = list(
		/obj/item/ammo_box/beretta/mm919 = 2,
		/obj/item/ammo_box/magazine/beretta/mm919 = 2,
	)
	cost = CARGO_CRATE_VALUE * 2
	crate_name = "beretta lethal ammunition pack"

/datum/supply_pack/security/armory/berettaexperimentalammo
	name = "Beretta M9 Bluespace Ammunition Crate"
	contains = list(
		/obj/item/ammo_box/beretta/mmbsp919 = 2,
		/obj/item/ammo_box/magazine/beretta/mmbsp919 = 2,
	)
	cost = CARGO_CRATE_VALUE * 3.25
	crate_name = "beretta bluespace ammunition pack"

/datum/supply_pack/security/armory/berettaarmorpiercingammo
	name = "Beretta M9 Armor-piercing Ammunition Crate"
	contains = list(
		/obj/item/ammo_box/beretta/mmap919 = 2,
		/obj/item/ammo_box/magazine/beretta/mmap919 = 2,
	)
	cost = CARGO_CRATE_VALUE * 2.5
	crate_name = "beretta AP ammunition pack"

/datum/design/box_beretta/lethal
	name = "Beretta M9 Lethal Ammo Box (9mm)"
	desc = "A box of 20 lethal rounds for Beretta M9"
	id = "box_beretta"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.3)
	build_path = /obj/item/ammo_box/beretta/mm919
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/box_beretta/ap
	name = "Beretta M9 AP Ammo Box (9mm)"
	desc = "A box of 20 armor-piercing rounds for Beretta M9"
	id = "box_beretta_ap"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/ammo_box/beretta/mmap919
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/box_beretta/bluespace
	name = "Beretta M9 Bluespace Ammo Box (9mm)"
	desc = "A box of 20 high velocity bluespace rounds for Beretta M9"
	id = "box_beretta_bsp"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.3,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/ammo_box/beretta/mmbsp919
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/techweb_node/beretta_ammo
	id = "beretta_ammo"
	display_name = "Beretta Ammo Research"
	description = "Наши учёные смогли разработать боеприпасы к пистолету беретта и даже несколько... специфичных."
	prereq_ids = list("weaponry")
	design_ids = list(
		"box_beretta_bsp",
		"box_beretta_ap",
		"box_beretta",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

// Electrostaff
/obj/item/melee/baton/security/electrostaff
	name = "электропосох"
	desc = "Шоковая палка, только более мощная, двуручная и доступная наиболее авторитетным членам силовых структур Nanotrasen. А еще у неё нет тупого конца."
	lefthand_file = 'modular_bandastation/objects/icons/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/melee_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/melee.dmi'
	icon_state = "electrostaff_orange"
	inhand_icon_state = "electrostaff_orange"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	throwforce = 7
	cooldown = 3.5 SECONDS
	preload_cell_type = /obj/item/stock_parts/cell/high
	block_chance = 30

/obj/item/melee/baton/security/electrostaff/purple
	icon_state = "electrostaff_purple"
	inhand_icon_state = "electrostaff_purple"

/obj/item/melee/baton/security/electrostaff/red
	icon_state = "electrostaff_red"
	inhand_icon_state = "electrostaff_red"

/obj/item/melee/baton/security/electrostaff/blue
	icon_state = "electrostaff_blue"
	inhand_icon_state = "electrostaff_blue"

/obj/item/melee/baton/security/electrostaff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		wieldsound = 'modular_bandastation/objects/sounds/weapons/melee/electrostaff/on.ogg', \
		require_twohands = TRUE, \
	)

/obj/item/melee/baton/security/electrostaff/examine(mob/user)
	. = ..()
	. -= span_notice("This item can be recharged in a recharger. Using a screwdriver on this item will allow you to access its power cell, which can be replaced.")
	. += span_notice("Данный предмет не имеет внешних разъемов для зарядки. Используйте <b>отвертку</b> для доступа к внутренней батарее, чтобы заменить или зарядить её.")

/obj/item/weaponcrafting/gunkit/electrostaff
	name = "\improper electrostaff parts kit"
	desc = "Возьмите 2 оглушающие дубинки. Соедините их вместе, поместив внутрь батарею. Используйте остальные инструменты (лишних винтиков быть не должно)."

/datum/design/electrostaff
	name = "Electrostaff Parts Kit"
	desc = "Оперативный ответ."
	id = "electrostaff_kit"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/weaponcrafting/gunkit/electrostaff
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/crafting_recipe/electrostaff
	name = "Electrostaff"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/melee/baton/security/electrostaff
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
	prereq_ids = list("weaponry",)
	design_ids = list(
		"electrostaff_kit",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

// Awaymission gun
/obj/item/gun/energy/laser/awaymission_aeg
	name = "Wireless Energy Gun"
	desc = "An energy gun that recharges wirelessly during away missions. Does not work outside the gate."
	icon = 'modular_bandastation/objects/icons/laser.dmi'
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon_state = "laser_gate"
	inhand_icon_state = "laser_gate"
	force = 10
	selfcharge = TRUE // Selfcharge is enabled and disabled, and used as the away mission tracker
	can_charge = 0

// Проверка чтобы не было зарядки на станции
/obj/item/gun/energy/laser/awaymission_aeg/Initialize(mapload, /obj/item/M)
	. = ..()
	on_changed_z_level()

/obj/item/gun/energy/laser/awaymission_aeg/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	. = ..()
	if(is_away_level(loc.z) || is_secret_level(loc.z))
		if(ismob(loc))
			to_chat(loc, span_notice("Ваш [src.name] активируется, начиная аккумулировать энергию из материи сущего."))
		selfcharge = TRUE
		return
	if(is_station_level(loc.z))
		to_chat(loc, span_danger("Ваш [src.name] деактивируется, так как он подавляется системами станции.</span>"))
	cell.charge = 0
	selfcharge = FALSE
	update_icon()

/obj/item/gun/energy/laser/awaymission_aeg/rnd
	name = "Exploreverse Mk.I"
	desc = "Прототип оружия с миниатюрным реактором для исследований в крайне отдаленных секторах. \
	\n Данная модель использует экспериментальную систему обратного восполнения, работающую на принципе огромной аккумуляции энергии, но крайне уязвимую к радиопомехам, которыми кишит сектор станции, попростую не работая там."

/obj/item/gun/energy/laser/awaymission_aeg/rnd/mk2
	name = "Exploreverse Mk.II"
	desc = "Второй прототип оружия с миниатюрным реактором и забавным рычагом для исследований в крайне отдаленных секторах. \
	\nДанная модель оснащена системой ручного восполнения энергии \"Za.E.-8 A.L'sya\", \
	позволяющей в короткие сроки восполнить необходимую электроэнергию с помощью ручного труда и конвертации личной энергии подключенного к системе зарядки. \
	\nТеперь еще более нелепый дизайн с торчащими проводами!"
	icon_state = "laser_gate_mk2"

/obj/item/gun/energy/laser/awaymission_aeg/rnd/mk2/attack_self(mob/living/user)
	var/msg_for_all = span_warning("[user.name] усердно давит на рычаг зарядки [src], но он не поддается!")
	var/msg_for_user = span_notice("Вы пытаетесь надавить на рычаг зарядки [src], но он заблокирован.")
	var/msg_recharge_all = span_notice("[user.name] усердно давит на рычаг зарядки [src]...")
	var/msg_recharge_user = span_notice("Вы со всей силы давите на рычаг зарядки [src], пытаясь зарядить её...")

	if(!is_away_level(loc.z) || !is_secret_level(loc.z))
		user.visible_message(msg_for_all, msg_for_user)
		return FALSE

	if(cell.charge >= cell.maxcharge)
		user.visible_message(msg_for_all, msg_for_user)
		return FALSE

	if(user.nutrition <= NUTRITION_LEVEL_STARVING)
		user.visible_message(
			span_warning("[user.name] слабо давит на [src], но бесполезно: слишком мало сил!"),
			span_notice("Вы пытаетесь надавить на рычаг зарядки [src], но не можете из-за голода и усталости!"))
		return FALSE

	user.visible_message(msg_recharge_all, msg_recharge_user)
	playsound(loc, 'sound/effects/sparks3.ogg', 10, 1)
	do_sparks(1, 1, src)

	if(!do_after(user, 3 SECONDS, target = src))
		return
	cell.give(100000)
	user.adjust_nutrition(-25)
	. = ..()

/datum/design/gate_gun_mk1
	name = "Gate Energy Gun MK1"
	desc = "An energy gun with an experimental miniaturized reactor. Only works in the gate" //не отображаемое описание, т.к. печатается без кейса
	id = "gate_gun"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.25)
	build_path = /obj/item/gun/energy/laser/awaymission_aeg/rnd
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/gate_gun_mk2
	name = "Gate Energy Gun MK2"
	desc = "An energy gun with an experimental miniaturized reactor. Only works in the gate" //не отображаемое описание, т.к. печатается без кейса
	id = "gate_gun_mk2"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5)
	build_path = /obj/item/gun/energy/laser/awaymission_aeg/rnd/mk2
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/techweb_node/awaymission_aeg
	id = "gate_gun"
	display_name = "Awaymission Laser Weaponary Research"
	description = "Изучение лазерного оружия для гейтвея."
	prereq_ids = list(
		"adv_weaponry",
	)
	design_ids = list(
		"gate_gun_mk2",
		"gate_gun",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

#undef CALIBER_9X19RMM
#undef CALIBER_9X19BMM
#undef CALIBER_9X19MM
#undef CALIBER_9X19AMM
#undef CALIBER_44
#undef CALIBER_127
#undef CALIBER_PEA
#undef CALIBER_PNEUMA

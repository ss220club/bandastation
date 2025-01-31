/obj/item/ammo_casing/c35sol
	name = ".35 Sol Short lethal bullet casing"
	desc = "A SolFed standard lethal pistol round."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "35sol"
	caliber = CALIBER_SOL35SHORT
	projectile_type = /obj/projectile/bullet/c35sol

/obj/projectile/bullet/c35sol
	name = ".35 Sol Short bullet"
	damage = 15
	wound_bonus = -5 // Normal bullets are 20
	bare_wound_bonus = 5
	embed_falloff_tile = -4

/obj/item/ammo_box/c35sol
	name = "ammo box (.35 Sol Short lethal)"
	desc = "A box of .35 Sol Short lethal pistol rounds, holds twenty-four rounds."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "35box"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL
	caliber = CALIBER_SOL35SHORT
	ammo_type = /obj/item/ammo_casing/c35sol
	max_ammo = 24

/obj/item/ammo_casing/c35sol/rubber
	name = ".35 Sol Short rubber bullet casing"
	desc = "A SolFed standard less-lethal pistol round. Exhausts targets on hit, has a tendency to bounce off walls at shallow angles."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "35sol_disabler"
	projectile_type = /obj/projectile/bullet/c35sol/rubber
	harmful = FALSE


/obj/projectile/bullet/c35sol/rubber
	name = ".35 Sol Short rubber bullet"
	damage = 5
	stamina = 20
	wound_bonus = -40
	bare_wound_bonus = -20
	weak_against_armour = TRUE

	// The stats of the ricochet are a nerfed version of detective revolver rubber ammo
	// This is due to the fact that there's a lot more rounds fired quickly from weapons that use this, over a revolver
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 5
	ricochets_max = 4
	ricochet_incidence_leeway = 50
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null


/obj/item/ammo_box/c35sol/rubber
	name = "ammo box (.35 Sol Short rubber)"
	desc = "A box of .35 Sol Short less-lethal pistol rounds, holds twenty-four rounds. The blue stripe indicates this should hold less-lethal ammunition."
	icon_state = "35box_disabler"
	ammo_type = /obj/item/ammo_casing/c35sol/rubber


// .35 Sol ripper, similar to the detective revolver's dumdum rounds, causes slash wounds and is weak to armor

/obj/item/ammo_casing/c35sol/ripper
	name = ".35 Sol Short ripper bullet casing"
	desc = "A SolFed standard ripper pistol round. Causes slashing wounds on targets, but is weak to armor."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "35sol_shrapnel"
	projectile_type = /obj/projectile/bullet/c35sol/ripper


/obj/projectile/bullet/c35sol/ripper
	name = ".35 Sol ripper bullet"
	damage = 12
	weak_against_armour = TRUE
	sharpness = SHARP_EDGED
	ricochets_max = 0
	wound_bonus = 20
	bare_wound_bonus = 20
	embed_type = /datum/embedding/bullet/c35sol/ripper
	embed_falloff_tile = -15

/datum/embedding/bullet/c35sol/ripper
	embed_chance = 75
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/item/ammo_box/c35sol/ripper
	name = "ammo box (.35 Sol Short ripper)"
	desc = "A box of .35 Sol Short ripper pistol rounds, holds twenty-four rounds. The orange stripe indicates this should hold hollowpoint-like ammunition."
	icon_state = "35box_shrapnel"
	ammo_type = /obj/item/ammo_casing/c35sol/ripper

//.35 sol pierce are the AP rounds for this weapon

/obj/item/ammo_casing/c35sol/pierce
	name = ".35 Sol Short armor piercing bullet casing"
	desc = "A SolFed standard armor piercing pistol round. The silver stripe indicates this should hold pierce-like ammunition. Penetrates armor, but is rather weak against un-armored targets."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "35sol_ap"
	projectile_type = /obj/projectile/bullet/c35sol/pierce

/obj/projectile/bullet/c35sol/pierce
	name = ".35 Sol Short armor piercing bullet"
	damage = 13
	bare_wound_bonus = -30
	armour_penetration = 20

/obj/item/ammo_box/c35sol/pierce
	name = "ammo box (.35 Sol Short armor piercing)"
	desc = "A box of .35 Sol Short armor piercing pistol rounds, holds twenty-four rounds."
	icon_state = "35box_ap"
	ammo_type = /obj/item/ammo_casing/c35sol/pierce

/obj/item/ammo_box/magazine/c35sol_pistol
	name = "Sol pistol magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve rounds."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "pistol_35_standard"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_TINY
	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 12

/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo
	name = "Sol extended pistol magazine"
	desc = "An extended magazine for SolFed pistols, holds sixteen rounds."
	icon_state = "pistol_35_stended"
	w_class = WEIGHT_CLASS_NORMAL
	max_ammo = 16

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/rubber
	name = "Sol rubber pistol magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve rubber rounds."
	icon_state = "pistol_35_standard_disabler"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c35sol/rubber

/obj/item/ammo_box/magazine/c35sol_pistol/rubber/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/rubber
	name = "Sol rubber extended pistol magazine"
	desc = "An extended magazine for SolFed pistols, holds sixteen rubber rounds."
	icon_state = "pistol_35_stended_disabler"
	ammo_type = /obj/item/ammo_casing/c35sol/rubber

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/rubber/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/pierce
	name = "Sol AP pistol magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve pierce rounds."
	icon_state = "pistol_35_standard_ap"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c35sol/pierce

/obj/item/ammo_box/magazine/c35sol_pistol/pierce/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/pierce
	name = "Sol AP extended pistol magazine"
	desc = "An extended magazine for SolFed pistols, holds sixteen pierce rounds."
	icon_state = "pistol_35_stended_ap"
	ammo_type = /obj/item/ammo_casing/c35sol/pierce

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/pierce/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/ripper
	name = "Sol HP pistol magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve ripper rounds."
	icon_state = "pistol_35_standard_shrapnel"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c35sol/ripper

/obj/item/ammo_box/magazine/c35sol_pistol/ripper/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/ripper
	name = "Sol HP extended pistol magazine"
	desc = "An extended magazine for SolFed pistols, holds sixteen ripper rounds."
	icon_state = "pistol_35_stended_shrapnel"
	ammo_type = /obj/item/ammo_casing/c35sol/ripper

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/ripper/starts_empty
	start_empty = TRUE

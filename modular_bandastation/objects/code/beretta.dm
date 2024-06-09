//Beretta M9//

#define CALIBER_9X19MM "9x19mm"
#define CALIBER_9X19BMM "9x19bmm"

/obj/item/gun/ballistic/automatic/pistol/beretta
	name = "Беретта M9"
	desc = "Один из самых распространенных и узнаваемых пистолетов во вселенной. К сожалению, из-за особенности ствола, на пистолет нельзя приделать глушитель. Старая добрая классика."
	icon = 'modular_bandastation/objects/icons/guns.dmi'
	lefthand_file = 'modular_bandastation/objects/icons/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/guns_righthand.dmi'
	icon_state = "beretta_modified"
	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = FALSE
	unique_reskin = list(
		"Modified grip" = "beretta_modified",
		"Black skin" = "beretta_black",
		"Desert skin" = "beretta_desert",
	)
	accepted_magazine_type = /obj/item/ammo_box/magazine/beretta
	fire_sound = 'modular_bandastation/objects/sounds/weapons/gunshots/beretta_shot.ogg'

/obj/item/gun/ballistic/automatic/pistol/beretta/reskin_obj(mob/user)
	. = ..()
	switch(icon_state)
		if("Modified grip")
			icon_state = "beretta_modified"
		if("Black skin")
			icon_state = "beretta_black"
		if("Desert skin")
			icon_state = "beretta_desert"
	user.update_held_items()

/obj/item/gun/ballistic/automatic/pistol/beretta/add_seclight_point()
	. = ..()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'modular_bandastation/objects/icons/guns.dmi', \
		light_overlay = "beretta_light", \
		overlay_x = 0, \
		overlay_y = 0)

/obj/item/ammo_box/magazine/beretta
	name = "beretta rubber 9x19mm magazine"
	desc = "Магазин резиновых патронов калибра 9x19mm."
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "berettar"
	ammo_type = /obj/item/ammo_casing/beretta/mmrub919
	max_ammo = 10
	multiload = 0
	caliber = CALIBER_9X19MM
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = FALSE

/obj/item/ammo_box/magazine/beretta/mm919
	name = "beretta lethal 9x19mm magazine"
	desc = "Магазин летальных патронов калибра 9x19mm."
	icon_state = "berettal"
	ammo_type = /obj/item/ammo_casing/beretta/mm919

/obj/item/ammo_box/magazine/beretta/mmbsp919
	name = "beretta bluespace 9x19mm magazine"
	desc = "Магазин экспериментальных блюспейс патронов калибра 9x19mm. Из-за особенности корпуса вмещает только блюспейс патроны."
	icon_state = "berettab"
	ammo_type = /obj/item/ammo_casing/beretta/mmbsp919
	caliber = CALIBER_9X19BMM

/obj/item/ammo_box/magazine/beretta/mmap919
	name = "beretta armor-piercing 9x19mm magazine"
	desc = "Магазин бронебойных патронов калибра 9x19mm."
	icon_state = "berettaap"
	ammo_type = /obj/item/ammo_casing/beretta/mmap919

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
	caliber = CALIBER_9X19MM
	name = "9x19mm armor-piercing bullet casing"
	desc = "A 9x19 armor-piercing bullet casing."
	projectile_type = /obj/projectile/bullet/mmap919

/obj/projectile/bullet/mmap919
	name = "9x19mm armor-piercing bullet"
	damage = 18
	armour_penetration = 15

/obj/item/ammo_casing/beretta/mmrub919
	name = "9x19mm rubber bullet casing"
	caliber = CALIBER_9X19MM
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
	caliber = "919mm"
	icon = 'modular_bandastation/objects/icons/ammo.dmi'
	icon_state = "casingmm919"
	desc = "A 9x19 lethal bullet casing."
	projectile_type = /obj/projectile/bullet/mm919

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
		RND_CATEGORY_INITIAL,
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
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

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
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

#undef CALIBER_9X19MM
#undef CALIBER_9X19BMM

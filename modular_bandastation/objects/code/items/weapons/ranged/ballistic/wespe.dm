/obj/item/gun/ballistic/automatic/pistol/sol
	name = "Wespe Pistol"
	desc = "The standard issue service pistol of SolFed's various military branches. Uses .35 Sol and comes with an attached light."
	icon = 'modular_bandastation/objects/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "wespe"
	fire_sound = 'modular_bandastation/objects/sounds/pistol_light.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	special_mags = TRUE
	suppressor_x_offset = 7
	suppressor_y_offset = 0
	fire_delay = 0.3 SECONDS
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = "wespe",
		"Black" = "wespe_black",
	)


/obj/item/gun/ballistic/automatic/pistol/sol/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

/obj/item/gun/ballistic/automatic/pistol/sol/examine_more(mob/user)
	. = ..()

	. += "The Wespe is a pistol that was made entirely for military use. \
		Required to use a standard round, standard magazines, and be able \
		to function in all of the environments that SolFed operated in \
		commonly. These qualities just so happened to make the weapon \
		popular in frontier space and is likely why you are looking at \
		one now."

	return .

/obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	spawnwithmagazine = FALSE

/datum/supply_pack/security/wespe_guns
	name = "Wespe Pistols Crate"
	desc = "Need new handguns? In that case, this crate contains two Wespe handguns with two rubber magazines."
	cost = CARGO_CRATE_VALUE * 10
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/sol/no_mag = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/rubber = 2,
		)
	crate_name = "Wespe handguns crate"

/datum/supply_pack/security/wespe_ammo
	name = ".35 Sol Ammo Crate"
	desc = "Short on ammo? No worries, this crate contains two .35 Sol rubber non-lethal magazines, two lethal magazines, and respective ammunition packets."
	cost = CARGO_CRATE_VALUE * 6
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/rubber = 2,
		/obj/item/ammo_box/c35sol = 1,
		/obj/item/ammo_box/c35sol/rubber = 1,
		)
	crate_name = ".35 Sol ammo crate"

/datum/supply_pack/security/wespe_ammospecial
	name = ".35 Sol Special Ammo Crate"
	desc = "Need some special ammunition? No worries, this crate contains two .35 Sol AP magazines, two HP magazines, and respective ammunition packets."
	cost = CARGO_CRATE_VALUE * 8
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol/pierce = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/ripper = 2,
		/obj/item/ammo_box/c35sol/pierce = 1,
		/obj/item/ammo_box/c35sol/ripper = 1,
		)
	crate_name = ".35 Sol special ammo crate"

/datum/supply_pack/security/wespe_mags_extended
	name = ".35 Sol Extended Magazines Crate"
	desc = "Not enough bullets in mag? No worries, this crate contains two extended .35 Sol magazines."
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo/rubber = 1,
		)
	crate_name = ".35 Sol extended magazines crate"

/datum/supply_pack/goody/wespe_mags_extended_single
	name = ".35 Sol Extended Magazine Crate"
	desc = "Not enough bullets in mag? No worries, this crate contains one extended .35 Sol magazine."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty = 1,
	    )

/datum/supply_pack/goody/wespe_single
	name = "Wespe Pistol Single-Pack"
	desc = "Need new handgun? In that case, this crate contains Wespe handgun with a magazine."
	cost = CARGO_CRATE_VALUE * 6
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/sol/no_mag = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 1,
		)

/datum/supply_pack/goody/rubber35
	name = ".35 Sol Rubber Ammo Box"
	desc = "Need some non-lethal ammo? In that case, this crate contains a box of .35 Sol rubber ammo."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol/rubber = 1,
		)

/datum/supply_pack/goody/ripper35
	name = ".35 Sol HP Ammo Box"
	desc = "Need some HP ammo? In that case, this crate contains a box of .35 Sol hollow-point ammo."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol/ripper = 1,
		)

/datum/supply_pack/goody/pierce35
	name = ".35 Sol AP Ammo Box"
	desc = "Need some AP ammo? In that case, this crate contains a box of .35 Sol armor-piercing ammo."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol/pierce = 1,
		)

/datum/supply_pack/goody/lethal35
	name = ".35 Sol Ammo Box"
	desc = "Need some lethal ammo? In that case, this crate contains a box of .35 Sol lethal ammo."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol = 1,
		)

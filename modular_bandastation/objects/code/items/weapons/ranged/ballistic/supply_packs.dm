/datum/supply_pack/security/wespe_guns
	name = "Wespe Pistols Crate"
	desc = "Вам нужны новые пистолеты? В таком случае в этом ящике находятся два пистолета Wespe с двумя резиновыми магазинами."
	cost = CARGO_CRATE_VALUE * 10
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/wespe/no_mag = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/rubber = 2,
		)
	crate_name = "Wespe handguns crate"

/datum/supply_pack/security/wespe_ammo
	name = ".35 Sol Ammo Crate"
	desc = "Не хватает патронов? Не беспокойтесь, в этом ящике вы найдете два нелетальных магазина и два летальных магазина калибра .35 Sol, и соответствующие коробки с боеприпасами."
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
	desc = "Нужны особые боеприпасы? Не беспокойтесь, в этом ящике вы найдете два бронебойных магазина и два экспансивных магазина калибра .35 Sol, и соответствующие коробки с боеприпасами."
	cost = CARGO_CRATE_VALUE * 8
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol/ap = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/ripper = 2,
		/obj/item/ammo_box/c35sol/ap = 1,
		/obj/item/ammo_box/c35sol/ripper = 1,
		)
	crate_name = ".35 Sol special ammo crate"

/datum/supply_pack/security/wespe_mags_extended
	name = ".35 Sol Extended Magazines Crate"
	desc = "Не хватает патронов в магазине? Не беспокойтесь, в этом ящике находятся два увеличенных магазина калибра .35 Sol."
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo/rubber = 1,
		)
	crate_name = ".35 Sol extended magazines crate"

/datum/supply_pack/goody/wespe_mags_extended_single
	name = ".35 Sol Extended Magazine Crate"
	desc = "Не хватает патронов в магазине? Не беспокойтесь, в этом ящике находится один увеличенный магазин .35 Sol."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty = 1,
	    )

/datum/supply_pack/goody/wespe_single
	name = "Wespe Pistol Single-Pack"
	desc = "Вам нужен новый пистолет? В таком случае, в этом ящике вы найдете себе один пистолет Wespe с магазином."
	cost = CARGO_CRATE_VALUE * 6
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/wespe/no_mag = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 1,
		)

/datum/supply_pack/goody/rubber35
	name = ".35 Sol Rubber Ammo Box"
	desc = "Нужны нелетальные патроны? В таком случае, в этом ящике находится коробка резиновых патронов калибра .35 Sol."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol/rubber = 1,
		)

/datum/supply_pack/goody/ripper35
	name = ".35 Sol HP Ammo Box"
	desc = "Нужны экспансивные патроны? В таком случае, в этом ящике находится коробка с экспансивными патронами .35 Sol."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol/ripper = 1,
		)

/datum/supply_pack/goody/ap35
	name = ".35 Sol AP Ammo Box"
	desc = "Нужны бронебойные патроны? В таком случае, в этом ящике находится коробка с бронебойными патронами калибра .35 Sol."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol/ap = 1,
		)

/datum/supply_pack/goody/lethal35
	name = ".35 Sol Ammo Box"
	desc = "Нужны летальные патроны? В таком случае, в этом ящике находится коробка с летальными патронами калибра .35 Sol."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_WEAPONS
	contains = list(
		/obj/item/ammo_box/c35sol = 1,
		)

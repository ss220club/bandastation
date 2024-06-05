// When you need an empty space
/datum/nothing

// Supply Crate
/datum/supply_pack/misc/id_skins
	name = "Наклейки на карточку"
	crate_type = /obj/structure/closet/crate/wooden
	contains = list()
	cost = CARGO_CRATE_VALUE * 10
	crate_name = "ящик с наклейками"

/datum/supply_pack/misc/id_skins/New()
	for(var/i in 1 to 10)
		contains += pick(subtypesof(/obj/item/id_skin))
	. = ..()

// Spawner
/obj/effect/spawner/random/id_skins
	name = "Случайная наклейка на карту"
	icon = 'modular_bandastation/maps220/icons/spawner_icons.dmi'
	icon_state = "ID_Random"
	loot = list(
		/obj/item/id_skin/colored = 10,
		/obj/item/id_skin/donut = 5,
		/obj/item/id_skin/business = 5,
		/obj/item/id_skin/ussp = 5,
		/obj/item/id_skin/colored/silver = 5,
		/obj/item/id_skin/silver = 5,
		/obj/item/id_skin/gold = 1,
		/obj/item/id_skin/lifetime = 1,
		/obj/item/id_skin/clown = 1,
		/obj/item/id_skin/neon = 1,
		/obj/item/id_skin/colored/neon = 1,
		/obj/item/id_skin/missing = 1,
		/obj/item/id_skin/ouija = 1,
		/obj/item/id_skin/paradise = 1,
		/obj/item/id_skin/rainbow = 1,
		/obj/item/id_skin/space = 1,
		/obj/item/id_skin/kitty = 1,
		/obj/item/id_skin/colored/kitty = 1,
		/obj/item/id_skin/cursedmiku = 1,
		/obj/item/id_skin/colored/snake = 1,
		/obj/item/id_skin/magic = 1,
		/obj/item/id_skin/terminal = 1,
		/obj/item/id_skin/jokerge = 1,
		/obj/item/id_skin/boykisser = 1
	)

/obj/effect/spawner/random/id_skins/no_chance
	loot = list(
		/datum/nothing = 80,
		/obj/item/id_skin/colored = 10,
		/obj/item/id_skin/donut = 5,
		/obj/item/id_skin/business = 5,
		/obj/item/id_skin/ussp = 5,
		/obj/item/id_skin/colored/silver = 5,
		/obj/item/id_skin/silver = 5,
		/obj/item/id_skin/gold = 1,
		/obj/item/id_skin/lifetime = 1,
		/obj/item/id_skin/clown = 1,
		/obj/item/id_skin/neon = 1,
		/obj/item/id_skin/colored/neon = 1,
		/obj/item/id_skin/missing = 1,
		/obj/item/id_skin/ouija = 1,
		/obj/item/id_skin/paradise = 1,
		/obj/item/id_skin/rainbow = 1,
		/obj/item/id_skin/space = 1,
		/obj/item/id_skin/kitty = 1,
		/obj/item/id_skin/colored/kitty = 1,
		/obj/item/id_skin/cursedmiku = 1,
		/obj/item/id_skin/colored/snake = 1,
		/obj/item/id_skin/magic = 1,
		/obj/item/id_skin/terminal = 1,
		/obj/item/id_skin/jokerge = 1,
		/obj/item/id_skin/boykisser = 1
	)

// Prize Counter
/obj/item/storage/box/id_skins
	name = "наклейки на карту"
	desc = "Коробка с кучкой наклеек на ID карту."
	icon = 'modular_bandastation/objects/icons/id_skins.dmi'
	icon_state = "id_skins_box"

/obj/item/storage/box/id_skins/PopulateContents()
	for(var/I in 1 to 3)
		var/skin = pick(subtypesof(/obj/item/id_skin))
		new skin(src)

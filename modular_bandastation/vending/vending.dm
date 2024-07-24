// New sprite for robodrobe and new item list
/obj/machinery/vending/wardrobe/robo_wardrobe/Initialize(mapload)
	icon = 'modular_bandastation/icons/obj/machines/vending.dmi'
	icon_state = "robodrobe"

	var/list/new_products = list(
		/obj/item/clothing/head/beret = 2,
		/obj/item/clothing/head/cowboy/roboticist_reborn = 2,
		/obj/item/clothing/head/soft/roboticist_cap_reborn = 2,
		/obj/item/clothing/suit/hooded/roboticist_cloak_reborn = 2,
		/obj/item/clothing/suit/toggle/jacket/roboticist_reborn = 2,
		/obj/item/clothing/suit/hooded/wintercoat/science/roboticist_reborn = 2,
		/obj/item/clothing/under/rank/rnd/roboticist_reborn = 2,
		/obj/item/clothing/under/rank/rnd/roboticist_reborn/red = 2,
		/obj/item/clothing/under/rank/rnd/roboticist_reborn/hoodie = 2,
		/obj/item/clothing/under/rank/rnd/roboticist_reborn/skirt = 2,
		/obj/item/clothing/under/rank/rnd/roboticist_reborn/skirt/red = 2,
		)
	new_products |= products
	products = new_products
	. = ..()

/obj/machinery/vending/autodrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/head/ratge = 1,
		)
	. = ..()

/obj/machinery/vending/chefdrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/under/rank/civilian/chef/red = 2,
		/obj/item/clothing/suit/chef/red = 2,
		/obj/item/clothing/head/chefhat/red = 2,
		/obj/item/storage/belt/chef/apron = 1,
		/obj/item/storage/belt/chef/apron/red = 1,
		)
	. = ..()

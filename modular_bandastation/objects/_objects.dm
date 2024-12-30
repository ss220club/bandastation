/datum/modpack/objects
	name = "Объекты"
	desc = "В основном включает в себя портированные объекты и всякие мелочи, которым не нужен отдельный модпак."
	author = "dj-34, Chorden"

/datum/modpack/objects/initialize()
	. = ..()
	GLOB.autodrobe_fancy_items += list(
		/obj/item/clothing/under/carnival/formal = 2,
		/obj/item/clothing/under/carnival/formal/black_purple = 2,
		/obj/item/clothing/under/carnival/formal/sand_white = 2,
		/obj/item/clothing/under/carnival/formal/white_lightblue = 2,
		/obj/item/clothing/under/carnival/jacket = 2,
		/obj/item/clothing/under/carnival/jacket/black_purple = 2,
		/obj/item/clothing/under/carnival/jacket/sand_white = 2,
		/obj/item/clothing/under/carnival/jacket/white_lightblue = 2,
		/obj/item/clothing/under/carnival/dress_fancy = 2,
		/obj/item/clothing/under/carnival/dress_fancy/violet_gold = 2,
		/obj/item/clothing/under/carnival/dress_fancy/purple_black_white = 2,
		/obj/item/clothing/under/carnival/dress_fancy/lightblue_white = 2,
		/obj/item/clothing/under/carnival/dress_corset = 2,
		/obj/item/clothing/under/carnival/dress_corset/violet_gold = 2,
		/obj/item/clothing/under/carnival/dress_corset/purple_black = 2,
		/obj/item/clothing/under/carnival/dress_corset/lightblue_white = 2,
		/obj/item/clothing/mask/carnival/feather = 2,
		/obj/item/clothing/mask/carnival/feather/violet_blue = 2,
		/obj/item/clothing/mask/carnival/feather/green = 2,
		/obj/item/clothing/mask/carnival/feather/red_black = 2,
		/obj/item/clothing/mask/carnival/half = 2,
		/obj/item/clothing/mask/carnival/half/violet = 2,
		/obj/item/clothing/mask/carnival/half/green = 2,
		/obj/item/clothing/mask/carnival/half/red_black = 2,
		/obj/item/clothing/mask/carnival/triangles = 2,
		/obj/item/clothing/mask/carnival/triangles/blue_violet = 2,
		/obj/item/clothing/mask/carnival/triangles/green = 2,
		/obj/item/clothing/mask/carnival/triangles/red_black = 2,
		/obj/item/clothing/mask/carnival/colored = 2,
		/obj/item/clothing/mask/carnival/colored/violet = 2,
		/obj/item/clothing/mask/carnival/colored/green = 2,
		/obj/item/clothing/mask/carnival/colored/red_black = 2,
	)
	GLOB.autodrobe_other_items += list(
		/obj/item/clothing/suit/ny_sweater = 5,
		/obj/item/clothing/suit/garland = 5,
		/obj/item/clothing/neck/cloak/ny_cloak = 5,
		/obj/item/clothing/neck/garland = 5,
	)
	GLOB.all_autodrobe_items |= (
		GLOB.autodrobe_fancy_items \
		+ GLOB.autodrobe_other_items
	)

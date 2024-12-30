/datum/modpack/objects
	name = "Объекты"
	desc = "В основном включает в себя портированные объекты и всякие мелочи, которым не нужен отдельный модпак."
	author = "dj-34, Chorden"

/datum/modpack/objects/initialize()
	. = ..()
	GLOB.autodrobe_fancy_items += list(
		/obj/item/clothing/under/carnival/formal = 3,
		/obj/item/clothing/under/carnival/jacket = 3,
		/obj/item/clothing/under/carnival/dress_fancy = 3,
		/obj/item/clothing/under/carnival/dress_corset = 3,
		/obj/item/clothing/under/carnival/dress_corset = 3,
		/obj/item/clothing/mask/carnival/feather = 3,
		/obj/item/clothing/mask/carnival/half = 3,
		/obj/item/clothing/mask/carnival/triangles = 3,
		/obj/item/clothing/mask/carnival/colored = 3,
	)
	GLOB.autodrobe_other_items += list(
		/obj/item/clothing/suit/ny_sweater = 3,
		/obj/item/clothing/suit/garland = 3,
		/obj/item/clothing/neck/cloak/ny_cloak = 3,
		/obj/item/clothing/neck/garland = 3,
	)
	GLOB.all_autodrobe_items |= (
		GLOB.autodrobe_fancy_items \
		+ GLOB.autodrobe_other_items
	)

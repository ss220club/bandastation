
/datum/modpack/objects
	name = "Объекты"
	desc = "В основном включает в себя портированные объекты и всякие мелочи, которым не нужен отдельный модпак."
	author = "dj-34, Chorden, fineks"

/datum/modpack/objects/initialize()
	. = ..()
	GLOB.autodrobe_fancy_items += list(
		/obj/item/clothing/under/carnival/formal = 2,
		/obj/item/clothing/under/carnival/jacket = 2,
		/obj/item/clothing/under/carnival/dress_fancy = 2,
		/obj/item/clothing/under/carnival/dress_corset = 2,
		/obj/item/clothing/mask/carnival/feather = 2,
		/obj/item/clothing/mask/carnival/half = 2,
		/obj/item/clothing/mask/carnival/triangles = 2,
		/obj/item/clothing/mask/carnival/colored = 2,
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
	// |= отказался перезаписывать один только DYE_SYNDICATE, так что пришлось перезаписывать весь DYE_REGISTRY_SNEAKERS
	GLOB.dye_registry["sneakers"] = list(
			DYE_RED = /obj/item/clothing/shoes/sneakers/red,
			DYE_ORANGE = /obj/item/clothing/shoes/sneakers/orange,
			DYE_YELLOW = /obj/item/clothing/shoes/sneakers/yellow,
			DYE_GREEN = /obj/item/clothing/shoes/sneakers/green,
			DYE_BLUE = /obj/item/clothing/shoes/sneakers/blue,
			DYE_PURPLE = /obj/item/clothing/shoes/sneakers/purple,
			DYE_BLACK = /obj/item/clothing/shoes/sneakers/black,
			DYE_WHITE = /obj/item/clothing/shoes/sneakers/white,
			DYE_RAINBOW = /obj/item/clothing/shoes/sneakers/rainbow,
			DYE_MIME = /obj/item/clothing/shoes/sneakers/black,
			DYE_CLOWN = /obj/item/clothing/shoes/sneakers/rainbow,
			DYE_QM = /obj/item/clothing/shoes/sneakers/brown,
			DYE_CAPTAIN = /obj/item/clothing/shoes/sneakers/brown,
			DYE_HOP = /obj/item/clothing/shoes/sneakers/brown,
			DYE_CE = /obj/item/clothing/shoes/sneakers/brown,
			DYE_RD = /obj/item/clothing/shoes/sneakers/brown,
			DYE_CMO = /obj/item/clothing/shoes/sneakers/brown,
			DYE_SYNDICATE = /obj/item/clothing/shoes/sandal/syndie,
			DYE_CENTCOM = /obj/item/clothing/shoes/combat
	)


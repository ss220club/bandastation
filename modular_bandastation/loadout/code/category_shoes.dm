/datum/loadout_category/shoes
	category_name = "Ноги"
	category_ui_icon = FA_ICON_SHOE_PRINTS
	type_to_generate = /datum/loadout_item/shoes
	tab_order = /datum/loadout_category/head::tab_order + 1

/datum/loadout_item/shoes
	abstract_type = /datum/loadout_item/shoes

/datum/loadout_item/glasses/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.shoes)
		LAZYADD(outfit.backpack_contents, outfit.shoes)
	outfit.shoes = item_path

///Т0
/datum/loadout_item/shoes/sneakers
	name = "Кросовки"
	item_path = /obj/item/clothing/shoes/sneakers

///Т0
/datum/loadout_item/shoes/russian
	name = "Русские ботинки"
	item_path = /obj/item/clothing/shoes/russian

///Т0
/datum/loadout_item/shoes/discoshoes
	name = "Дискоботы"
	item_path = /obj/item/clothing/shoes/discoshoes

///Т0
/datum/loadout_item/shoes/roman
	name = "Римские сандалии"
	item_path = /obj/item/clothing/shoes/roman

///Т0
/datum/loadout_item/shoes/ducky_shoes
	name = "Утинные тапки"
	item_path = /obj/item/clothing/shoes/ducky_shoes

///Т0
/datum/loadout_item/shoes/laceup
	name = "Туфли"
	item_path = /obj/item/clothing/shoes/laceup

///Т0
/datum/loadout_item/shoes/sandal
	name = "Сандалии"
	item_path = /obj/item/clothing/shoes/sandal

///Т0
/datum/loadout_item/shoes/cowboy
	name = "Ковбойские сапоги"
	item_path = /obj/item/clothing/shoes/cowboy

///Т0
/datum/loadout_item/shoes/jackboots
	name = "Берцы"
	item_path = /obj/item/clothing/shoes/jackboots

///Т0
/datum/loadout_item/shoes/shark_shoes
	name = "Акульи тапочки"
	item_path = /obj/item/clothing/shoes/shark

///Т0
/datum/loadout_item/shoes/shark_light_shoes
	name = "Акульи тапочки (светло-голубые)"
	item_path = /obj/item/clothing/shoes/shark/light

///Т1
/datum/loadout_item/shoes/neon_shoes
	name = "Неоновые кросовки"
	item_path = /obj/item/clothing/shoes/black/neon

/datum/loadout_category/gloves
	category_name = "Руки"
	category_ui_icon = FA_ICON_HANDS
	type_to_generate = /datum/loadout_item/gloves
	tab_order = /datum/loadout_category/head::tab_order + 1

/datum/loadout_item/gloves
	abstract_type = /datum/loadout_item/gloves

/datum/loadout_item/glasses/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.gloves)
		LAZYADD(outfit.backpack_contents, outfit.gloves)
	outfit.gloves = item_path

///Т0
/datum/loadout_item/gloves/gloves
	name = "Черные перчатки"
	item_path = /obj/item/clothing/gloves/color/black

///Т0
/datum/loadout_item/gloves/gloves
	name = "Перчатки горничной"
	item_path = /obj/item/clothing/gloves/maid

///Т0
/datum/loadout_item/gloves/gloves
	name = "Байкерские перчатки"
	item_path = /obj/item/clothing/gloves/fingerless

///Т1
/datum/loadout_item/gloves/biker_gloves
	name = "Байкерские перчатки"
	item_path = /obj/item/clothing/gloves/fingerless/biker_gloves

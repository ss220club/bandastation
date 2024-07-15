/// Accessory Items (Moves overrided items to backpack)
/datum/loadout_category/tier4
	category_name = "Tier 4"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/tier4
	tab_order = /datum/loadout_category/head::tab_order + 3

/datum/loadout_item/tier4
	abstract_type = /datum/loadout_item/tier4
	/// Can we adjust this accessory to be above or below suits?
	VAR_FINAL/can_be_layer_adjusted = FALSE

/datum/loadout_item/tier4/New()
	. = ..()
	if(ispath(item_path, /obj/item/clothing/accessory))
		can_be_layer_adjusted = TRUE

/datum/loadout_item/tier4/get_ui_buttons()
	if(!can_be_layer_adjusted)
		return ..()

	var/list/buttons = ..()

	UNTYPED_LIST_ADD(buttons, list(
		"label" = "Layer",
		"act_key" = "set_layer",
		"active_key" = INFO_LAYER,
		"active_text" = "Above Suit",
		"inactive_text" = "Below Suit",
	))

	return buttons

/datum/loadout_item/tier4/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	if(action == "set_layer")
		return set_accessory_layer(manager, user)

	return ..()

/datum/loadout_item/tier4/proc/set_accessory_layer(datum/preference_middleware/loadout/manager, mob/user)
	if(!can_be_layer_adjusted)
		return FALSE

	var/list/loadout = manager.preferences.read_preference(/datum/preference/loadout)
	if(!loadout?[item_path])
		return FALSE

	if(isnull(loadout[item_path][INFO_LAYER]))
		loadout[item_path][INFO_LAYER] = FALSE

	loadout[item_path][INFO_LAYER] = !loadout[item_path][INFO_LAYER]
	manager.preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], loadout)
	return TRUE // Update UI

/datum/loadout_item/tier4/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.accessory)
		LAZYADD(outfit.backpack_contents, outfit.accessory)
	outfit.accessory = item_path

/datum/loadout_item/tier4/on_equip_item(
	obj/item/clothing/accessory/equipped_item,
	datum/preferences/preference_source,
	list/preference_list,
	mob/living/carbon/human/equipper,
	visuals_only = FALSE,
)
	. = ..()
	if(istype(equipped_item))
		equipped_item.above_suit = !!preference_list[item_path]?[INFO_LAYER]
		. |= (ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING)

/datum/loadout_item/tier4/katarina_jacket
	name = "Куртка Катарины"
	item_path = /obj/item/clothing/suit/katarina_jacket

/datum/loadout_item/tier4/katarina_suit
	name = "Костюм Катарины"
	item_path = /obj/item/clothing/under/costume/katarina_suit

/datum/loadout_item/tier4/katarina_cyberjacket
	name = "Кибер-куртка Катарины"
	item_path = /obj/item/clothing/suit/katarina_cyberjacket

/datum/loadout_item/tier4/katarina_cybersuit
	name = "Кибер-костюм Катарины"
	item_path = /obj/item/clothing/under/costume/katarina_cybersuit
/*
/datum/loadout_item/tier4/id_decal_rainbow
	name = "Радужная наклейка на карту"
	item_path = /obj/item/id_skin/rainbow

/datum/loadout_item/tier4/id_decal_space
	name = "КОСМИЧЕСКАЯ наклейка на карту"
	item_path = /obj/item/id_skin/space

/datum/loadout_item/tier4/id_decal_snake
	name = "Бегущая наклейка на карту"
	item_path = /obj/item/id_skin/colored/snake

/datum/loadout_item/tier4/id_decal_magic
	name = "Магическая наклейка на карту"
	item_path = /obj/item/id_skin/magic

/datum/loadout_item/tier4/id_decal_terminal
	name = "Наклейка на карту в виде терминала"
	item_path = /obj/item/id_skin/terminal

/datum/loadout_item/tier4/id_decal_boykisser
	name = "BoyKisser наклейка на карту"
	item_path = /obj/item/id_skin/boykisser
*/

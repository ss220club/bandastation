/// Accessory Items (Moves overrided items to backpack)
/datum/loadout_category/tier3
	category_name = "Tier 3"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/tier3
	tab_order = /datum/loadout_category/head::tab_order + 3

/datum/loadout_item/tier3
	abstract_type = /datum/loadout_item/tier3
	/// Can we adjust this accessory to be above or below suits?
	VAR_FINAL/can_be_layer_adjusted = FALSE

/datum/loadout_item/tier3/New()
	. = ..()
	if(ispath(item_path, /obj/item/clothing/accessory))
		can_be_layer_adjusted = TRUE

/datum/loadout_item/tier3/get_ui_buttons()
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

/datum/loadout_item/tier3/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	if(action == "set_layer")
		return set_accessory_layer(manager, user)

	return ..()

/datum/loadout_item/tier3/proc/set_accessory_layer(datum/preference_middleware/loadout/manager, mob/user)
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

/datum/loadout_item/tier3/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.accessory)
		LAZYADD(outfit.backpack_contents, outfit.accessory)
	outfit.accessory = item_path

/datum/loadout_item/tier3/on_equip_item(
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

/datum/loadout_item/tier3/v_jacket
	name = "Куртка V"
	item_path = /obj/item/clothing/suit/v_jacket

/datum/loadout_item/tier3/takemura_jacket
	name = "Куртка Такэмуры"
	item_path = /obj/item/clothing/suit/takemura_jacket

/datum/loadout_item/tier3/v_jacket
	name = "Куртка Вай"
	item_path = /obj/item/clothing/suit/hooded/vi_arcane
/*
/datum/loadout_item/tier3/id_decal_silver_colored
	name = "Серебрянная наклейка на карту (Голографическая)"
	item_path = /obj/item/id_skin/colored/silver

/datum/loadout_item/tier3/id_decal_silver
	name = "Серебрянная наклейка на карту"
	item_path = /obj/item/id_skin/silver

/datum/loadout_item/tier3/id_decal_gold_skin
	name = "Золотая наклейка на карту"
	item_path = /obj/item/id_skin/gold

/datum/loadout_item/tier3/id_decal_lifetime
	name = "Стильная наклейка на карту"
	item_path = /obj/item/id_skin/lifetime

/datum/loadout_item/tier3/id_decal_clown
	name = "Клоунская наклейка на карту"
	item_path = /obj/item/id_skin/clown

/datum/loadout_item/tier3/id_decal_neon
	name = "Неоновая наклейка на карту"
	item_path = /obj/item/id_skin/neon

/datum/loadout_item/tier3/id_decal_neon_colored
	name = "Неоновая наклейка на карту (Голографическая)"
	item_path = /obj/item/id_skin/colored/neon

/datum/loadout_item/tier3/id_decal_missing
	name = "Чёрно-розовая наклейка на карту"
	item_path = /obj/item/id_skin/missing

/datum/loadout_item/tier3/id_decal_paradise
	name = "Paradise наклейка на карту"
	item_path = /obj/item/id_skin/paradise

/datum/loadout_item/tier3/id_decal_ouija
	name = "Уиджи наклейка на карту"
	item_path = /obj/item/id_skin/ouija

/datum/loadout_item/tier3/id_decal_kitty
	name = "Кото-клейка на карту"
	item_path = /obj/item/id_skin/kitty

/datum/loadout_item/tier3/id_decal_kitty_colored
	name = "Кото-клейка на карту (Голографическая)"
	item_path = /obj/item/id_skin/colored/kitty

/datum/loadout_item/tier3/id_decal_anime
	name = "Анимешная наклейка на карту"
	item_path = /obj/item/id_skin/cursedmiku

/datum/loadout_item/tier3/id_decal_jokerge
	name = "Джокерге наклейка на карту"
	item_path = /obj/item/id_skin/jokerge
*/

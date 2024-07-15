/// Accessory Items (Moves overrided items to backpack)
/datum/loadout_category/tier0
	category_name = "Tier 0"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/tier0
	tab_order = /datum/loadout_category/head::tab_order + 3

/datum/loadout_item/tier0
	abstract_type = /datum/loadout_item/tier0
	/// Can we adjust this accessory to be above or below suits?
	VAR_FINAL/can_be_layer_adjusted = FALSE

/datum/loadout_item/tier0/New()
	. = ..()
	if(ispath(item_path, /obj/item/clothing/accessory))
		can_be_layer_adjusted = TRUE

/datum/loadout_item/tier0/get_ui_buttons()
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

/datum/loadout_item/tier0/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	if(action == "set_layer")
		return set_accessory_layer(manager, user)

	return ..()

/datum/loadout_item/tier0/proc/set_accessory_layer(datum/preference_middleware/loadout/manager, mob/user)
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

/datum/loadout_item/tier0/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.accessory)
		LAZYADD(outfit.backpack_contents, outfit.accessory)
	outfit.accessory = item_path

/datum/loadout_item/tier0/on_equip_item(
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

/datum/loadout_item/tier0/shark_shoes
	name = "Акульи тапочки"
	item_path = /obj/item/clothing/shoes/shark

/datum/loadout_item/tier0/shark_light_shoes
	name = "Акульи тапочки (светло-голубые)"
	item_path = /obj/item/clothing/shoes/shark/light

/datum/loadout_item/tier0/shark_suit
	name = "Костюм акулы"
	item_path = /obj/item/clothing/suit/hooded/shark_costume

/datum/loadout_item/tier0/shark_light_suit
	name = "Костюм акулы (светло-голубой)"
	item_path = /obj/item/clothing/suit/hooded/shark_costume/light

/datum/loadout_item/tier0/wallet
	name = "Бумажник"
	item_path = /obj/item/storage/wallet
/*
/datum/loadout_item/tier0/Wallet_NT
	name = "Бумажник NT"
	item_path = /obj/item/storage/wallet/wallet_NT

/datum/loadout_item/tier0/Wallet_USSP
	name = "Бумажник СССП"
	item_path = /obj/item/storage/wallet/wallet_USSP_2

/datum/loadout_item/tier0/Wallet_WYCI
	name = "Бумажник W.Y.C.I."
	item_path = /obj/item/storage/wallet/wallet_wyci
*/
/datum/loadout_item/tier0/firefirstaid
	name = "Набор первой медицинской"
	item_path = /obj/item/storage/medkit/regular

/datum/loadout_item/tier0/airtank
	name = "Спаренный балон от премиальной страховки"
	item_path = /obj/item/tank/internals/emergency_oxygen/double

/datum/loadout_item/tier0/toolbelt
	name = "Дедушкин пояс с инструментами"
	item_path = /obj/item/storage/belt/utility/full

/datum/loadout_item/tier0/bruise_pack
	name = "Медицинские бинты"
	item_path = /obj/item/stack/medical/bruise_pack

/datum/loadout_item/tier0/ointment
	name = "Мазь от ожогов"
	item_path = /obj/item/stack/medical/ointment

/datum/loadout_item/tier0/healthanalyzer
	name = "Медицинский анализатор"
	item_path = /obj/item/healthanalyzer

/datum/loadout_item/tier0/breathscarf
	name = "Шарф с системой дыхания"
	item_path = /obj/item/clothing/mask/breath/breathscarf

/datum/loadout_item/tier0/soundhand_black_jacket
	name = "Черная куртка с тэгом группы Саундхэнд"
	item_path = /obj/item/clothing/suit/storage/soundhand_black_jacket/tag

/datum/loadout_item/tier0/soundhand_olive_jacket
	name = "Оливковая куртка с тэгом группы Саундхэнд"
	item_path = /obj/item/clothing/suit/storage/soundhand_olive_jacket/tag

/datum/loadout_item/tier0/soundhand_brown_jacket
	name = "Коричневая куртка с тэгом группы Саундхэнд"
	item_path = /obj/item/clothing/suit/storage/soundhand_brown_jacket/tag

/datum/loadout_item/tier0/soundhand_bass_guitar
	name = "Бас гитара"
	item_path = /obj/item/instrument/soundhand_bass_guitar

/datum/loadout_item/tier0/soundhand_rock_guitar
	name = "Рок гитара"
	item_path = /obj/item/instrument/soundhand_rock_guitar
/*
// ID Skins
/datum/loadout_item/tier0/id_decal_colored
	name = "Наклейка на карту (Голографическая)"
	item_path = /obj/item/id_skin/colored

/datum/loadout_item/tier0/id_decal_donut
	name = "Пончиковая наклейка на карту"
	item_path = /obj/item/id_skin/donut

/datum/loadout_item/tier0/id_decal_business
	name = "Бизнесменская наклейка на карту"
	item_path = /obj/item/id_skin/business

/datum/loadout_item/tier0/id_decal_ussp
	name = "Коммунистическая наклейка на карту"
	item_path = /obj/item/id_skin/ussp
*/
/datum/loadout_item/tier0/breathscarf
	name = "Шарф с системой дыхания"
	item_path = /obj/item/clothing/mask/breath/breathscarf

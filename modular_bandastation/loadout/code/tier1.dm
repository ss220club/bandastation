/// Accessory Items (Moves overrided items to backpack)
/datum/loadout_category/tier1
	category_name = "Tier 1"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/tier1
	tab_order = /datum/loadout_category/head::tab_order + 3

/datum/loadout_item/tier1
	abstract_type = /datum/loadout_item/tier1
	/// Can we adjust this accessory to be above or below suits?
	VAR_FINAL/can_be_layer_adjusted = FALSE

/datum/loadout_item/tier1/New()
	. = ..()
	if(ispath(item_path, /obj/item/clothing/accessory))
		can_be_layer_adjusted = TRUE

/datum/loadout_item/tier1/get_ui_buttons()
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

/datum/loadout_item/tier1/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	if(action == "set_layer")
		return set_accessory_layer(manager, user)

	return ..()

/datum/loadout_item/tier1/proc/set_accessory_layer(datum/preference_middleware/loadout/manager, mob/user)
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

/datum/loadout_item/tier1/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.accessory)
		LAZYADD(outfit.backpack_contents, outfit.accessory)
	outfit.accessory = item_path

/datum/loadout_item/tier1/on_equip_item(
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

/datum/loadout_item/tier1/neon_shoes
	name = "Неоновые кросовки"
	item_path = /obj/item/clothing/shoes/black/neon

/datum/loadout_item/tier1/biker_gloves
	name = "Байкерские перчатки"
	item_path = /obj/item/clothing/gloves/fingerless/biker_gloves

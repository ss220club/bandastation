/datum/loadout_category/wallets
	category_name = "Бумажники"
	category_ui_icon = FA_ICON_WALLET
	type_to_generate = /datum/loadout_item/wallets
	tab_order = /datum/loadout_category/head::tab_order + 1

/datum/loadout_item/wallets
	abstract_type = /datum/loadout_item/wallets

/datum/loadout_item/glasses/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	LAZYADD(outfit.backpack_contents, item_path)


///Т0
/datum/loadout_item/wallets/wallet
	name = "Бумажник"
	item_path = /obj/item/storage/wallet
/*
///Т0
/datum/loadout_item/wallets/Wallet_NT
	name = "Бумажник NT"
	item_path = /obj/item/storage/wallet/wallet_NT

///Т0
/datum/loadout_item/wallets/Wallet_USSP
	name = "Бумажник СССП"
	item_path = /obj/item/storage/wallet/wallet_USSP_2

///Т0
/datum/loadout_item/wallets/Wallet_WYCI
	name = "Бумажник W.Y.C.I."
	item_path = /obj/item/storage/wallet/wallet_wyci
*/

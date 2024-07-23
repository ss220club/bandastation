/obj/item/storage/wallet/wallet_NT
	name = "leather wallet NT"
	desc = "Ваш кошелек настолько шикарен, что с ним вы выглядите просто потрясающе."
	icon = 'modular_bandastation/objects/icons/wallets.dmi'
	icon_state = "wallet_NT"
	worn_icon = 'modular_bandastation/objects/icons/onbody/id.dmi'
	worn_icon_state = "wallet_NT"
	overlay_icon_state = "wallet_NT_overlay"

/obj/item/storage/wallet/wallet_NT/update_label()
	if(front_id)
		name = "[src::name] displaying [front_id]"
		return
	name = src::name

/obj/item/storage/wallet/wallet_USSP_1
	name = "leather USSP wallet"
	desc = "Говорят, такие кошельки в СССП носят исключительно для зажигалок."
	icon = 'modular_bandastation/objects/icons/wallets.dmi'
	icon_state = "wallet_USSP_1"
	worn_icon = 'modular_bandastation/objects/icons/onbody/id.dmi'
	worn_icon_state = "wallet_USSP_1"
	overlay_icon_state = "wallet_USSP_1_overlay"

/obj/item/storage/wallet/wallet_USSP_1/update_label()
	if(front_id)
		name = "[src::name] displaying [front_id]"
		return
	name = src::name

/obj/item/storage/wallet/wallet_USSP_2
	name = "leather USSP wallet"
	desc = "Говорят, такие кошельки в СССП носят исключительно для зажигалок."
	icon = 'modular_bandastation/objects/icons/wallets.dmi'
	icon_state = "wallet_USSP_2"
	worn_icon = 'modular_bandastation/objects/icons/onbody/id.dmi'
	worn_icon_state = "wallet_USSP_2"
	overlay_icon_state = "wallet_USSP_2_overlay"

/obj/item/storage/wallet/wallet_USSP_2/update_label()
	if(front_id)
		name = "[src::name] displaying [front_id]"
		return
	name = src::name

/obj/item/storage/wallet/wallet_wyci
	name = "W.Y.C.I. wallet"
	desc = "Кошелек, законодателя моды WYCI,\
	украшен золотой пуговицей cшит позолочеными и платиновыми нитями, сверх прочный.\
	И сверх модный. И сверх дорогой. И сшит по принципу WYCI."
	icon = 'modular_bandastation/objects/icons/wallets.dmi'
	icon_state = "wallet_wyci"
	worn_icon = 'modular_bandastation/objects/icons/onbody/id.dmi'
	worn_icon_state = "wallet_wyci"
	overlay_icon_state = "wallet_wyci_overlay"

/obj/item/storage/wallet/wallet_wyci/update_label()
	if(front_id)
		name = "[src::name] displaying [front_id]"
		return
	name = src::name

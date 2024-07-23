/obj/item/clothing/suit/mantle/armor/captain/black
	name = "чёрная капитанская мантия"
	desc = "Носится верховным лидером станции NSS Cyberiad."
	icon = 'modular_bandastation/clothing/icons/object/cloaks.dmi'
	worn_icon = 'modular_bandastation/clothing/icons/mob/cloaks.dmi'
	icon_state = "capcloak_black"
	worn_icon_state = "capcloak_black"

/obj/item/clothing/suit/mantle/armor/captain/black/Initialize(mapload)
	. = ..()
	desc = "Носится верховным лидером станции [station_name()]."

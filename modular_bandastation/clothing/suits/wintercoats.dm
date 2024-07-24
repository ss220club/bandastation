// Roboticist's winter coat
/obj/item/clothing/suit/hooded/wintercoat/science/roboticist_reborn
	name = "roboticist's winter coat"
	desc = "Пальто, исключительно для разбирающихся в моде. Для крутых и подкрученных перцев. На бирке указано: 'Flameholdeir Industries'. Поможет даже во время самых длинных, холодных и тёмных времен."
	icon_state = "coatrobotics_reborn"
	icon = 'modular_bandastation/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_bandastation/icons/mob/clothing/suits/wintercoat.dmi'
	hoodtype = null
	inhand_icon_state = null

/obj/item/clothing/suit/hooded/wintercoat/science/roboticist_reborn/click_alt(mob/user)
	return NONE // Restrict user to zip and unzip coat

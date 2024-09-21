/obj/item/clothing/mask/richard
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/richard
	name = "Маска Петуха"
	desc = "Прямо из Горячей линии космо-Майами, Со встроенными фразами."
	icon = 'modular_bandastation/richard_mask/icons/obj/clothing/mask/richard_mask.dmi'
	worn_icon = 'modular_bandastation/richard_mask/icons/mob/clothing/mask/richard_mask.dmi'
	icon_state = "richard"
	inhand_icon_state = null
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/richard/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, end_string = list(". Тебе нравится причинять боль людям?",". Вы вернулись, да?",". Что, бля, за неуважение?", ". Кто я?"), end_string_chance = 5, slots = ITEM_SLOT_MASK)

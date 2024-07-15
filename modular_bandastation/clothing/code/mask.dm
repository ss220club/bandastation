/obj/item/clothing/mask/fakemoustache
	name = "фальшивые усы"
	desc = "Внимание: усы - ложь."
	icon_state = "fake-moustache"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE
	species_exception = list(/datum/species/golem)

/obj/item/clothing/mask/fakemoustache/italian
	name = "итальянскиие усики"
	desc = "Сделаны из настоящих волос коренных Итальянцев - выходцев с Земли. Заставляет носителя активно жестикулировать во время разговора."

/obj/item/clothing/mask/fakemoustache/italian/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("italian_replacement_ru.json", "italian"), end_string = list(" Равиоли, равиоли, подскажи мне формуоли!"," Мамма-мия!"," Мамма-мия! Какая острая фрикаделька!", " Ла ла ла ла ла фуникули+ фуникуля+!", " Вордс Реплаке!", " О с+оле-м+ио, бел+иссимо!"), end_string_chance = 3, slots = ITEM_SLOT_MASK)

/datum/outfit/job/chef
	mask = /obj/item/clothing/mask/fakemoustache/italian

/obj/item/clothing/mask/breath/red_gas
	name = "ПРС-1"
	desc = "Стильная дыхательная маска в виде противогаза, не скрывает лицо."
	icon = 'modular_bandastation/clothing/icons/object/masks.dmi'
	worn_icon = 'modular_bandastation/clothing/icons/mob/masks.dmi'
	icon_state = "red_gas"

/obj/item/clothing/mask/breath/breathscarf
	name = "шарф с системой дыхания"
	desc = "Стильный и инновационный шарф, который служит дыхательной маской в экстремальных ситуациях."
	icon = 'modular_bandastation/clothing/icons/object/masks.dmi'
	worn_icon = 'modular_bandastation/clothing/icons/mob/masks.dmi'
	icon_state = "breathscarf"

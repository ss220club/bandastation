/obj/item/clothing/head/hats/centcom_cap
	name = "\improper фуражка офицера флота Нанотрейзен"
	desc = "Носится высшими чинами офицерского состава Нанотрейзен. На подкладке едва различимы чьи-то инициалы."
	icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/mob/clothing/head/hats.dmi'
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | FREEZE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/head/hats/centhat
	name = "\improper головной убор офицера флота Нанотрейзен"
	desc = "Управлять судьбами так захватывающе."
	icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/mob/clothing/head/hats.dmi'

/obj/item/clothing/head/beret/cent_intern
	name = "\improper берет унтер-офицера флота Нанотрейзен"
	desc = "Носится младшим офицерским составом."
	icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#323253#acacac"
	armor_type = /datum/armor/cent_intern
	dog_fashion = null
	flags_1 = NONE

/datum/armor/cent_intern
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50
	wound = 10

/obj/item/clothing/head/beret/cent_diplomat
	name = "\improper берет дипломата Нанотрейзен"
	desc = "Изящный белый берет, важный элемент гардероба дипломатов Компании. На подкладке вышита надпись: \"НЕ ПОДЛЕЖИТ СТИРКЕ!\""
	icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#eeeeee#FFCE5B"
	armor_type = /datum/armor/cent_intern
	dog_fashion = null
	flags_1 = NONE

/datum/armor/cent_diplomat
	melee = 50
	bullet = 40
	laser = 40
	energy = 60
	bomb = 40
	fire = 60
	acid = 60
	wound = 12

/obj/item/clothing/head/helmet/space/beret
	name = "\improper берет старшего офицера флота Нанотрейзен"
	desc = "Стандартный берет офицера флота Нанотрейзен. Лёгкий и надежный."
	greyscale_colors = "#323253#FFCE5B"
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | FREEZE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/head/helmet/space/beret/soo
	name = "\improper берет офицера Специальных Операций"
	desc = "Продвинутая версия стандартного офицерского берета. Выдерживает попадание аннигиляторной пушки. Проверять не стоит."
	greyscale_colors = "#b72b2f#acacac"

/obj/item/clothing/head/hats/intern
	name = "\improper кепка унтер-офицера флота Нанотрейзен"
	desc = "Богомерзкое порождение коитуса кепки и вязанной шапки. Как правило, все носители данного недарозумения или\
	получают наивысшие должности в Компании в будущем из-за своей беспринципности, или жесточайшим образом умирают в первую неделю службы."
	icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/mob/clothing/head/hats.dmi'

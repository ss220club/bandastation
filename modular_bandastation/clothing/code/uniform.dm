// MARK: For loadout
/obj/item/clothing/under/costume
	icon = 'modular_bandastation/clothing/icons/obj/uniform.dmi'
	worn_icon = 'modular_bandastation/clothing/icons/mob/uniform.dmi'
	lefthand_file = 'modular_bandastation/clothing/icons/inhands/uniform_lefthand.dmi'
	righthand_file = 'modular_bandastation/clothing/icons/inhands/uniform_righthand.dmi'
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/katarina_cybersuit
	name = "кибер-костюм Катарины"
	desc = "Кибер-костюм так называемой Катарины."
	icon_state = "katarina_cybersuit"
	inhand_icon_state = "katarina_cybersuit"

/obj/item/clothing/under/costume/katarina_suit
	name = "костюм Катарины"
	desc = "Костюм так называемой Катарины."
	icon_state = "katarina_suit"
	inhand_icon_state = "katarina_suit"

/obj/item/clothing/under/costume/ei_combat
	name = "тактическая водолазка Gold on Black"
	desc = "Все то же удобство, но в прекрасной гамме угольных оттенков."
	icon_state = "ei_combat"
	inhand_icon_state = "ei_combat"

/obj/item/clothing/under/costume/ei_skirt
	name = "блузка с юбкой Gold on Black"
	desc = "Не волнуйтесь, запачкать её будет крайне сложно, так что вы всегда будете прелестны и очаровательны. Даже если руки по локоть в крови."
	icon_state = "ei_skirt"
	inhand_icon_state = "ei_skirt"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/gladiator_loadout
	name = "костюм гладиатора"
	desc = "Разве вас это не развлекает? Разве не для этого вы здесь?"
	icon_state = "gladiator"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/griffin_loadout
	name = "костюм гриффона"
	desc = "Почему не «голова орла»? Кто знает."
	icon_state = "griffin"
	inhand_icon_state = null

/obj/item/clothing/under/costume/owl_loadout
	name = "костюм совы"
	desc = "Мягкий коричневый комбинезон из синтетических перьев с сильным убеждением."
	icon_state = "owl"
	inhand_icon_state = null

/obj/item/clothing/under/costume/maid_loadout
	name = "костюм горничной"
	desc = "Стандартная униформа горничной."
	icon_state = "meido"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/pirate_loadout
	name = "костюм пирата"
	desc = "Аррррр!"
	icon_state = "pirate"
	inhand_icon_state = null

/obj/item/clothing/under/costume/roman_loadout
	name = "римский костюм"
	desc = "Древнеримские доспехи. Изготовлен из металлических и кожаных ремешков."
	icon_state = "roman"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/soviet_loadout
	name = "советская униформа"
	desc = "За Родину!"
	icon_state = "soviet"
	inhand_icon_state = null

/obj/item/clothing/under/costume/black_tango
	name = "платье для танго"
	desc = "Наполнено латинским огнем."
	icon_state = "black_tango"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/cardiganskirt_loadout
	name = "юбка-кардиган"
	desc = "Красивая юбка с милым кардиганом, очень модно!"
	icon_state = "blackskirt"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/sundress
	name = "летнее платье"
	desc = "Вызывает желание порезвиться в поле ромашек."
	icon_state = "sundress"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/costume/kilt_loadout
	name = "килт"
	desc = "Не заглядывай снизу."
	icon_state = "kilt"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// MARK: Not for loadout
/obj/item/clothing/under/rank/civilian/chef/red
	name = "красная униформа шефа"
	desc = "Униформа повара с пуговицами на одну сторону."
	icon_state = "chef_red"
	inhand_icon_state = null
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/towel
	name = "полотенце"
	desc = "Полотенце, сотканное из синтетической ткани. Можно обмотать вокруг тела."
	icon_state = "towel_long"
	inhand_icon_state = "towel_long"
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/towel/long
	name = "махровое полотенце"
	desc = "Полотенце, сотканное из синтетической ткани, на взгляд шершавое. Можно обмотать вокруг тела."
	icon_state = "towel_long_alt"

/obj/item/clothing/under/towel/short
	name = "маленькое полотенце"
	desc = "Полотенце, сотканное из синтетической ткани, но маленькое. Можно обмотать вокруг тела."
	icon_state = "towel_short"

/obj/item/clothing/under/towel/shortalt
	name = "маленькое махровое полотенце"
	desc = "Полотенце, сотканное из синтетической ткани, на взгляд шершавое и маленькое. Можно обмотать вокруг тела."
	icon_state = "towel_short_alt"

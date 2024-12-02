/datum/loadout_category/uniform
	category_name = "Униформа"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/uniform
	tab_order = /datum/loadout_category/head::tab_order + 1

/datum/loadout_item/uniform
	abstract_type = /datum/loadout_item/uniform

/datum/loadout_item/uniform/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(equipper.dna?.species?.outfit_important_for_life)
		if(!visuals_only)
			LAZYADD(outfit.backpack_contents, item_path)
	else
		outfit.uniform = item_path

/datum/loadout_item/uniform/katarina_cybersuit
    name = "Кибер-костюм Катарины"
    item_path = /obj/item/clothing/under/costume/katarina_cybersuit
    donator_level = 4

/datum/loadout_item/uniform/katarina_suit
    name = "Костюм Катарины"
    item_path = /obj/item/clothing/under/costume/katarina_suit
    donator_level = 4

/datum/loadout_item/uniform/ei_combat
    name = "Тактическая водолазка Gold on Black"
    item_path = /obj/item/clothing/under/costume/ei_combat
    donator_level = 1

/datum/loadout_item/uniform/ei_skirt
    name = "Блузка с юбкой Gold on Black"
    item_path = /obj/item/clothing/under/costume/ei_skirt
    donator_level = 1

/datum/loadout_item/uniform/russian_officer_uniform
    name = "форма русского офицера"
    item_path = /obj/item/clothing/under/costume/russian_officer

/datum/loadout_item/uniform/buttondown_shirt_slacks
    name = "рубашка на пуговицах с брюками"
    item_path = /obj/item/clothing/under/costume/buttondown/slacks

/datum/loadout_item/uniform/buttondown_shirt_shorts
    name = "рубашка на пуговицах с шортами"
    item_path = /obj/item/clothing/under/costume/buttondown/shorts

/datum/loadout_item/uniform/buttondown_shirt_skirt
    name = "рубашка на пуговицах с юбкой"
    item_path = /obj/item/clothing/under/costume/buttondown/skirt

/datum/loadout_item/uniform/henchmen
	name = "Комбинезон приспешника"
	item_path = /obj/item/clothing/under/costume/henchmen

/datum/loadout_item/uniform/pj_red
	name = "Красная пижама"
	item_path = /obj/item/clothing/under/misc/pj/red

/datum/loadout_item/uniform/pj_blue
	name = "Синяя пижама"
	item_path = /obj/item/clothing/under/misc/pj/blue

/datum/loadout_item/uniform/patriotsuit
	name = "Патриотический костюм"
	item_path = /obj/item/clothing/under/misc/patriotsuit

/datum/loadout_item/uniform/mailman
	name = "Комбинезон почтальона"
	item_path = /obj/item/clothing/under/misc/mailman

/datum/loadout_item/uniform/psyche
	name = "Психоделический комбинезон"
	item_path = /obj/item/clothing/under/misc/psyche

/datum/loadout_item/uniform/burial
	name = "Погребальные одежды"
	item_path = /obj/item/clothing/under/misc/burial

/datum/loadout_item/uniform/overalls
	name = "Рабочий комбинезон"
	item_path = /obj/item/clothing/under/misc/overalls

/datum/loadout_item/uniform/assistantformal
	name = "Формальная униформа ассистента"
	item_path = /obj/item/clothing/under/misc/assistantformal

/datum/loadout_item/uniform/bouncer
	name = "Форма вышибалы"
	item_path = /obj/item/clothing/under/misc/bouncer

/datum/loadout_item/uniform/syndicate_souvenir
	name = "Сувенирная футболка Синдиката"
	item_path = /obj/item/clothing/under/misc/syndicate_souvenir

/datum/loadout_item/uniform/slacks
	name = "Широкие брюки"
	item_path = /obj/item/clothing/under/pants/slacks

/datum/loadout_item/uniform/jeans
	name = "Джинсы"
	item_path = /obj/item/clothing/under/pants/jeans

/datum/loadout_item/uniform/track_pants
	name = "Спортивные штаны"
	item_path = /obj/item/clothing/under/pants/track

/datum/loadout_item/uniform/camo_pants
	name = "Камуфляжные штаны"
	item_path = /obj/item/clothing/under/pants/camo

/datum/loadout_item/uniform/greensuit
    name = "Зелёный костюм"
    item_path = /obj/item/clothing/under/suit/green

/datum/loadout_item/uniform/redsuit
    name = "Красный костюм"
    item_path = /obj/item/clothing/under/suit/red

/datum/loadout_item/uniform/charcoalsuit
    name = "Угольный костюм"
    item_path = /obj/item/clothing/under/suit/charcoal

/datum/loadout_item/uniform/navysuit
    name = "Тёмно-синий костюм"
    item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/uniform/burgundysuit
    name = "Бургундский костюм"
    item_path = /obj/item/clothing/under/suit/burgundy

/datum/loadout_item/uniform/checkeredsuit
    name = "Клетчатый костюм"
    item_path = /obj/item/clothing/under/suit/checkered

/datum/loadout_item/uniform/beigesuit
    name = "Бежевый костюм"
    item_path = /obj/item/clothing/under/suit/beige

/datum/loadout_item/uniform/blacksuit
    name = "Чёрный двубортный костюм"
    item_path = /obj/item/clothing/under/suit/black

/datum/loadout_item/uniform/blacksuitskirt
    name = "Чёрный костюм с юбкой"
    item_path = /obj/item/clothing/under/suit/black/skirt

/datum/loadout_item/uniform/whitesuit
    name = "Белый костюм"
    item_path = /obj/item/clothing/under/suit/white

/datum/loadout_item/uniform/whitesuitskirt
    name = "Белая юбка-костюм"
    item_path = /obj/item/clothing/under/suit/white/skirt

/datum/loadout_item/uniform/tansuit
    name = "Жёлтый костюм"
    item_path = /obj/item/clothing/under/suit/tan

/datum/loadout_item/uniform/waitersoutfit
    name = "Официантский наряд"
    item_path = /obj/item/clothing/under/suit/waiter

/datum/loadout_item/uniform/tuxedo
    name = "Смокинг"
    item_path = /obj/item/clothing/under/suit/tuxedo

/datum/loadout_item/uniform/weddingdress
    name = "Свадебное платье"
    item_path = /obj/item/clothing/under/dress/wedding_dress

/datum/loadout_item/uniform/eveninggown
    name = "Вечернее платье"
    item_path = /obj/item/clothing/under/dress/eveninggown

/datum/loadout_item/uniform/gladiator
    name = "Костюм гладиатора"
    item_path = /obj/item/clothing/under/costume/gladiator_loadout

/datum/loadout_item/uniform/griffin
    name = "Костюм гриффона"
    item_path = /obj/item/clothing/under/costume/griffin_loadout

/datum/loadout_item/uniform/owl
    name = "Костюм совы"
    item_path = /obj/item/clothing/under/costume/owl_loadout

/datum/loadout_item/uniform/maid
    name = "Костюм горничной"
    item_path = /obj/item/clothing/under/costume/maid_loadout

/datum/loadout_item/uniform/pirate
    name = "Костюм пирата"
    item_path = /obj/item/clothing/under/costume/pirate_loadout

/datum/loadout_item/uniform/roman
    name = "Римский костюм"
    item_path = /obj/item/clothing/under/costume/roman_loadout

/datum/loadout_item/uniform/soviet
    name = "Советская униформа"
    item_path = /obj/item/clothing/under/costume/soviet_loadout

/datum/loadout_item/uniform/black_tango
    name = "Платье для танго"
    item_path = /obj/item/clothing/under/costume/black_tango

/datum/loadout_item/uniform/cardiganskirt
    name = "Юбка-кардиган"
    item_path = /obj/item/clothing/under/costume/cardiganskirt_loadout

/datum/loadout_item/uniform/sundress
    name = "Летнее платье"
    item_path = /obj/item/clothing/under/costume/sundress

/datum/loadout_item/uniform/kilt
    name = "Килт"
    item_path = /obj/item/clothing/under/costume/kilt_loadout

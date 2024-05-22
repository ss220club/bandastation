/datum/uplink_category/badassery
	name = "(Бесполезно) Крутость"
	weight = 0

/datum/uplink_item/badass
	category = /datum/uplink_category/badassery
	surplus = 0

/datum/uplink_item/badass/balloon
	name = "Syndicate Balloon"
	desc = "Покажи всем, что ты БОСС: бесползеный красный шарик с логотипом Синдиката. \
			Может лопнуть в самых глубоких местах." // Надеюсь правильно понял значение данной фразы.
	item = /obj/item/toy/balloon/syndicate
	cost = 20
	lock_other_purchases = TRUE
	cant_discount = TRUE
	illegal_tech = FALSE

/datum/uplink_item/badass/balloon/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	. = ..()

	if(!.)
		return

	notify_ghosts(
		"[user.name] купил ПИЗДАТЫЙ шарик Синдиката!",
		source = .,
		header = "О чём он ДУМАЕТ?!",
	)

/datum/uplink_item/badass/syndiecards
	name = "Syndicate Playing Cards"
	desc = "Специальная колода игральных карт космического уровня с мономолекулярным краем и металлическим укреплением, \
			что делает их слегка крепче, чем обычная колода карт. \
			Кроме того вы можете играть в карточные игры или оставить их на теле вашей жертвы."
	item = /obj/item/toy/cards/deck/syndicate
	cost = 1
	surplus = 40
	illegal_tech = FALSE

/datum/uplink_item/badass/syndiecigs
	name = "Syndicate Smokes"
	desc = "Насыщенный вкус, густой дым, пропитаны омнизином."
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate
	cost = 2
	illegal_tech = FALSE

/datum/uplink_item/badass/syndiecash
	name = "Syndicate Briefcase Full of Cash"
	desc = "Надёжный дипломат содержащий 5000 кредит. Полезен для подкупа персонала, покупки вещей \
			и оплаты услуг по привлекательной цене. Дипломат ощущается немного тяжелым в руках; он был \
			изготовлен так, чтобы при необходимости можно было нанести более ощутимый удар, если ваш клиент нуждается в убеждении."
	item = /obj/item/storage/briefcase/secure/syndie
	cost = 3
	restricted = TRUE
	illegal_tech = FALSE

/datum/uplink_item/badass/costumes/clown
	name = "Clown Costume"
	desc = "Нет ничего страшнее клоуна с автоматическим оружием."
	item = /obj/item/storage/backpack/duffelbag/clown/syndie
	purchasable_from = ALL
	progression_minimum = 70 MINUTES

/datum/uplink_item/badass/costumes/tactical_naptime
	name = "Sleepy Time Pajama Bundle"
	desc = "Даже солдатам нужно хорошо высыпаться. В комплект входит: кроваво-красная пижама, одеялко, кружка горячего какао и пушистый друг."
	item = /obj/item/storage/box/syndie_kit/sleepytime
	purchasable_from = ALL
	progression_minimum = 90 MINUTES
	cost = 4
	limited_stock = 1
	cant_discount = TRUE

/datum/uplink_item/badass/costumes/obvious_chameleon
	name = "Broken Chameleon Kit"
	desc = "Набор предметов, которые содержат технологию хамелеона, позволяющую вам замаскироваться практически под всё, что есть на станции и многое другое! \
			Пожалуйста, обратите внимание на то, что этот комплект НЕ прошёл контроль качества."
	purchasable_from = ALL
	progression_minimum = 90 MINUTES
	item = /obj/item/storage/box/syndie_kit/chameleon/broken

/datum/uplink_item/badass/costumes/centcom_official
	name = "CentCom Official Costume"
	desc = "Попросите экипаж \"осмотреть\" их ядерный диск и систему вооружения, а когда они откажутся, вытащите автоматическую винтовку и расстреляйте капитана. \
			Рация не включает в себя ключи шифрования. Оружие не входит в комплект."
	purchasable_from = ALL
	progression_minimum = 110 MINUTES
	item = /obj/item/storage/box/syndie_kit/centcom_costume

/datum/uplink_item/badass/stickers
	name = "Syndicate Sticker Pack"
	desc = "Содержит 8-мь случайных стикеров точно спроектированных, чтобы напоминать подозрительные объекты, которые могут быть полезными (или нет) для обмана экипажа."
	item = /obj/item/storage/box/syndie_kit/stickers
	cost = 1

/datum/uplink_item/badass/demotivational_posters
	name = "Syndicate Demotivational Poster Pack"
	desc = "Содержит подборку демотивирующих плакатов, чтобы снизить продуктивность и повысить уровень апатии на рабочем месте."
	item = /obj/item/storage/box/syndie_kit/poster_box
	cost = 1

/datum/uplink_item/badass/syndie_spraycan
	name = "Syndicate Spraycan"
	desc = "Стильный балончик краски Синдиката. \
		Содержит достаточно специального средства, чтобы распылить один огромный символ мятежа, подвергая персонал станции скользким мучениям."
	item = /obj/item/traitor_spraycan
	cost = 1

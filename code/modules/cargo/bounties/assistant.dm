/datum/bounty/item/assistant/strange_object
	name = "Странный объект"
	description = "Нанотрейзен интересуется странными объектами. Найдите один в технических туннелях и отправьте сразу же на ЦК."
	reward = CARGO_CRATE_VALUE * 2.4
	wanted_types = list(/obj/item/relic = TRUE)

/datum/bounty/item/assistant/scooter
	name = "Scooter"
	description = "Нанотрейзен установило, что ходьба расточительна. Отправьте скутер на ЦК для ускорения операций."
	reward = CARGO_CRATE_VALUE * 2.16 // the mat hoffman
	wanted_types = list(/obj/vehicle/ridden/scooter = TRUE)
	include_subtypes = FALSE

/datum/bounty/item/assistant/skateboard
	name = "Skateboard"
	description = "Нанотрейзен установило, что ходьба расточительна. Отправьте скейтборд на ЦК для ускорения операций."
	reward = CARGO_CRATE_VALUE * 1.8 // the tony hawk
	wanted_types = list(
		/obj/vehicle/ridden/scooter/skateboard = TRUE,
		/obj/item/melee/skateboard = TRUE,
	)

/datum/bounty/item/assistant/stunprod
	name = "Оглущающая палка"
	description = "ЦК требуется оглушающая палка против диссидентов. Создайте одну, затем отправьте."
	reward = CARGO_CRATE_VALUE * 2.6
	wanted_types = list(/obj/item/melee/baton/security/cattleprod = TRUE)

/datum/bounty/item/assistant/soap
	name = "Мыло"
	description = "Мыло пропало из всех ванных на ЦК, и никто не знает кто его взял. Замените его и станьте героем, что нужен ЦК."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 3
	wanted_types = list(/obj/item/soap = TRUE)

/datum/bounty/item/assistant/spear
	name = "Копья"
	description = "Силы безопасности на ЦК проходят через сокращение бюджета. Вам заплатят, если вы отправите набор копей."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/spear = TRUE)

/datum/bounty/item/assistant/toolbox
	name = "Тулбоксы"
	description = "На ЦК отсутствует робаст. Поторопитесь и отправьте несколько тулбоксов для решения проблемы."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 6
	wanted_types = list(/obj/item/storage/toolbox = TRUE)

/datum/bounty/item/assistant/statue
	name = "Статуя"
	description = "Центральное Командование хотело бы вычурную статую для лобби. Отправьте одну, когда это будет возможно."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/structure/statue = TRUE)

/datum/bounty/item/assistant/clown_box
	name = "Коробка клоуна"
	description = "Вселенная нуждается в смехе. Поставьте штамп на картонке при помощи печати клоуна и отправьте."
	reward = CARGO_CRATE_VALUE * 3
	wanted_types = list(/obj/item/storage/box/clown = TRUE)

/datum/bounty/item/assistant/cheesiehonkers
	name = "Сырные хонкеры"
	description = "Видимо, компания, что производит сырные хонкеры скоро разорится. ЦК хочет запастись ими, пока это не случилось!"
	reward = CARGO_CRATE_VALUE * 2.4
	required_count = 3
	wanted_types = list(/obj/item/food/cheesiehonkers = TRUE)

/datum/bounty/item/assistant/baseball_bat
	name = "Бейсбольная бита"
	description = "Бейсбольная лихорадка происходит на ЦК! Будьте добры отправить нам несколько бейсбольных бит, чтобы начальство смогло осуществить их детскую мечту."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/melee/baseball_bat = TRUE)

/datum/bounty/item/assistant/extendohand
	name = "Extendo-Hand"
	description = "Коммандор Бетси уже стара и теперь не может дотянуться до пульта телевизора. Командование запросило перчатку на пружине для помощи ей."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/extendohand = TRUE)

/datum/bounty/item/assistant/donut
	name = "Пончики"
	description = "Служба безопасности на ЦК терпит сильные потери от синдиката. Отправьте пончики, чтобы поднять мораль."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 6
	wanted_types = list(/obj/item/food/donut = TRUE)

/datum/bounty/item/assistant/donkpocket
	name = "Донк-покеты"
	description = "Памятка безопасности потребителя: Внимание. Донк-покеты, созданные в прошлом году, содержат опасную биоматерию ящеров. Верните вещество на ЦК немедленно."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 10
	wanted_types = list(/obj/item/food/donkpocket = TRUE)

/datum/bounty/item/assistant/monkey_hide
	name = "Шкура обезьяны"
	description = "Один из учёных на ЦК заинтересован в тестировании продуктов на шкуре обезьян. Ваша задача состоит в том, чтобы получить шкуру и отправить её."
	reward = CARGO_CRATE_VALUE * 3
	wanted_types = list(/obj/item/stack/sheet/animalhide/monkey = TRUE)

/datum/bounty/item/assistant/dead_mice
	name = "Мёртвые мыши"
	description = "На станции 14 закончились сухо-замороженные мыши. Отправьте свежих, иначе их уборщик устроит забастовку."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 5
	wanted_types = list(/obj/item/food/deadmouse = TRUE)

/datum/bounty/item/assistant/comfy_chair
	name = "Удобные стулья"
	description = "Коммандор Пат недоволен своим стулом. Он утверждает, что стул приносит боль его спине. Отправьте несколько альтернатив для его спины."
	reward = CARGO_CRATE_VALUE * 3
	required_count = 5
	wanted_types = list(/obj/structure/chair/comfy = TRUE)

/datum/bounty/item/assistant/geranium
	name = "Герании"
	description = "Коммандор Зот страстно влюблён в Коммандора Зену. Отправьте поставкой герании - её любимые цветы, и он с радостью вас вознаградит."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/food/grown/poppy/geranium = TRUE)
	include_subtypes = FALSE

/datum/bounty/item/assistant/poppy
	name = "Маки"
	description = "Коммандор Зот очень хочет свести с ума офицера безопасности Оливию. Отправьте поставку маков - её любимых цветов, и он вас с радостью вознаградит."
	reward = CARGO_CRATE_VALUE * 2
	required_count = 3
	wanted_types = list(/obj/item/food/grown/poppy = TRUE)
	include_subtypes = FALSE

/datum/bounty/item/assistant/potted_plants
	name = "Комнатные растения"
	description = "Центральное Командование хочет укомплектовать новую станцию класса BirdBoat. Вам был дан заказ на снабжение станции комнатными растениями."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 8
	wanted_types = list(/obj/item/kirbyplants = TRUE)

/datum/bounty/item/assistant/monkey_cubes
	name = "Кубы обезьян"
	description = "В связи с недавним инцидентом в генетике, Центральное Командование остро нуждается в обезьянах. Ваша задача отправить кубы обезьян."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 3
	wanted_types = list(/obj/item/food/monkeycube = TRUE)

/datum/bounty/item/assistant/ied
	name = "СВУ"
	description = "В тюрьме строго режима Нанотрейзен, находящейся на ЦК, проходит обучение персонала. Отправьте несколько СВУ для обучения."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 3
	wanted_types = list(/obj/item/grenade/iedcasing = TRUE)

/datum/bounty/item/assistant/corgimeat
	name = "Сырое мясо корги"
	description = "Синдикат недавно украл всё мясо корги с ЦК. Отправьте замену немедленно."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/food/meat/slab/corgi = TRUE)

/datum/bounty/item/assistant/action_figures
	name = "Фигурки"
	description = "Сын вице-президента, увидев рекламу фигурок по телевизору, стал выпрашивать их. Отправьте несколько чтобы угомонить его."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 5
	wanted_types = list(/obj/item/toy/figure = TRUE)

/datum/bounty/item/assistant/paper_bin
	name = "Корзины для бумаг"
	description = "У нашего бухгалтерского отдела кончилась бумага. Нам нужна поставка бумаги немедленно."
	reward = CARGO_CRATE_VALUE * 5
	required_count = 5
	wanted_types = list(/obj/item/paper_bin = TRUE)

/datum/bounty/item/assistant/crayons
	name = "Мелки"
	description = "Дети доктора Джонса снова съели все наши мелки. Пожалуйста, отправьте нам свои."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 24
	wanted_types = list(/obj/item/toy/crayon = TRUE)

/datum/bounty/item/assistant/pens
	name = "Ручки"
	description = "Мы проводим интергалактическе соревнования по балансировке ручек. Нам нужно, чтобы вы доставили несколько стандартизированных, чёрных, шариковых ручек."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 10
	include_subtypes = FALSE
	wanted_types = list(/obj/item/pen = TRUE)

/datum/bounty/item/assistant/water_tank
	name = "Бак с водой"
	description = "Нам нужно больше воды для нашей гидропоники. Найдите бак с водой и отправьте его нам."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/structure/reagent_dispensers/watertank = TRUE)

/datum/bounty/item/assistant/pneumatic_cannon
	name = "Пневматическая пушка"
	description = "Мы выясняем, как сильно мы можем запускать осколки суперматтерии из пневматической пушки. Отправьте нам одну как можно скорее."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/pneumatic_cannon/ghetto = TRUE)

/datum/bounty/item/assistant/improvised_shells
	name = "Самодельные патроны для дробовика"
	description = "Сокращение бюджета бьёт очень сильно по службе безопасности. Отправьте несколько самодельных патрон для дробовика как сможете."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 5
	wanted_types = list(/obj/item/ammo_casing/junk = TRUE)

/datum/bounty/item/assistant/flamethrower
	name = "Огнемёт"
	description = "У нас происходит нашествие молей, отправьте нам огнемёт для помощи в урегулировании ситуации."
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/item/flamethrower = TRUE)

/datum/bounty/item/assistant/fish
	name = "Рыба"
	description = "Нам нужна рыба для заполнения наших аквариумов. Мёртвые или купленные из отдела поставок рыбы будут оплачены лишь наполовину."
	reward = CARGO_CRATE_VALUE * 9
	required_count = 4
	wanted_types = list(/obj/item/fish = TRUE, /obj/item/storage/fish_case = TRUE)
	///the penalty for shipping dead/bought fish, which can subtract up to half the reward in total.
	var/shipping_penalty

/datum/bounty/item/assistant/fish/New()
	..()
	shipping_penalty = reward * 0.5 / required_count

/datum/bounty/item/assistant/fish/applies_to(obj/shipped)
	. = ..()
	if(!.)
		return
	var/obj/item/fish/fishie = shipped
	if(istype(shipped, /obj/item/storage/fish_case))
		fishie = locate() in shipped
		if(!fishie || !is_type_in_typecache(fishie, wanted_types))
			return FALSE
	return can_ship_fish(fishie)

/datum/bounty/item/assistant/fish/proc/can_ship_fish(obj/item/fish/fishie)
	return TRUE

/datum/bounty/item/assistant/fish/ship(obj/shipped)
	. = ..()
	if(!.)
		return
	var/obj/item/fish/fishie = shipped
	if(istype(shipped, /obj/item/storage/fish_case))
		fishie = locate() in shipped
	if(fishie.status == FISH_DEAD || HAS_TRAIT(fishie, TRAIT_FISH_FROM_CASE))
		reward -= shipping_penalty

///A subtype of the fish bounty that requires fish with a specific fluid type
/datum/bounty/item/assistant/fish/fluid
	reward = CARGO_CRATE_VALUE * 11
	///The required fluid type of the fish for it to be shipped
	var/fluid_type

/datum/bounty/item/assistant/fish/fluid/New()
	..()
	fluid_type = pick(AQUARIUM_FLUID_FRESHWATER, AQUARIUM_FLUID_SALTWATER, AQUARIUM_FLUID_SULPHWATEVER)
	name = "[fluid_type] Рыба"
	description = "Нам нужна [LOWER_TEXT(fluid_type)] рыба для заселения наших аквариумов. Мёртвые или купленные в отделе снабжения рыбы будут оплачены лишь наполовину."

/datum/bounty/item/assistant/fish/fluid/can_ship_fish(obj/item/fish/fishie)
	return compatible_fluid_type(fishie.required_fluid_type, fluid_type)

///A subtype of the fish bounty that requires specific fish types. The higher their rarity, the better the pay.
/datum/bounty/item/assistant/fish/specific
	description = "В нашей престижной рыбной коллекции на данный момент не хватает нескольких специфичных видов. Мёртвые или купленные в отделе поставок рыбы будут оплачены лишь наполовину."
	reward = CARGO_CRATE_VALUE * 16
	required_count = 3
	wanted_types = list(/obj/item/storage/fish_case = TRUE)

/datum/bounty/item/assistant/fish/specific/New()
	var/static/list/choosable_fishes
	if(isnull(choosable_fishes))
		choosable_fishes = list()
		for(var/obj/item/fish/prototype as anything in subtypesof(/obj/item/fish))
			if(initial(prototype.experisci_scannable) && initial(prototype.show_in_catalog))
				choosable_fishes += prototype

	var/list/fishes_copylist = choosable_fishes.Copy()
	///Used to calculate the extra reward
	var/total_rarity = 0
	var/list/name_list = list()
	var/num_paths = rand(2,3)
	for(var/i in 1 to num_paths)
		var/obj/item/fish/chosen_path = pick_n_take(fishes_copylist)
		wanted_types[chosen_path] = TRUE
		name_list += initial(chosen_path.name)
		total_rarity += initial(chosen_path.random_case_rarity) / num_paths
	name = english_list(name_list)

	switch(total_rarity)
		if(FISH_RARITY_NOPE to FISH_RARITY_GOOD_LUCK_FINDING_THIS)
			reward += CARGO_CRATE_VALUE * 14
		if(FISH_RARITY_GOOD_LUCK_FINDING_THIS to FISH_RARITY_VERY_RARE)
			reward += CARGO_CRATE_VALUE * 6.5
		if(FISH_RARITY_VERY_RARE to FISH_RARITY_RARE)
			reward += CARGO_CRATE_VALUE * 3
		if(FISH_RARITY_RARE to FISH_RARITY_BASIC-1)
			reward += CARGO_CRATE_VALUE * 1

	..()

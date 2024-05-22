//All bundles and telecrystals
/datum/uplink_category/dangerous
	name = "Заметное оружие"
	weight = 9

/datum/uplink_item/dangerous
	category = /datum/uplink_category/dangerous

/datum/uplink_item/dangerous/foampistol
	name = "Toy Pistol with Riot Darts"
	desc = "Неприметный игрушечный пистолет спроектированный для стрельбы поролоновыми дротиками. Заряжен дротиками \
			подавления беспорядков эффективно парализует цель."
	item = /obj/item/gun/ballistic/automatic/pistol/toy/riot
	cost = 2
	surplus = 10
	purchasable_from = ~UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/pistol
	name = "Makarov Pistol"
	desc = "Небольшой, легко скрываемый пистолет, использующий патроны 9мм в 8-ми зарядном магазине и совместим  \
			с глушителями."
	item = /obj/item/gun/ballistic/automatic/pistol
	cost = 7
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/throwingweapons
	name = "Box of Throwing Weapons"
	desc = "Коробка с сюрикенами и усиленными и усиленными боласами из древних боевых искусств Земли. Они являются высокоэффективным \
			метательным оружием. Боласы могут сбить цель с ног, а сюрикены застрять в конечностях."
	item = /obj/item/storage/box/syndie_kit/throwing_weapons
	cost = 3
	illegal_tech = FALSE

/datum/uplink_item/dangerous/sword
	name = "Energy Sword"
	desc = "Энергетический меч представляет собой холодное оружие с клинком из чистой энергии. Меч довольно мал, чтобы \
			поместиться в кармане когда выключен. При активации издаёт громкий, характерный звук."
	progression_minimum = 20 MINUTES
	item = /obj/item/melee/energy/sword/saber
	cost = 8
	purchasable_from = ~UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/powerfist
	name = "Power Fist"
	desc = "Силовой кулак представляет собой металлическую перчатку с встроенным поршневым механизмом работающим за счет внешнего газового баллона.\
			При попадании по цели поршень выдвигается вперед нанося значительные повреждения. \
			Использование гаечного ключа на клапане поршня позволяет регулировать количество используемого газа на один удар, чтобы \
			наносить дополнительный урон и поражать цели дальше. Используйте отвёртку для извлечения прикрепленных баллонов."
	progression_minimum = 20 MINUTES
	item = /obj/item/melee/powerfist
	cost = 6
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/rapid
	name = "Gloves of the North Star"
	desc = "Эти перчатки позволяют их пользователю очень быстро избивать людей. Не повышают скорость атаки при помощи оружия или мясистые кулаки халка."
	progression_minimum = 20 MINUTES
	item = /obj/item/clothing/gloves/rapid
	cost = 8

/datum/uplink_item/dangerous/doublesword
	name = "Double-Bladed Energy Sword"
	desc = "Двухклинковый энергетический меч наносит немного больше урона, чем обычный энергетический меч и отражает \
			энергетические снаряды блокируя их, но требует двух свободных рук. Его также можно использовать в ближнем бою, что убережет вас от захвата."
	progression_minimum = 30 MINUTES
	item = /obj/item/dualsaber

	cost = 13
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) //nukies get their own version

/datum/uplink_item/dangerous/doublesword/get_discount_value(discount_type)
	switch(discount_type)
		if(TRAITOR_DISCOUNT_BIG)
			return 0.5
		if(TRAITOR_DISCOUNT_AVERAGE)
			return 0.35
		else
			return 0.2

/datum/uplink_item/dangerous/guardian
	name = "Holoparasites"
	desc = "Способны почти колдовать с помощью световых голограмм и наномашин, они требуют \
			органического хозяина в качестве базы и источника топлива. Голопаразиты бывают нескольких видов и разделяют урон со своим хозяином."
	progression_minimum = 30 MINUTES
	item = /obj/item/guardian_creator/tech
	cost = 18
	surplus = 0
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/dangerous/revolver
	name = "Syndicate Revolver"
	desc = "Waffle Co.'s модернезировала револьвер Синдиката. Стреляет 7-ю мощными патронами от .357 Магнума."
	item = /obj/item/gun/ballistic/revolver/syndicate
	cost = 13
	surplus = 50
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) //nukies get their own version

/datum/uplink_item/dangerous/cat
	name = "Feral cat grenade"
	desc = "Эта граната заполнена 5-ю дикими кошками находящимся в стазисе. После активации дикие кошки просыпаются и освобождаются на несчастных прохожих. ВНИМАНИЕ: Кошки не обучены отличать друзей от врагов!"
	cost = 5
	item = /obj/item/grenade/spawnergrenade/cat
	surplus = 30

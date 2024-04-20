/datum/bounty/item/mining/goliath_steaks
	name = "Lava-Cooked Goliath Steaks"
	description = "Адмирал Павлова начала голодать после того, как в кафетерии стали подавать только обезьян и их побочные продукты. Она требует мясо голиафа, приготовленное на лаве."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/food/meat/steak/goliath = TRUE)

/datum/bounty/item/mining/goliath_boat
	name = "Goliath Hide Boat"
	description = "Коммандор Менков хочет поучавствовать в ежегодной Лавалендской регате. Он просит ваши корабли для самой быстрой лодки известной человеку."
	reward = CARGO_CRATE_VALUE * 20
	wanted_types = list(/obj/vehicle/ridden/lavaboat = TRUE)

/datum/bounty/item/mining/bone_oar
	name = "Bone Oars"
	description = "Коммандор Менков хочет поучавствовать в ежегодной Лавалендской регате. Отправьте одну пару."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 2
	wanted_types = list(/obj/item/oar = TRUE)

/datum/bounty/item/mining/bone_axe
	name = "Костяной топор"
	description = "Клоуны-марадёры украли все пожарные топоры со станции 12. Отправьте им костяной топор в качестве замены."
	reward = CARGO_CRATE_VALUE * 15
	wanted_types = list(/obj/item/fireaxe/boneaxe = TRUE)

/datum/bounty/item/mining/bone_armor
	name = "Костяная броня"
	description = "Станция 14 в добровольном порядке призвала свой экипаж ящериц для для тестирования баллистической брони. Отправьте один комплект костяной брони."
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(/obj/item/clothing/suit/armor/bone = TRUE)

/datum/bounty/item/mining/skull_helmet
	name = "Костяной шлем"
	description = "Глава службы безопасности на станции 42 отметила свой день рождения вчера! Мы хотим подарить ей модный костяной шлем."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/clothing/head/helmet/skull = TRUE)

/datum/bounty/item/mining/bone_talisman
	name = "Костяные талисманы"
	description = "Директор исследований на станции 14 утверждает, что языческий костяной защищает его владельца. Отправьте им несколько для начала тестов."
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/clothing/accessory/talisman = TRUE)

/datum/bounty/item/mining/watcher_wreath
	name = "Watcher Wreaths"
	description = "Station 14's Research Director thinks they're onto a break-through on the cultural icons of some pagan beliefs. Ship them a few watcher wreaths for analysis."
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/clothing/neck/wreath = FALSE)

/datum/bounty/item/mining/icewing_wreath
	name = "Icewing Wreath"
	description = "We're getting some....weird messages from Station 14's Research Director. And most of what they said was incoherent. But they apparently want an icewing wreath. Could you send them one?"
	reward = CARGO_CRATE_VALUE * 30
	required_count = 1
	wanted_types = list(/obj/item/clothing/neck/wreath/icewing = FALSE)

/datum/bounty/item/mining/bone_dagger
	name = "Костяные клинки"
	description = "В кафетерии Центрального Командования проходит сокращение бюджета. Отправьте несколько костяных клинков, чтобы наш повар продолжил работать."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/knife/combat/bone = TRUE)

/datum/bounty/item/mining/polypore_mushroom
	name = "Миска грибов"
	description = "Лейтенант Джеб уронил свою любимую миску грибов. Подбодрите его, отправив новую, хорошо?"
	reward = CARGO_CRATE_VALUE * 15 //5x mushroom shavings
	wanted_types = list(/obj/item/reagent_containers/cup/bowl/mushroom_bowl = TRUE)

/datum/bounty/item/mining/inocybe_mushroom
	name = "Шляпки грибов"
	description = "Наш ботаник утверждает, что он может перегнать вкусный ликёр из абсолютно любого растения. Давайте посмотрим, что будет делать с шляпами грибов из семьи Иноцибе."
	reward = CARGO_CRATE_VALUE * 9
	required_count = 3
	wanted_types = list(/obj/item/food/grown/ash_flora/mushroom_cap = TRUE)

/datum/bounty/item/mining/porcini_mushroom
	name = "Грибные листья"
	description = "Листья гриба Порчини по слухам имеют целебные свойства. Наши исследователи хотят заполучить их для эксперимента."
	reward = CARGO_CRATE_VALUE * 9
	required_count = 3
	wanted_types = list(/obj/item/food/grown/ash_flora/mushroom_leaf = TRUE)

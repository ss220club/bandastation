/datum/bounty/item/medical/heart
	name = "Сердце"
	description = "Коммандор Джонсон в критическом состоянии после ещё одного пережитого сердечного приступа. Доктора говорят, что им нужно новое сердце как можно быстрее. Отправьте одно, быстро! Мы возьмём и кибернитическое, если оно понадобится, но только если оно будет улучшенное."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/organ/internal/heart = TRUE,
		/obj/item/organ/internal/heart/cybernetic = FALSE,
		/obj/item/organ/internal/heart/cybernetic/tier2 = TRUE,
		/obj/item/organ/internal/heart/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/lung
	name = "Лёгкие"
	description = "Недавний взрыв на Центральном Командовании оставил многих сотрудников с пробитыми лёгкими. Запасные лёгкие должны быть выданы. Мы возьмём кибернитические, если они понадобятся, но только если они будут улучшенные."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/lungs = TRUE,
		/obj/item/organ/internal/lungs/cybernetic = FALSE,
		/obj/item/organ/internal/lungs/cybernetic/tier2 = TRUE,
		/obj/item/organ/internal/lungs/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/appendix
	name = "Аппендикс"
	description = "Повар Центрального Командования Гибб хочет приготовить блюдо, используя, особый деликатес: аппендикс. Если вы отправите один, он вам заплатит."
	reward = CARGO_CRATE_VALUE * 5 //there are no synthetic appendixes
	wanted_types = list(/obj/item/organ/internal/appendix = TRUE)

/datum/bounty/item/medical/ears
	name = "Уши"
	description = "Множество сотрудников станции 12 остались глухими в следствие неавторизованной клоунады. Отправьте им новые уши. Мы возьмём и кибернетические, если они нам понадобятся, но только если они буду улучшенные."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/ears = TRUE,
		/obj/item/organ/internal/ears/cybernetic = FALSE,
		/obj/item/organ/internal/ears/cybernetic/upgraded = TRUE,
		/obj/item/organ/internal/ears/cybernetic/whisper = TRUE,
		/obj/item/organ/internal/ears/cybernetic/xray = TRUE,
	)

/datum/bounty/item/medical/liver
	name = "Печень"
	description = "Множество высокопоставленных дипломатов ЦентКома были госпитализированы с отказом печени после встречи с тремя послами Советского Союза. Помогите нам, ладно? Мы возьмём и кибернетические, если они нам понадобятся, но только если они буду улучшенные."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/liver = TRUE,
		/obj/item/organ/internal/liver/cybernetic = FALSE,
		/obj/item/organ/internal/liver/cybernetic/tier2 = TRUE,
		/obj/item/organ/internal/liver/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/eye
	name = "Органические глаза"
	description = "Директор исследований Виллем на станции 5 запрашивает пару органических глаз. Не спрашивайте зачем, просто отправьте ему."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/eyes = TRUE,
		/obj/item/organ/internal/eyes/robotic = FALSE,
	)

/datum/bounty/item/medical/tongue
	name = "Языки"
	description = "Недавняя атака мимов экстремистов оставила экипаж станции 23 немыми. Отправьте несколько запасных языков."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/organ/internal/tongue = TRUE)

/datum/bounty/item/medical/lizard_tail
	name = "Хвост ящерицы"
	description = "Федерация магов похитила у Нанотрейзен хвосты ящериц. В то время как ЦентКом разбирается с магами, не может ли станция припасти один из их хвостов?"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/external/tail/lizard = TRUE)

/datum/bounty/item/medical/cat_tail
	name = "Хвост кошки"
	description = "На Центральном Командовании кончились мощные очистители для труб. Не могли бы вы отправить кошачий хвост помощи нам?"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/external/tail/cat = TRUE)

/datum/bounty/item/medical/chainsaw
	name = "Бензопила"
	description = "У СМО на ЦентКоме имеются проблемы с операциями на големах. Она просит одну бензопилу, пожалуйста."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/chainsaw = TRUE)

/datum/bounty/item/medical/tail_whip //Like the cat tail bounties, with more processing.
	name = "Nine Tails whip"
	description = "Коммандор Джексон ищет отличное дополнение для её коллекции экзотического оружия. Она вас наградит также за девятихвостого кота или девятихвостую ящерицу."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/melee/chainofcommand/tailwhip = TRUE)

/datum/bounty/item/medical/surgerycomp
	name = "Хирургический компьютер"
	description = "После очередного взрывного инцидента на нашем ежегодном сырфесте на ЦентКоме, у нас лежит оргромная куча раненного экипажа. Пожалуйста отправьте нам свежий хирургический компьютер, если это конечно возможно."
	reward = CARGO_CRATE_VALUE * 12
	wanted_types = list(/obj/machinery/computer/operating = TRUE)

/datum/bounty/item/medical/surgerytable
	name = "Хирургический стол"
	description = "После недавнего притока инфицированного экипажа, мы видим, что маски не справляются в одиночку. Серебрянные операционный столы, к слову, могут сработать, отправьте нам один для использования."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/structure/table/optable = TRUE)

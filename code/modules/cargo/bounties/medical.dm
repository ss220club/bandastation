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
	name = "Organic Eyes"
	description = "Station 5's Research Director Willem is requesting a few pairs of non-robotic eyes. Don't ask questions, just ship them."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/eyes = TRUE,
		/obj/item/organ/internal/eyes/robotic = FALSE,
	)

/datum/bounty/item/medical/tongue
	name = "Tongues"
	description = "A recent attack by Mime extremists has left staff at Station 23 speechless. Ship some spare tongues."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/organ/internal/tongue = TRUE)

/datum/bounty/item/medical/lizard_tail
	name = "Lizard Tail"
	description = "The Wizard Federation has made off with Nanotrasen's supply of lizard tails. While CentCom is dealing with the wizards, can the station spare a tail of their own?"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/external/tail/lizard = TRUE)

/datum/bounty/item/medical/cat_tail
	name = "Cat Tail"
	description = "Central Command has run out of heavy duty pipe cleaners. Can you ship over a cat tail to help us out?"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/external/tail/cat = TRUE)

/datum/bounty/item/medical/chainsaw
	name = "Chainsaw"
	description = "A CMO at CentCom is having trouble operating on golems. She requests one chainsaw, please."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/chainsaw = TRUE)

/datum/bounty/item/medical/tail_whip //Like the cat tail bounties, with more processing.
	name = "Nine Tails whip"
	description = "Commander Jackson is looking for a fine addition to her exotic weapons collection. She will reward you handsomely for either a Cat or Liz o' Nine Tails."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/melee/chainofcommand/tailwhip = TRUE)

/datum/bounty/item/medical/surgerycomp
	name = "Surgery Computer"
	description = "After another freak bombing incident at our annual cheesefest at CentCom, we have a massive stack of injured crew on our end. Please send us a fresh surgery computer, if at all possible."
	reward = CARGO_CRATE_VALUE * 12
	wanted_types = list(/obj/machinery/computer/operating = TRUE)

/datum/bounty/item/medical/surgerytable
	name = "Operating Table"
	description = "After a recent influx of infected crew members, we've seen that masks just aren't cutting it alone. Silver operating tables might just do the trick though, send us one to use."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/structure/table/optable = TRUE)

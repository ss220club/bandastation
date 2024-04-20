// Sidepaths for knowledge between Flesh and Void.

/datum/heretic_knowledge/void_cloak
	name = "Void Cloak"
	desc = "Позволяет трансмутировать осколок стекла, простыню и любой предмет верхней одежды (например, броню или куртку), \
		чтобы создать Пустотный плащ. Пока капюшон опущен, плащ работает как фокусировка, \
		а когда капюшон поднят, плащ полностью невидим. Он также обеспечивает достойную броню \
		и имеет карманы, в которых можно хранить один из ваших клинков, различные ритуальные компоненты (например, органы) и небольшие еретические безделушки."
	gain_text = "Сова - хранительница вещей, которые на практике не совсем таковы, но в теории таковыми являются. Многие вещи таковыми являются."
	next_knowledge = list(
		/datum/heretic_knowledge/limited_amount/flesh_ghoul,
		/datum/heretic_knowledge/cold_snap,
	)
	required_atoms = list(
		/obj/item/shard = 1,
		/obj/item/clothing/suit = 1,
		/obj/item/bedsheet = 1,
	)
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/void)
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/spell/blood_siphon
	name = "Blood Siphon"
	desc = "Дает вам Blood Siphon, заклинание, которое истощает кровь и здоровье жертвы, передавая их вам. \
		Также имеет шанс передать раны от вас к жертве."
	gain_text = "\"Независимо от человека, кровь у нас течет одинаково.\" Так мне сказал Маршал."
	next_knowledge = list(
		/datum/heretic_knowledge/spell/void_phase,
		/datum/heretic_knowledge/summon/raw_prophet,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/blood_siphon
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/spell/cleave
	name = "Blood Cleave"
	desc = "Дает вам Cleave, заклинание с выбором цели с действием по области \
		которое вызывает сильное кровотечение и потерю крови у всех попавших."
	gain_text = "Сначала я не понимал этих инструментов войны, но Жрец \
		сказал мне использовать их независимо от этого. Скоро, сказал он, я буду знать их хорошо."
	next_knowledge = list(
		/datum/heretic_knowledge/summon/stalker,
		/datum/heretic_knowledge/spell/void_pull,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/cleave
	cost = 1
	route = PATH_SIDE

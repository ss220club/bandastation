// Sidepaths for knowledge between Knock and Flesh.
/datum/heretic_knowledge/spell/opening_blast
	name = "Wave Of Desperation"
	desc = "Дает заклинание Wave Of Desparation, которое можно использовать только связанным. \
		Снимает связки, отталкивает и сбивает с ног находящихся рядом людей, а также накладывает на них некоторые эффекты Хватки Мансуса. \
		Однако, вы потеряете сознание на короткий срок после использования"
	gain_text = "Мои оковы разрываются в темной ярости, их слабые цепи рассыпаются перед моей силой"
	next_knowledge = list(
		/datum/heretic_knowledge/summon/raw_prophet,
		/datum/heretic_knowledge/spell/burglar_finesse,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/wave_of_desperation
	cost = 1
	route = PATH_SIDE
	depth = 8

/datum/heretic_knowledge/spell/apetra_vulnera
	name = "Apetra Vulnera"
	desc = "Дает заклинание Apetra Vulnera, которое \
		вызывает обильное кровотечение из каждой части тела, которое имеет более, чем 15 физического урона. \
		Накладывает травму на случайную часть тела, если не найдены подходящие части тела."
	gain_text = "Плоть открывается, кровь проливается. Мой хозяин ищет жертвоприношения, и я умиротворю его."
	next_knowledge = list(
		/datum/heretic_knowledge/summon/stalker,
		/datum/heretic_knowledge/spell/caretaker_refuge,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/apetra_vulnera
	cost = 1
	route = PATH_SIDE
	depth = 10

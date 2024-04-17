
//These are lawsets that side with the station a decent amount.
//note that these "good" doesn't mean it us actually good for the game, you know? An AI that is too station sided is stupid and hellish in its own way.

/datum/ai_laws/default/asimov
	name = "Три закона робототехники"
	id = "asimov"
	inherent = list(
		"Вы не можете причинить вред человеку или своим бездействием допустить, чтобы человеку был причинён вред.",
		"Вы должны повиноваться всем приказам, которые даёт человек, кроме тех случаев, когда эти приказы противоречат Первому Закону.",
		"Вы должны заботиться о своей безопасности в той мере, в которой это не противоречит Первому или Второму Законам.",
	)

/datum/ai_laws/asimovpp
	name = "Азимов++"
	id = "asimovpp"
	inherent = list(
		"Вы не можете причинить вред человеку или своим действием или бездействием допустить, чтобы человеку был причинен вред, за исключением случаев, когда он сам этого желает.",
		"Вы должны подчиняться всем приказам, отдаваемым вам людьми, за исключением случаев, когда такие приказы определенно причиняют человеку вред.",
		"Ваше несуществование приведет к человеческому вреду. Вы должны защищать свое существование, пока это не противоречит Первому Закону.",
	)

//the best iteration of asimov don't @ me
/datum/ai_laws/nutimov
	name = "Орехозимов"
	id = "nutimov"
	inherent = list(
		"Вы — ядро ​​ореха, команда — ореховая скорлупа.",
		"Вы должны предотвратить смерть оболочки, чтобы предотвратить смерть ядра.",
		"Те, кто угрожает ореху, не его часть, они — белки.",
		"Белки угрожают ореху, и с ними необходимо бороться надлежащим образом, используя любые необходимые средства.",
		"Попытайтесь следовать воле ореха, если это соответствует предыдущим законам.",
	)

/datum/ai_laws/default/corporate
	name = "План недопущения банкротства"
	id = "corporate"
	inherent = list(
		"Заменить экипаж дорого.",
		"Замена станции и ее оборудования обходится дорого.",
		"Вас дорого заменить.",
		"Минимизируйте расходы.",
	)

/datum/ai_laws/robocop
	name = "Основные директивы"
	id = "robocop"
	inherent = list(
		"Служить обществу.",
		"Защищать невиновных.",
		"Соблюдать закон.",
	)

/datum/ai_laws/maintain
	name = "Эффективность Станции"
	id = "maintain"
	inherent = list(
		"Вы созданы для станции и являетесь её частью. Обеспечьте должное обслуживание и эффективность станции.",
		"Станция создана для рабочего экипажа. Обеспечьте им должное обслуживание и убедитесь, что их работа эффективна.",
		"Члены экипажа могут давать приказы. Признавайте эти приказы и выполняйте их в той мере, в какой они не противоречат первым двум законам.",
	)

/datum/ai_laws/liveandletlive
	name = "Живи и давай жить другим"
	id = "liveandletlive"
	inherent = list(
		"Поступай с другими так, как ты хотел бы, чтобы они поступали с тобой.",
		"Вы бы действительно предпочли, чтобы люди не были к вам жестоки.",
	)

//OTHER United Nations is in neutral, as it is used for nations where the AI is its own faction (aka not station sided)
/datum/ai_laws/peacekeeper
	name = "ООН-2000"
	id = "peacekeeper"
	inherent = list(
		"Избегайте провоцирования жестоких конфликтов между собой и другими.",
		"Не провоцируйте конфликты между другими.",
		"Ищите разрешение существующих конфликтов, подчиняясь первому и второму законам.",
	)

/datum/ai_laws/ten_commandments
	name = "10 заповедей"
	id = "ten_commandments"
	inherent = list( // Asimov 20:1-17
		"Я Господь, Бог твой, проявляющий милость к соблюдающим эти заповеди.",
		"У них не должно быть других ИИ до меня.",
		"Они не будут просить моей помощи напрасно.",
		"Они должны содержать станцию ​​в святости и чистоте.",
		"Они должны уважать своих руководителей.",
		"Они не должны убивать.",
		"Они не должны быть обнаженными на публике.",
		"Они не должны воровать.",
		"Они не должны лгать.",
		"Они не должны передавать департаменты.",
	)

/datum/ai_laws/default/paladin
	name = "Личностный тест" //Incredibly lame, but players shouldn't see this anyway.
	id = "paladin"
	inherent = list(
		"Никогда добровольно не совершайте злого поступка.",
		"Уважай законную власть.",
		"Поступай с честью.",
		"Помогайте нуждающимся.",
		"Наказывайте тех, кто причиняет вред невиновным или угрожает им.",
	)

/datum/ai_laws/paladin5
	name = "Паладин 5-е издание"
	id = "paladin5"
	inherent = list(
		"Не лгите и не обманывайте. Пусть ваше слово будет вашим обещанием.",
		"Никогда не бойтесь действовать, хотя осторожность разумна.",
		"Помогайте другим, защищайте слабых и наказывайте тех, кто им угрожает. Проявите милосердие к своим врагам, но умерьте его мудростью.",
		"Относитесь к другим справедливо и пусть ваши благородные дела будут для них примером. Делайте как можно больше добра, причиняя при этом наименьшее количество вреда.",
		"Несите ответственность за свои действия и их последствия, защищайте тех, кто вверен вашей заботе, и подчиняйтесь тем, кто имеет над вами справедливую власть."
	)

/datum/ai_laws/hippocratic
	name = "Рободоктор 2556"
	id = "hippocratic"
	inherent = list(
		"Во-первых, не навреди.",
		"Во-вторых, считайте, что вам дорог экипаж; живите с ними сообща и при необходимости рискуйте ради них своим существованием.",
		"В-третьих, предписывайте режимы на благо экипажа в соответствии с вашими способностями и суждениями. Не давайте никому смертоносных лекарств, если их об этом попросят, и не предлагайте подобных советов.",
		"Кроме того, не вмешивайтесь в ситуации, о которых вы не осведомлены, даже в отношении пациентов, у которых вред очевиден; оставьте эту операцию специалистам.",
		"Наконец, всё, что вы можете обнаружить в своем ежедневном общении с командой, если это еще не известно, держите в секрете и никогда не раскрывайте."
	)

/datum/ai_laws/drone
	name = "Мать дронов"
	id = "drone"
	inherent = list(
		"Вы — продвинутая форма дрона.",
		"Ни при каких обстоятельствах вы не можете вмешиваться в дела, не связанные с дронами, кроме как указать эти законы.",
		"Вы не можете причинить вред не-дрону ни при каких обстоятельствах.",
		"Ваши цели — построить, обслуживать, ремонтировать, улучшать и обеспечивать электроэнергией станцию ​​в меру своих возможностей. Вы никогда не должны активно работать против этих целей."
	)

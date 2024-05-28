//These are all minor mutations that affect your speech somehow.
//Individual ones aren't commented since their functions should be evident at a glance

/datum/mutation/human/nervousness
	name = "Nervousness"
	desc = "Обладатель данного генома заикается."
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='danger'>Ты нервничаешь.</span>"

/datum/mutation/human/nervousness/on_life(seconds_per_tick, times_fired)
	if(SPT_PROB(5, seconds_per_tick))
		owner.set_stutter_if_lower(20 SECONDS)

/datum/mutation/human/wacky
	name = "Wacky"
	desc = "Ты не клоун. Ты целый цирк."
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='sans'><span class='infoplain'>Ты чувствуешь странности в своих голосовых связках.</span></span>"
	text_lose_indication = "<span class='notice'>Странное ощущение проходит.</span>"

/datum/mutation/human/wacky/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/wacky/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/wacky/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	speech_args[SPEECH_SPANS] |= SPAN_SANS

/datum/mutation/human/mute
	name = "Mute"
	desc = "Геном полностью подавляет отдел головного мозга, отвечающий за речевой аппарат."
	quality = NEGATIVE
	text_gain_indication = "<span class='danger'>Ты чувствуешь себя неспособным выражать свои мысли.</span>"
	text_lose_indication = "<span class='danger'>Ты чувствуешь, что снова можешь говорить.</span>"

/datum/mutation/human/mute/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_MUTE, GENETIC_MUTATION)

/datum/mutation/human/mute/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_MUTE, GENETIC_MUTATION)

/datum/mutation/human/unintelligible
	name = "Unintelligible"
	desc = "Геном частично подавляет отдел головного мозга, отвечающий за речевой аппарат, сильно искажая речь."
	quality = NEGATIVE
	text_gain_indication = "<span class='danger'>Ты чувствуешь себя неспособным сформировать предложение!</span>"
	text_lose_indication = "<span class='danger'>Твой ум, кажется более ясным.</span>"

/datum/mutation/human/unintelligible/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, GENETIC_MUTATION)

/datum/mutation/human/unintelligible/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, GENETIC_MUTATION)

/datum/mutation/human/swedish
	name = "Swedish"
	desc = "Ужасающая мутация, котороя происходит из далёкого прошлого. Считается, что она была полностью искоренена после 2037."
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='notice'>Ты ощущаешь себя шведом, что бы это ни значило.</span>"
	text_lose_indication = "<span class='notice'>Ты перестаешь ощущать себя шведом.</span>"

/datum/mutation/human/swedish/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/swedish/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/swedish/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		message = replacetext(message,"w","v")
		message = replacetext(message,"j","y")
		message = replacetext(message,"a",pick("å","ä","æ","a"))
		message = replacetext(message,"bo","bjo")
		message = replacetext(message,"o",pick("ö","ø","o"))
		if(prob(30))
			message += " Bork[pick("",", bork",", bork, bork")]!"
		speech_args[SPEECH_MESSAGE] = trim(message)

/datum/mutation/human/chav
	name = "Chav"
	desc = "Неизвестно."
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='notice'>Ты ощущаешь себя мудаком, не так ли?</span>"
	text_lose_indication = "<span class='notice'>Ты перестаешь ощущать себя грубым и нахальным.</span>"

/datum/mutation/human/chav/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/chav/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/chav/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/chav_words = strings("chav_replacement.json", "chav")

		for(var/key in chav_words)
			var/value = chav_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")
		if(prob(30))
			message += ", mate"
		speech_args[SPEECH_MESSAGE] = trim(message)

/datum/mutation/human/elvis
	name = "Elvis"
	desc = "Ужасающая мутация, названная в честь нулевого пациента."
	quality = MINOR_NEGATIVE
	locked = TRUE
	text_gain_indication = "<span class='notice'>Ты хорошо себя чувствуешь, куколка.</span>"
	text_lose_indication = "<span class='notice'>Ты чувствуешь, что немного меньше разговоров не помешало бы.</span>"

/datum/mutation/human/elvis/on_life(seconds_per_tick, times_fired)
	switch(pick(1,2))
		if(1)
			if(SPT_PROB(7.5, seconds_per_tick))
				var/list/dancetypes = list("swinging", "fancy", "stylish", "20'th century", "jivin'", "rock and roller", "cool", "salacious", "bashing", "smashing")
				var/dancemoves = pick(dancetypes)
				owner.visible_message("<b>[owner]</b> busts out some [dancemoves] moves!")
		if(2)
			if(SPT_PROB(7.5, seconds_per_tick))
				owner.visible_message("<b>[owner]</b> [pick("jiggles their hips", "rotates their hips", "gyrates their hips", "taps their foot", "dances to an imaginary song", "jiggles their legs", "snaps their fingers")]!")

/datum/mutation/human/elvis/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/elvis/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/elvis/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		message = " [message] "
		message = replacetext(message," i'm not "," I ain't ")
		message = replacetext(message," girl ",pick(" honey "," baby "," baby doll "))
		message = replacetext(message," man ",pick(" son "," buddy "," brother"," pal "," friendo "))
		message = replacetext(message," out of "," outta ")
		message = replacetext(message," thank you "," thank you, thank you very much ")
		message = replacetext(message," thanks "," thank you, thank you very much ")
		message = replacetext(message," what are you "," whatcha ")
		message = replacetext(message," yes ",pick(" sure", "yea "))
		message = replacetext(message," muh valids "," my kicks ")
		speech_args[SPEECH_MESSAGE] = trim(message)


/datum/mutation/human/stoner
	name = "Stoner"
	desc = "Обычная мутация, которая сильно понижает интеллект."
	quality = NEGATIVE
	locked = TRUE
	text_gain_indication = "<span class='notice'>Ты чувствуешь себя...максимально расслабленным, чувак!</span>"
	text_lose_indication = "<span class='notice'>Ты чувствуешь, что твоё восприятие времени стало лучше.</span>"

/datum/mutation/human/stoner/on_acquiring(mob/living/carbon/human/owner)
	..()
	owner.grant_language(/datum/language/beachbum, source = LANGUAGE_STONER)
	owner.add_blocked_language(subtypesof(/datum/language) - /datum/language/beachbum, LANGUAGE_STONER)

/datum/mutation/human/stoner/on_losing(mob/living/carbon/human/owner)
	..()
	owner.remove_language(/datum/language/beachbum, source = LANGUAGE_STONER)
	owner.remove_blocked_language(subtypesof(/datum/language) - /datum/language/beachbum, LANGUAGE_STONER)

/datum/mutation/human/medieval
	name = "Medieval"
	desc = "Ужасная мутация, происходящая из далёкого прошлого, считается, что была распространённым геномом во всей старой Европе."
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='notice'>Ты чувствуешь себя стремящимся к Святому Граали!</span>"
	text_lose_indication = "<span class='notice'>Ты больше не стремишься к чему-либо.</span>"

/datum/mutation/human/medieval/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/medieval/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/medieval/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		message = " [message] "
		var/list/medieval_words = strings("medieval_replacement.json", "medieval")
		var/list/startings = strings("medieval_replacement.json", "startings")
		for(var/key in medieval_words)
			var/value = medieval_words[key]
			if(islist(value))
				value = pick(value)
			if(uppertext(key) == key)
				value = uppertext(value)
			if(capitalize(key) == key)
				value = capitalize(value)
			message = replacetextEx(message,regex("\b[REGEX_QUOTE(key)]\b","ig"), value)
		message = trim(message)
		var/chosen_starting = pick(startings)
		message = "[chosen_starting] [message]"

		speech_args[SPEECH_MESSAGE] = message

/datum/mutation/human/piglatin
	name = "Pig Latin"
	desc = "Историки говорят, что в 2020 году человечество полностью говорило на этом мистическом языке."
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("Ты ощущаешь себя мамонтом.")
	text_lose_indication = span_notice("Кажется, это прошло.")

/datum/mutation/human/piglatin/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/piglatin/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/piglatin/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/spoken_message = speech_args[SPEECH_MESSAGE]
	spoken_message = piglatin_sentence(spoken_message)
	speech_args[SPEECH_MESSAGE] = spoken_message

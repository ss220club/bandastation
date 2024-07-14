/obj/item/clothing/mask/equipped(mob/M, slot)
	. = ..()

	if((slot) && modifies_speech)
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/mask/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/mask/fakemoustache/chef
	name = "абсолютно настоящие усы шефа"
	desc = "Осторожно: усы накладные."
	modifies_speech = TRUE

/obj/item/clothing/mask/fakemoustache/chef/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		var/static/regex/words = new(@"(?<![a-zA-Zа-яёА-ЯЁ])[a-zA-Zа-яёА-ЯЁ]+?(?![a-zA-Zа-яёА-ЯЁ])", "g")
		message = replacetext(message, words, GLOBAL_PROC_REF(italian_words_replace))

		if(prob(5))
			message += pick(" Равиоли, равиоли, подскажи мне формуоли!"," Мамма-мия!"," Мамма-мия! Какая острая фрикаделька!", " Ла ла ла ла ла фуникули+ фуникуля+!", " Вордс Реплаке!")
	speech_args[SPEECH_MESSAGE] = trim(message)

/datum/outfit/job/chef
	mask = /obj/item/clothing/mask/fakemoustache/chef

/obj/item/clothing/mask/breath/red_gas
	name = "ПРС-1"
	desc = "Стильная дыхательная маска в виде противогаза, не скрывает лицо."
	icon = 'modular_bandastation/clothing/icons/object/masks.dmi'
	icon_state = "red_gas"

/obj/item/clothing/mask/breath/breathscarf
	name = "шарф с системой дыхания"
	desc = "Стильный и инновационный шарф, который служит дыхательной маской в экстремальных ситуациях."
	icon = 'modular_bandastation/clothing/icons/object/masks.dmi'
	icon_state = "breathscarf"

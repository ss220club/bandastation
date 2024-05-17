/datum/action/changeling/mimicvoice
	name = "Mimic Voice"
	desc = "Мы формируем наши голосовые железы так, чтобы они звучали желаемым голосом. Поддержание этой силы замедляет выработку химических веществ."
	button_icon_state = "mimic_voice"
	helptext = "Превратит ваш голос в имя, которое вы введете. Мы должны постоянно расходовать химические вещества, чтобы поддерживать такую форму."
	chemical_cost = 0//constant chemical drain hardcoded
	dna_cost = 1
	req_human = TRUE

// Fake Voice
/datum/action/changeling/mimicvoice/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(changeling.mimicing)
		changeling.mimicing = ""
		changeling.chem_recharge_slowdown -= 0.25
		to_chat(user, span_notice("Мы возвращаем наши голосовые железы в исходное положение."))
		return

	var/mimic_voice = sanitize_name(tgui_input_text(user, "Введите имя для подражания", "Имитация голоса", max_length = MAX_NAME_LEN))
	if(!mimic_voice)
		return
	..()
	changeling.mimicing = mimic_voice
	changeling.chem_recharge_slowdown += 0.25
	to_chat(user, span_notice("Мы формируем наши железы так, чтобы они издавали голос <b>[mimic_voice]</b>, Это замедлит регенерацию химических веществ во время активной деятельности."))
	to_chat(user, span_notice("Используйте эту силу снова, чтобы вернуть наш прежний голос и вернуть производство химикатов к нормальному уровню."))
	return TRUE

/datum/action/changeling/mimicvoice/Remove(mob/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(changeling?.mimicing)
		changeling.chem_recharge_slowdown = max(0, changeling.chem_recharge_slowdown - 0.25)
		changeling.mimicing = ""
		to_chat(user, span_notice("Наши голосовые железы возвращаются в исходное положение."))
	. = ..()

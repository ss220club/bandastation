/datum/action/innate/voice_change
	name = "Сменить TTS"
	desc = "Изменяет TTS с зависимостью от пола и с учетом уровня подписки."
	button_icon = 'icons/mob/actions/actions_ai.dmi'
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	button_icon_state = "voice_changer"
	var/overrides
	var/list/addition_effects = list()

/datum/action/innate/voice_change/Activate()
	owner.change_tts_seed(owner, overrides, addition_effects)

/datum/action/innate/voice_change/robotic
	addition_effects = list(TTS_SOUND_EFFECT_ROBOT)

/datum/action/innate/voice_change/genderless
	desc = "Изменяет TTS вне зависимости от пола и с учетом уровня подписки."
	overrides = TTS_OVERRIDE_GENDER

/datum/action/innate/voice_change/genderless/robotic
	addition_effects = list(TTS_SOUND_EFFECT_ROBOT)

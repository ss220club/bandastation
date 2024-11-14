/mob/eye/imaginary_friend/add_tts_component()
	AddComponent(/datum/component/tts_component)

/mob/eye/imaginary_friend/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	. = ..()
	speaker.cast_tts(src, raw_message, effect = radio_freq ? /datum/singleton/sound_effect/radio : null)

/mob/eye/imaginary_friend/setup_friend_from_prefs(datum/preferences/appearance_from_prefs)
	. = ..()
	AddComponent(/datum/component/tts_component, SStts220.tts_seeds[appearance_from_prefs.read_preference(/datum/preference/text/tts_seed)])

/mob/eye/imaginary_friend/Initialize(mapload)
	. = ..()
	GRANT_ACTION(/datum/action/innate/imaginary_voice_change)

/datum/action/innate/imaginary_voice_change
	name = "Сменить TTS"
	desc = "Изменяет ваш TTS вне зависимости от пола, но с учетом вашей подписки."
	button_icon = 'icons/mob/actions/actions_ai.dmi'
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	button_icon_state = "voice_changer"

/datum/action/innate/imaginary_voice_change/Activate()
	owner.change_tts_seed(src, TTS_OVERRIDE_GENDER)

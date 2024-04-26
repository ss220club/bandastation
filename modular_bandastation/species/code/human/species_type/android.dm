/datum/species/android/get_scream_sound(mob/living/carbon/human/human)
	return 'modular_bandastation/sounds/sound/voice/screams/silicon/scream_silicon.ogg'

/datum/species/android/get_laugh_sound(mob/living/carbon/human/human)
	return pick(
		'modular_bandastation/sounds/sound/voice/laugh/silicon/laugh_siliconE1M0.ogg',
		'modular_bandastation/sounds/sound/voice/laugh/silicon/laugh_siliconE1M1.ogg',
		'modular_bandastation/sounds/sound/voice/laugh/silicon/laugh_siliconM2.ogg',
	)

/obj/item/organ/internal/eyes/night_vision/arachnid
	name = "arachnid eyes"
	desc = "So many eyes!"
	icon = 'modular_bandastation/icons/obj/organs/organs.dmi'
	eye_icon_state = "arachnideyes"
	icon_state = "arachnid_eyeballs"
	overlay_ignore_lighting = TRUE
	no_glasses = TRUE
	low_light_cutoff = list(20, 15, 0)
	medium_light_cutoff = list(35, 30, 0)
	high_light_cutoff = list(50, 40, 0)

/obj/item/organ/internal/eyes/night_vision/arachnid/on_insert(mob/living/carbon/tongue_owner)
	. = ..()
	if(!ishuman(tongue_owner))
		return
	var/mob/living/carbon/human/human_receiver = tongue_owner
	if(!human_receiver.can_mutate())
		return
	var/datum/species/rec_species = human_receiver.dna.species
	rec_species.update_no_equip_flags(tongue_owner, rec_species.no_equip_flags | ITEM_SLOT_EYES)

/obj/item/organ/internal/eyes/night_vision/arachnid/on_remove(mob/living/carbon/tongue_owner)
	. = ..()
	if(!ishuman(tongue_owner))
		return
	var/mob/living/carbon/human/human_receiver = tongue_owner
	if(!human_receiver.can_mutate())
		return
	var/datum/species/rec_species = human_receiver.dna.species
	rec_species.update_no_equip_flags(tongue_owner, initial(rec_species.no_equip_flags))

/obj/item/organ/internal/tongue/arachnid
	name = "arachnid tongue"
	desc = "The tongue of an Arachnid. Mostly used for lying."
	say_mod = "chitters"
	modifies_speech = TRUE

/obj/item/organ/internal/tongue/arachnid/modify_speech(datum/source, list/speech_args) //This is flypeople speech
	var/static/regex/fly_buzz = new("z+", "g")
	var/static/regex/fly_buZZ = new("Z+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = fly_buzz.Replace(message, "zzz")
		message = fly_buZZ.Replace(message, "ZZZ")
		message = replacetext(message, "s", "z")
		message = replacetext(message, "S", "Z")
	speech_args[SPEECH_MESSAGE] = message
	disliked_foodtypes = NONE // Okay listen, i don't actually know what irl spiders don't like to eat and i'm pretty tired of looking for answers.
	liked_foodtypes = GORE | MEAT | BUGS | GROSS

/obj/item/organ/internal/tongue/arachnid/get_possible_languages()
	return ..() + /datum/language/buzzwords

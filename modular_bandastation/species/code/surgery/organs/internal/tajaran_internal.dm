/obj/item/organ/tongue/tajaran
	name = "feline tongue"
	desc = "Кошачий язык, может различить больше вкусов."
	icon_state = "tongue"
	taste_sensitivity = 10
	say_mod = "мяучит"
	modifies_speech = TRUE
	languages_native = list(/datum/language/siiktajr)
	var/static/list/speech_replacements = list(
		new /regex("r+", "g") = "rr",
		new /regex("R+", "g") = "RR",
		new /regex("р+", "g") = "рр",
		new /regex("Р+", "g") = "РР",
	)
	liked_foodtypes = MEAT | SEAFOOD | DAIRY
	disliked_foodtypes = NUTS | GROSS | ORANGES
	toxic_foodtypes = SUGAR
	organ_traits = list(TRAIT_WOUND_LICKER)

/obj/item/organ/tongue/tajaran/New(class, timer, datum/mutation/human/copymut)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = speech_replacements, should_modify_speech = CALLBACK(src, PROC_REF(should_modify_speech)))

/obj/item/organ/tongue/get_possible_languages()
	return ..() + /datum/language/siiktajr

/obj/item/organ/tongue/tajaran/on_mob_insert(mob/living/carbon/owner)
	. = ..()
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_meow)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_mow)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_purr)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_pur)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_purrr)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_hiss_t)

/obj/item/organ/tongue/tajaran/on_mob_remove(mob/living/carbon/owner)
	. = ..()
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_meow)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_mow)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_purr)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_pur)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_purrr)
	add_verb(owner, /mob/living/carbon/human/species/tajaran/proc/emote_hiss_t)

/obj/item/organ/stomach/tajaran
	hunger_modifier = 1.1

/obj/item/organ/liver/tajaran
	name = "tajaran liver"
	icon = 'modular_bandastation/species/icons/mob/species/tajaran/organs.dmi'
	alcohol_tolerance = ALCOHOL_RATE * 2

/obj/item/organ/eyes/tajaran
	name = "tajaran eyeballs"
	desc = "Глаза, приспособленные к темному освещению, но чувствительные к вспышкам."
	icon = 'modular_bandastation/species/icons/mob/species/tajaran/organs.dmi'
	lighting_cutoff = LIGHTING_CUTOFF_REAL_LOW
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/ears/tajaran
	desc = "Чувствительные уши позволяют легче слышать шепот."
	damage_multiplier = 2

/obj/item/organ/ears/tajaran/on_mob_insert(mob/living/carbon/ear_owner)
	. = ..()
	ADD_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

/obj/item/organ/ears/tajaran/on_mob_remove(mob/living/carbon/ear_owner)
	. = ..()
	REMOVE_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

/obj/item/organ/heart/tajaran
	name = "tajaran heart"
	icon = 'modular_bandastation/species/icons/mob/species/tajaran/organs.dmi'

/obj/item/organ/brain/tajaran
	icon = 'modular_bandastation/species/icons/mob/species/tajaran/organs.dmi'

/obj/item/organ/lungs/tajaran
	name = "tajaran lungs"
	icon = 'modular_bandastation/species/icons/mob/species/tajaran/organs.dmi'

/obj/item/organ/kidneys/tajaran
	name = "tajaran kidneys"
	icon = 'modular_bandastation/species/icons/mob/species/tajaran/organs.dmi'

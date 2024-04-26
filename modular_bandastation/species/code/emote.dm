/datum/emote
    /// Message displayed if the user is an IPC.
	var/message_ipc = ""
	/// Message displayed if the user is an insect.
	var/message_insect = ""


/datum/emote/select_message_type(mob/user, msg, intentional)
	. = ..()
	if((ismoth(user) || isflyperson(user) || isarachnid(user) || istype(user, /mob/living/basic/mothroach)) && message_insect)
		. = message_insect
	else if(isipc(user) && message_ipc)
		. = message_ipc
	return .

// ===================
// Emotes
// ===================
/datum/emote/living/click
	key = "click"
	key_third_person = "clicks their tongue"
	message = "clicks their tongue."
	message_ipc = "makes a click sound."
	message_insect = "clicks their mandibles."

/datum/emote/living/click/get_sound(mob/living/user)
	if(ismoth(user) || isflyperson(user) || isarachnid(user) || istype(user, /mob/living/basic/mothroach))
		return 'modular_bandastation/sounds/sound/creatures/rattle.ogg'
	else if(isipc(user))
		return 'sound/machines/click.ogg'
	else
		return FALSE

/datum/emote/living/zap
	key = "zap"
	key_third_person = "zaps"
	message = "zaps."
	message_param = "zaps %t."

/datum/emote/living/zap/can_run_emote(mob/user, status_check = TRUE , intentional)
	. = ..()
	if(isethereal(user))
		return TRUE
	else
		return FALSE

/datum/emote/living/zap/get_sound(mob/living/user)
	if(isethereal(user))
		return 'sound/machines/defib_zap.ogg'

/datum/emote/living/hum
	key = "hum"
	key_third_person = "hums"
	message = "hums."
	message_robot = "lets out a droning hum."
	message_AI = "lets out a droning hum."
	message_ipc = "lets out a droning hum."
	message_mime = "silently hums."

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "lets out a hiss."
	message_robot = "plays a hissing noise."
	message_AI = "plays a hissing noise."
	message_ipc = "plays a hissing noise."
	message_mime = "acts out a hiss."
	message_param = "hisses at %t."

/datum/emote/living/hiss/get_sound(mob/living/user)
	if(islizard(user) || isipc(user) || isAI(user) || iscyborg(user))
		return pick('sound/voice/hiss1.ogg', 'sound/voice/hiss2.ogg', 'sound/voice/hiss3.ogg', 'sound/voice/hiss4.ogg', 'sound/voice/hiss5.ogg', 'sound/voice/hiss6.ogg')
	else if(is_cat_enough(user))
		return pick('modular_bandastation/sounds/sound/voice/feline/hiss1.ogg', 'modular_bandastation/sounds/sound/voice/feline/hiss2.ogg', 'modular_bandastation/sounds/sound/voice/feline/hiss3.ogg')

/proc/is_cat_enough(mob/living/user)
	. = FALSE
	if(iscat(user)) // there's nothing more cat than a cat
		return TRUE
	if(HAS_TRAIT(user, TRAIT_CATLIKE_GRACE))
		return TRUE
	if(istype(user.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/costume/kitty)) // combine with glue for hilarity
		return TRUE

/datum/emote/living/thumbs_up
	key = "thumbsup"
	key_third_person = "thumbsup"
	message = "flashes a thumbs up."
	message_robot = "makes a crude thumbs up with their 'hands'."
	message_AI = "flashes a quick hologram of a thumbs up."
	message_ipc = "flashes a thumbs up icon."
	message_animal_or_basic = "attempts a thumbs up."
	message_param = "flashes a thumbs up at %t."
	hands_use_check = TRUE

/datum/emote/living/thumbs_down
	key = "thumbsdown"
	key_third_person = "thumbsdown"
	message = "flashes a thumbs down."
	message_robot = "makes a crude thumbs down with their 'hands'."
	message_AI = "flashes a quick hologram of a thumbs down."
	message_ipc = "flashes a thumbs down icon."
	message_animal_or_basic = "attempts a thumbs down."
	message_param = "flashes a thumbs down at %t."
	hands_use_check = TRUE

/datum/emote/living/whistle
	key="whistle"
	key_third_person="whistle"
	message = "whistles a few notes."
	message_robot = "whistles a few synthesized notes."
	message_AI = "whistles a synthesized song."
	message_ipc = "whistles a few synthesized notes."
	message_param = "whistles at %t."

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "screams!"
	message_mime = "acts out a scream!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = FALSE

/datum/emote/living/scream/get_sound(mob/living/user)
	if(issilicon(user))
		return pick(
			'modular_bandastation/sounds/sound/voice/screams/silicon/robotAUGH1.ogg',
			'modular_bandastation/sounds/sound/voice/screams/silicon/robotAUGH2.ogg',
			'modular_bandastation/sounds/sound/voice/screams/silicon/robotAUGH3.ogg',
			'modular_bandastation/sounds/sound/voice/screams/silicon/robotAUGH4.ogg',
			'modular_bandastation/sounds/sound/voice/screams/silicon/robotAUGH5.ogg')
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		. = human_user.dna.species.get_scream_sound(user)
	if(is_cat_enough(user))
		return pick('modular_bandastation/sounds/sound/voice/feline/scream1.ogg', 'modular_bandastation/sounds/sound/voice/feline/scream2.ogg', 'modular_bandastation/sounds/sound/voice/feline/scream3.ogg')

/datum/emote/living/scream/should_vary(mob/living/user)
	if(ishuman(user) && !is_cat_enough(user))
		return TRUE
	return ..()

/datum/emote/living/scream/screech //If a human tries to screech it'll just scream.
	key = "screech"
	key_third_person = "screeches"
	message = "screeches!"
	message_mime = "screeches silently."
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = FALSE

/datum/emote/living/scream/screech/should_play_sound(mob/user, intentional)
	if(ismonkey(user))
		return TRUE
	return ..()

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "meows."
	message_mime = "acts out a meow."
	message_param = "meows at %t."
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/meow/can_run_emote(mob/user, status_check = TRUE, intentional = FALSE)
	return ..() && is_cat_enough(user, include_all_anime = TRUE)

/datum/emote/living/meow/get_sound(mob/living/user)
	return pick('modular_bandastation/sounds/sound/voice/feline/meow1.ogg', 'modular_bandastation/sounds/sound/voice/feline/meow2.ogg', 'modular_bandastation/sounds/sound/voice/feline/meow3.ogg', 'modular_bandastation/sounds/sound/voice/feline/meow4.ogg')


/datum/emote/living/weh
	key = "weh"
	key_third_person = "wehs"
	message = "wehs!"
	message_param = "wehs at %t!"
	message_mime = "wehs silently!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/weh/get_sound(mob/living/user)
	if(islizard(user))
		return 'modular_bandastation/sounds/sound/voice/weh.ogg'
	else
		return FALSE

/datum/emote/living/weh/can_run_emote(mob/user, status_check, intentional)
	if(islizard(user))
		return TRUE
	else
		return FALSE

/datum/emote/living/squeal
	key = "squeal"
	key_third_person = "squeals"
	message = "squeals!"
	message_param = "squeals at %t!"
	message_mime = "squeals silently!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/squeal/get_sound(mob/living/user)
	if(islizard(user))
		return 'modular_bandastation/sounds/sound/voice/lizard/squeal.ogg' //This is from Bay
	else
		return FALSE

/datum/emote/living/squeal/can_run_emote(mob/user, status_check, intentional)
	if(islizard(user))
		return TRUE
	else
		return FALSE

/datum/emote/living/tailthump
	key = "thump"
	key_third_person = "thumps their tail"
	message = "thumps their tail!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/tailthump/get_sound(mob/living/user)
	if(islizard(user))
		return 'modular_bandastation/sounds/sound/voice/lizard/tailthump.ogg' //https://freesound.org/people/TylerAM/sounds/389665/
	else
		return FALSE

/datum/emote/living/tailthump/can_run_emote(mob/user, status_check, intentional)
	if(islizard(user))
		return TRUE
	else
		return FALSE

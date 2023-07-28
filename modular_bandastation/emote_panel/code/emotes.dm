/datum/emote
	var/name

/datum/emote/New()
	. = ..()
	if(!name)
		name = key

// Imaginary Friend

/datum/emote/imaginary_friend/point
	name = "указать"
	message = "указывает."
	message_param = "указывает на %t."

// Emote Living

/datum/emote/flip
	name = "кувырок"

/datum/emote/spin
	name = "крутиться"

/datum/emote/living/blush
	name = "покраснеть"
	message = "краснеет."

/datum/emote/living/sing_tune
	name = "tunesing"
	message = "sings a tune."

/datum/emote/living/bow
	name = "кивнуть"
	message = "кивает."
	message_param = "кивает в сторону %t."

/datum/emote/living/burp
	name = "рыгать"
	message = "рыгает."
	message_mime = "изображает отрыжку."

/datum/emote/living/choke
	name = "подавиться"
	message = "давится!"
	message_mime = "бесшумно давится!"

/datum/emote/living/cross
	name = "скрестить руки"
	message = "скрещивает свои руки."

/datum/emote/living/chuckle
	name = "усмехнуться"
	message = "усмехается."
	message_mime = "изображает смешок."

/datum/emote/living/collapse
	name = "упасть"
	message = "падает!"

/datum/emote/living/cough
	name = "кашлять"
	message = "кашляет!"
	message_mime = "изображает преувеличенный кашель!"

/datum/emote/living/dance
	name = "танцевать"
	message = "радостно танцует."

/datum/emote/living/deathgasp
	name = "deathgasp"
	message = "seizes up and falls limp, their eyes dead and lifeless..."
	message_robot = "shudders violently for a moment before falling still, its eyes slowly darkening."
	message_AI = "screeches, its screen flickering as its systems slowly halt."
	message_alien = "lets out a waning guttural screech, and collapses onto the floor..."
	message_larva = "lets out a sickly hiss of air and falls limply to the floor..."
	message_monkey = "lets out a faint chimper as it collapses and stops moving..."
	message_animal_or_basic = "stops moving..."

/datum/emote/living/drool
	name = "drool"
	message = "drools."

/datum/emote/living/faint
	name = "faint"
	message = "faints."

/datum/emote/living/flap
	name = "flap"
	message = "flaps their wings."

/datum/emote/living/flap/aflap
	name = "aflap"
	message = "flaps their wings ANGRILY!"

/datum/emote/living/frown
	name = "frown"
	message = "frowns."

/datum/emote/living/gag
	name = "gag"
	message = "gags."
	message_mime = "gags silently."

/datum/emote/living/gasp
	name = "gasp"
	message = "gasps!"
	message_mime = "gasps silently!"

/datum/emote/living/gasp_shock
	name = "gaspshock"
	message = "gasps in shock!"
	message_mime = "gasps in silent shock!"

/datum/emote/living/giggle
	name = "giggle"
	message = "giggles."
	message_mime = "giggles silently!"

/datum/emote/living/glare
	name = "glare"
	message = "glares."
	message_param = "glares at %t."

/datum/emote/living/grin
	name = "grin"
	message = "grins."

/datum/emote/living/groan
	name = "groan"
	message = "groans!"
	message_mime = "appears to groan!"

/datum/emote/living/grimace
	name = "grimace"
	message = "grimaces."

/datum/emote/living/jump
	name = "jump"
	message = "jumps!"

/datum/emote/living/kiss
	name = "kiss"

/datum/emote/living/laugh
	name = "laugh"
	message = "laughs."
	message_mime = "laughs silently!"

/datum/emote/living/look
	name = "look"
	message = "looks."
	message_param = "looks at %t."

/datum/emote/living/nod
	name = "nod"
	message = "nods."
	message_param = "nods at %t."

/datum/emote/living/point
	name = "point"
	message = "points."
	message_param = "points at %t."

/datum/emote/living/pout
	name = "pout"
	message = "pouts."
	message_mime = "pouts silently."

/datum/emote/living/scream
	name = "scream"
	message = "screams!"
	message_mime = "acts out a scream!"

/datum/emote/living/scowl
	name = "scowl"
	message = "scowls."

/datum/emote/living/shake
	name = "shake"
	message = "shakes their head."

/datum/emote/living/shiver
	name = "shiver"
	message = "shivers."

/datum/emote/living/sigh
	name = "sigh"
	message = "sighs."
	message_mime = "acts out an exaggerated silent sigh."

/datum/emote/living/sit
	name = "sit"
	message = "sits down."

/datum/emote/living/smile
	name = "smile"
	message = "smiles."

/datum/emote/living/sneeze
	name = "sneeze"
	message = "sneezes."
	message_mime = "acts out an exaggerated silent sneeze."

/datum/emote/living/smug
	name = "smug"
	message = "grins smugly."

/datum/emote/living/sniff
	name = "sniff"
	message = "sniffs."
	message_mime = "sniffs silently."

/datum/emote/living/snore
	name = "snore"
	message = "snores."
	message_mime = "sleeps soundly."

/datum/emote/living/stare
	name = "stare"
	message = "stares."
	message_param = "stares at %t."

/datum/emote/living/strech
	name = "stretch"
	message = "stretches their arms."

/datum/emote/living/sulk
	name = "sulk"
	message = "sulks down sadly."

/datum/emote/living/surrender
	name = "surrender"
	message = "puts their hands on their head and falls to the ground, they surrender%s!"

/datum/emote/living/sway
	name = "sway"
	message = "sways around dizzily."

/datum/emote/living/tilt
	name = "tilt"
	message = "tilts their head to the side."

/datum/emote/living/tremble
	name = "tremble"
	message = "trembles in fear!"

/datum/emote/living/twitch
	name = "twitch"
	message = "twitches violently."

/datum/emote/living/twitch_s
	name = "twitch_s"
	message = "twitches."

/datum/emote/living/wave
	name = "wave"
	message = "waves."

/datum/emote/living/whimper
	name = "whimper"
	message = "whimpers."
	message_mime = "appears hurt."

/datum/emote/living/wsmile
	name = "wsmile"
	message = "smiles weakly."

/datum/emote/living/yawn
	name = "yawn"
	message = "yawns."
	message_mime = "acts out an exaggerated silent yawn."

/datum/emote/living/gurgle
	name = "gurgle"
	message = "makes an uncomfortable gurgle."
	message_mime = "gurgles silently and uncomfortably."

/datum/emote/living/beep
	name = "beep"
	message = "beeps."
	message_param = "beeps at %t."

/datum/emote/living/inhale
	name = "inhale"
	message = "breathes in."

/datum/emote/living/exhale
	name = "exhale"
	message = "breathes out."

/datum/emote/living/swear
	name = "swear"
	message = "says a swear word!"
	message_mime = "makes a rude gesture!"

// Emote Brain

/datum/emote/brain/alarm
	name = "alarm"
	message = "sounds an alarm."

/datum/emote/brain/alert
	name = "alert"
	message = "lets out a distressed noise."

/datum/emote/brain/flash
	name = "flash"
	message = "blinks their lights."

/datum/emote/brain/notice
	name = "notice"
	message = "plays a loud tone."

/datum/emote/brain/whistle
	name = "whistle"
	message = "whistles."

// Emote Carbon

/datum/emote/living/carbon/airguitar
	name = "airguitar"
	message = "is strumming the air and headbanging like a safari chimp."

/datum/emote/living/carbon/blink
	name = "blink"
	message = "blinks."

/datum/emote/living/carbon/blink_r
	name = "blink_r"
	message = "blinks rapidly."

/datum/emote/living/carbon/clap
	name = "clap"
	message = "claps."

/datum/emote/living/carbon/crack
	name = "crack"
	message = "cracks their knuckles."

/datum/emote/living/carbon/circle
	name = "circle"

/datum/emote/living/carbon/moan
	name = "moan"
	message = "moans!"
	message_mime = "appears to moan!"

/datum/emote/living/carbon/noogie
	name = "noogie"

/datum/emote/living/carbon/roll
	name = "roll"
	message = "rolls."

/datum/emote/living/carbon/scratch
	name = "scratch"
	message = "scratches."

/datum/emote/living/carbon/sign
	name = "sign"
	message_param = "signs the number %t."

/datum/emote/living/carbon/sign/signal
	name = "signal"
	message_param = "raises %t fingers."

/datum/emote/living/carbon/slap
	name = "slap"

/datum/emote/living/carbon/hand
	name = "hand"

/datum/emote/living/carbon/snap
	name = "snap"
	message = "snaps their fingers."

/datum/emote/living/carbon/shoesteal
	name = "shoesteal"

/datum/emote/living/carbon/tail
	name = "tail"
	message = "waves their tail."

/datum/emote/living/carbon/wink
	name = "wink"
	message = "winks."

// Emote Alien

/datum/emote/living/alien/gnarl
	name = "gnarl"
	message = "gnarls and shows its teeth..."

/datum/emote/living/alien/hiss
	name = "hiss"
	message_alien = "hisses."
	message_larva = "hisses softly."

/datum/emote/living/alien/roar
	name = "roar"
	message_alien = "roars."
	message_larva = "softly roars."

// Emote Human

/datum/emote/living/carbon/human/cry
	name = "cry"
	message = "cries."
	message_mime = "sobs silently."

/datum/emote/living/carbon/human/dap
	name = "dap"
	message = "sadly can't find anybody to give daps to, and daps themself. Shameful."
	message_param = "give daps to %t."

/datum/emote/living/carbon/human/eyebrow
	name = "eyebrow"
	message = "raises an eyebrow."

/datum/emote/living/carbon/human/grumble
	name = "grumble"
	message = "grumbles!"
	message_mime = "grumbles silently!"

/datum/emote/living/carbon/human/handshake
	name = "handshake"
	message = "shakes their own hands."
	message_param = "shakes hands with %t."

/datum/emote/living/carbon/human/hug
	name = "hug"
	message = "hugs themself."
	message_param = "hugs %t."

/datum/emote/living/carbon/human/mumble
	name = "mumble"
	message = "mumbles!"
	message_mime = "mumbles silently!"

/datum/emote/living/carbon/human/scream
	name = "scream"
	message = "screams!"
	message_mime = "acts out a scream!"

/datum/emote/living/carbon/human/scream/screech
	name = "screech"
	message = "screeches!"
	message_mime = "screeches silently."

/datum/emote/living/carbon/human/pale
	name = "pale"
	message = "goes pale for a second."

/datum/emote/living/carbon/human/raise
	name = "raise"
	message = "raises a hand."

/datum/emote/living/carbon/human/salute
	name = "salute"
	message = "salutes."
	message_param = "salutes to %t."

/datum/emote/living/carbon/human/shrug
	name = "shrug"
	message = "shrugs."

/datum/emote/living/carbon/human/wag
	name = "wag"
	message = "their tail."

/datum/emote/living/carbon/human/wing
	name = "wing"
	message = "their wings."

/datum/emote/living/carbon/human/clear_throat
	name = "clear"
	message = "clears their throat."

/datum/emote/living/carbon/human/monkey/gnarl
	name = "gnarl"
	message = "gnarls and shows its teeth..."
	message_mime = "gnarls silently, baring its teeth..."

/datum/emote/living/carbon/human/monkey/roll
	name = "roll"
	message = "rolls."

/datum/emote/living/carbon/human/monkey/scratch
	name = "scratch"
	message = "scratches."

/datum/emote/living/carbon/human/monkey/screech/roar
	name = "roar"
	message = "roars!"
	message_mime = "acts out a roar."

/datum/emote/living/carbon/human/monkey/tail
	name = "tail"
	message = "waves their tail."

/datum/emote/living/carbon/human/monkey/sign
	name = "sign"
	message_param = "signs the number %t."

// Emote AI

/datum/emote/ai/emotion_display
	name = "blank"

/datum/emote/ai/emotion_display/very_happy
	name = "veryhappy"

/datum/emote/ai/emotion_display/happy
	name = "happy"

/datum/emote/ai/emotion_display/neutral
	name = "neutral"

/datum/emote/ai/emotion_display/unsure
	name = "unsure"

/datum/emote/ai/emotion_display/confused
	name = "confused"

/datum/emote/ai/emotion_display/sad
	name = "sad"

/datum/emote/ai/emotion_display/bsod
	name = "bsod"

/datum/emote/ai/emotion_display/trollface
	name = "trollface"

/datum/emote/ai/emotion_display/awesome
	name = "awesome"

/datum/emote/ai/emotion_display/dorfy
	name = "dorfy"

/datum/emote/ai/emotion_display/thinking
	name = "thinking"

/datum/emote/ai/emotion_display/facepalm
	name = "facepalm"

/datum/emote/ai/emotion_display/friend_computer
	name = "friendcomputer"

/datum/emote/ai/emotion_display/blue_glow
	name = "blueglow"

/datum/emote/ai/emotion_display/red_glow
	name = "redglow"

// Emote Silicon

/datum/emote/silicon/boop
	name = "boop"
	message = "boops."

/datum/emote/silicon/buzz
	name = "buzz"
	message = "buzzes."
	message_param = "buzzes at %t."

/datum/emote/silicon/buzz2
	name = "buzz2"
	message = "buzzes twice."

/datum/emote/silicon/chime
	name = "chime"
	message = "chimes."

/datum/emote/silicon/honk
	name = "honk"
	message = "honks."

/datum/emote/silicon/ping
	name = "ping"
	message = "pings."
	message_param = "pings at %t."

/datum/emote/silicon/sad
	name = "sad"
	message = "plays a sad trombone..."

/datum/emote/silicon/warn
	name = "warn"
	message = "blares an alarm!"

/datum/emote/silicon/slowclap
	name = "slowclap"
	message = "activates their slow clap processor."

// Emote Slime

/datum/emote/slime/bounce
	name = "bounce"
	message = "bounces in place."

/datum/emote/slime/jiggle
	name = "jiggle"
	message = "jiggles!"

/datum/emote/slime/light
	name = "light"
	message = "lights up for a bit, then stops."

/datum/emote/slime/vibrate
	name = "vibrate"
	message = "vibrates!"

/datum/emote/slime/mood
	name = "moodnone"

/datum/emote/slime/mood/sneaky
	name = "moodsneaky"
	mood_key = "mischievous"

/datum/emote/slime/mood/smile
	name = "moodsmile"
	mood_key = ":3"

/datum/emote/slime/mood/cat
	name = "moodcat"
	mood_key = ":33"

/datum/emote/slime/mood/pout
	name = "moodpout"
	mood_key = "pout"

/datum/emote/slime/mood/sad
	name = "moodsad"
	mood_key = "sad"

/datum/emote/slime/mood/angry
	name = "moodangry"
	mood_key = "angry"

// Emote Other

/datum/emote/gorilla/ooga
	name = "ooga"
	message = "oogas."
	message_param = "oogas at %t."

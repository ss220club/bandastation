GLOBAL_LIST_INIT(ru_say_verbs, list(
	// atom/movable
	"says" = "говорит",
	"asks" = "спрашивает",
	"exclaims" = "",
	"whispers",
	"sings",
	"yells",
	// sign language
	"signs" = "жестикулирует",
	"subtly signs" = "незаметно жестикулирует",
	"rythmically signs" = "ритмично жестикулирует",
	"emphatically signs" = "выразительно жестикулирует",
	// verb_say
	"beeps",
	"coldly states",
	"states",
	"rattles",
	"moans",
	"intones",
	"psychically pulses",
	"gurgles",
	"spittles",
	"blorbles",
	"warps",
	"chitters",
	"ribbits",
	"squeaks",
	"flutters",
	"hisses",
	"echoes",
	"chants",
	"codes",
	// verb_ask
	"queries",
	"bloops",
	"questionably beeps",
	"psychically probes",
	"demands",
	"spittles questioningly",
	"inquisitively blorbles",
	"loudly blorbles",
	"floats inquisitively",
	"chitters inquisitively",
	// verb_exclaim
	"blares",
	"beeps loudly",
	"declares",
	"psychically yells",
	"roars",
	"splutters and gurgles",
	"loudly blorbles",
	"zaps",
	"chitters loudly",
	"croaks",
	"flutters loudly",
	"compiles",
	// verb_yell
	"wails",
	"alarms",
	"bellows",
	"psychically screams",
))

/atom/movable/say_mod(input, list/message_mods)
	. = ..()
	return GLOB.ru_say_verbs[.] || .

/mob/living/say_mod(input, list/message_mods)
	. = ..()
	return GLOB.ru_say_verbs[.] || .

/obj/machinery/requests_console/say_mod(input, list/message_mods)
	. = ..()
	return GLOB.ru_say_verbs[.] || .

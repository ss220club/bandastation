GLOBAL_LIST_INIT(ru_say_verbs, list(
	// atom/movable
	"says" = "говорит",
	"asks" = "спрашивает",
	"exclaims" = "восклицает",
	"whispers" = "шепчет",
	"sings" = "поет",
	"yells" = "кричит",
	// sign language
	"signs" = "жестикулирует",
	"subtly signs" = "незаметно жестикулирует",
	"rythmically signs" = "ритмично жестикулирует",
	"emphatically signs" = "выразительно жестикулирует",
	// verb_say
	"beeps" = "сигналит",
	"coldly states" = "докладывает",
	"states" = "сообщает",
	"rattles" = "гремит",
	"moans" = "стонет",
	"intones" = "подпевает",
	"psychically pulses" = "психически пульсирует",
	"gurgles" = "булькает",
	"spittles" = "плюет",
	"blorbles" = "",
	"warps" = "",
	"chitters" = "щебетит",
	"ribbits" = "квакает",
	"squeaks" = "щипит",
	"flutters" = "трепещет",
	"hisses" = "шипит",
	"echoes" = "эхом повторяет",
	"chants" = "воспевает",
	"codes" = "кодит",
	// verb_ask
	"queries" = "спрашивает",
	"bloops" = "спрашивает",
	"questionably beeps" = "вопросительно сигналит",
	"psychically probes" = "психически расспрашивает",
	"demands" = "спрашивает",
	"spittles questioningly" = "вопросительно плюет",
	"inquisitively blorbles" = "",
	"loudly blorbles" = "",
	"floats inquisitively" = "",
	"chitters inquisitively" = "вопросительно щебетит",
	// verb_exclaim
	"blares" = "трубит",
	"beeps loudly" = "громко сигналит",
	"declares" = "восклицает",
	"psychically yells" = "психически кричит",
	"roars" = "рычит",
	"splutters and gurgles" = "плюет и булькает",
	"loudly blorbles" = "",
	"zaps" = "",
	"chitters loudly" = "громко щебетит",
	"croaks" = "квакает",
	"flutters loudly" = "громко трепещет",
	"compiles" = "компилирует",
	// verb_yell
	"wails" = "вопит",
	"alarms" = "сигнализирует",
	"bellows" = "ревет",
	"psychically screams" = "психически вопит",
	// slur
	"loosely signs" = "размашисто жестикулирует",
	"slurs" = "ругается",
	// stutter
	"shakily signs" = "неуверенно жестикулирует",
	"stammers" = "заикается",
	// gibbers
	"incoherently signs" = "бессвязно жестикулирует",
	"gibbers" = "тараторит",
	// say_mod (tongue)
	"crackles" = "трещит",
	"meows" = "мяукает",
	"chirps" = "чирикает",
	"chimpers" = "",
	"poofs" = "",
	"whistles" = "свистит",
	"rumbles" = "грохочет",
	// other
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

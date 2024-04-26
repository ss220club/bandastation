/obj/item/organ/internal/brain/clockwork
	name = "enigmatic gearbox"
	desc ="An engineer would call this inconcievable wonder of gears and metal a 'black box'"
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "brain-clock"
	organ_flags = ORGAN_ROBOTIC
	var/robust //Set to true if the robustbits causes brain replacement. Because holy fuck is the CLANG CLANG CLANG CLANG annoying

/obj/item/organ/internal/brain/clockwork/emp_act(severity)
	. = ..()
	owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25)

/obj/item/organ/internal/brain/clockwork/on_life()
	. = ..()
	if(prob(5) && !robust)
		SEND_SOUND(owner, sound('sound/ambience/ambiruin3.ogg', volume = 25))

/obj/item/organ/internal/lungs/clockwork
	name = "clockwork diaphragm"
	desc = "A utilitarian bellows which serves to pump oxygen into an automaton's body."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "lungs-clock"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/ears/robot/clockwork
	name = "biometallic recorder"
	desc = "An odd sort of microphone that looks grown, rather than built."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "ears-clock"

/obj/item/organ/internal/eyes/robotic/clockwork
	name = "biometallic receptors"
	desc = "A fragile set of small, mechanical cameras."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "clockwork_eyeballs"

/obj/item/organ/internal/heart/clockwork //this heart doesnt have the fancy bits normal cyberhearts do. However, it also doesnt fucking kill you when EMPd
	name = "biomechanical pump"
	desc = "A complex, multi-valved hydraulic pump, which fits perfectly where a heart normally would."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "heart-clock"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/liver/clockwork
	name = "biometallic alembic"
	desc = "A series of small pumps and boilers, designed to facilitate proper metabolism."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "liver-clock"
	organ_flags = ORGAN_ROBOTIC
	alcohol_tolerance = 0
	liver_resistance = 0
	toxTolerance = 1 //while the organ isn't damaged by doing its job, it doesnt do it very well

/obj/item/organ/internal/stomach/clockwork
	name = "nutriment refinery"
	desc = "A biomechanical furnace, which turns calories into mechanical energy."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "stomach-clock"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/stomach/clockwork/emp_act(severity)
	. = ..()
	owner.adjust_nutrition(-100)  //got rid of severity part

/obj/item/organ/internal/stomach/battery/clockwork
	name = "biometallic flywheel"
	desc = "A biomechanical battery which stores mechanical energy."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "stomach-clock"
	organ_flags = ORGAN_ROBOTIC
	//max_charge = 7500
	//charge = 7500 //old bee code

// ======================
// Tongue

/obj/item/organ/internal/tongue/robot/clockwork
	name = "dynamic micro-phonograph"
	desc = "An old-timey looking device connected to an odd, shifting cylinder."
	icon = 'modular_bandastation/species/icons/obj/organs/organs.dmi'
	icon_state = "tongueclock"

/obj/item/organ/internal/tongue/robot/clockwork/better
	name = "amplified dynamic micro-phonograph"

/obj/item/organ/internal/tongue/robot/clockwork/better/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
	//speech_args[SPEECH_SPANS] |= SPAN_REALLYBIG  //i disabled this, its abnoxious and makes their chat take 3 times as much space in chat

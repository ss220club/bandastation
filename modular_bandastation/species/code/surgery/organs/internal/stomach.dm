/obj/item/organ/internal/stomach/clockwork
	name = "nutriment refinery"
	desc = "A biomechanical furnace, which turns calories into mechanical energy."
	icon = 'modular_bandastation/icons/obj/organs/organs.dmi'
	icon_state = "stomach-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/stomach/clockwork/emp_act(severity)
	owner.adjust_nutrition(-100)  //got rid of severity part

/obj/item/organ/internal/stomach/battery/clockwork
	name = "biometallic flywheel"
	desc = "A biomechanical battery which stores mechanical energy."
	icon = 'modular_bandastation/icons/obj/organs/organs.dmi'
	icon_state = "stomach-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_ROBOTIC
	//max_charge = 7500
	//charge = 7500 //old bee code

/obj/item/organ/internal/tongue/oozeling
	name = "oozeling tongue"
	desc = "A goopy organ that mimics the tongues of other carbon beings."
	icon = 'modular_bandastation/icons/obj/organs/organs.dmi'
	icon_state = "tongue_oozeling"
	say_mod = "blurbles"
	alpha = 200

// Oozeling tongues can speak all default + slime
/obj/item/organ/internal/tongue/oozeling/get_possible_languages()
	return ..() + /datum/language/slime

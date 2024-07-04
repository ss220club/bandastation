/obj/item/storage/chem_bag
	name = "Chemical bag"
	desc = "Pretty big bag for storing chemicals before put them into fridge."
	icon_state = "bag"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/chemical_storage


/datum/storage/chemical_storage
	max_slots = 75
	numerical_stacking = TRUE
	screen_max_columns = 4

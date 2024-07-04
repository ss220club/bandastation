/obj/item/storage/field_kit
	name = "Field kit"
	desc = "Small container for storing medical supplies."
	icon_state = "pill_canister"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/medical_storage


/datum/storage/medical_storage
	max_slots = 40
	numerical_stacking = TRUE
	screen_max_columns = 10

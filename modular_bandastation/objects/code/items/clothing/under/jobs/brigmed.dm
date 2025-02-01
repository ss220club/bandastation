/datum/armor/clothing_under/brigmed
	melee = 5
	bomb = 10
	fire = 30
	acid = 30

/obj/item/clothing/under/rank/brigmed
	icon = 'modular_bandastation/objects/icons/obj/clothing/under/brigmed.dmi'
	worn_icon = 'modular_bandastation/objects/icons/mob/clothing/under/brigmed.dmi'
	name = "brig medical suit "
	desc = "A classic suit designed for use in a non sterile environment."
	icon_state = "brigmed"
	strip_delay = 50
	armor_type = /datum/armor/clothing_under/brigmed
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/brigmed/skirt
	name = "brig medical suitskirt"
	desc = "A classic suitskirt designed for use in a non sterile environment."
	icon_state = "brigmed_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

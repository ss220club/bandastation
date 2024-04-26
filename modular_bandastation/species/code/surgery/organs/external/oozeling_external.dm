//limb removal. The "special" argument is used for swapping a limb with a new one without the effects of losing a limb kicking in.
/obj/item/bodypart/drop_limb(special, dismembered, move_to_floor = TRUE)
	if(!owner)
		return
	var/mob/living/carbon/phantom_owner = update_owner(null) // so we can still refer to the guy who lost their limb after said limb forgets 'em
	if(limb_id == SPECIES_OOZELING)
		to_chat(phantom_owner, span_warning("Your [src] splatters with an unnerving squelch!"))
		playsound(phantom_owner, 'sound/effects/blobattack.ogg', 60, TRUE)
		phantom_owner.blood_volume -= 60 //Makes for 120 when you regenerate it.
		qdel(src)
		return
	. = ..()

/obj/item/bodypart/head/oozeling
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/oozeling/bodyparts.dmi'
	limb_id = SPECIES_OOZELING
	is_dimorphic = TRUE
	biological_state = BIO_INORGANIC

	dmg_overlay_type = null

/obj/item/bodypart/chest/oozeling
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/oozeling/bodyparts.dmi'
	limb_id = SPECIES_OOZELING
	is_dimorphic = TRUE
	biological_state = BIO_INORGANIC

	dmg_overlay_type = null

/obj/item/bodypart/arm/left/oozeling
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/oozeling/bodyparts.dmi'
	limb_id = SPECIES_OOZELING
	biological_state = BIO_INORGANIC

	dmg_overlay_type = null

/obj/item/bodypart/arm/right/oozeling
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/oozeling/bodyparts.dmi'
	limb_id = SPECIES_OOZELING
	biological_state = BIO_INORGANIC

/obj/item/bodypart/leg/left/oozeling
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/oozeling/bodyparts.dmi'
	limb_id = SPECIES_OOZELING
	biological_state = BIO_INORGANIC

	dmg_overlay_type = null

/obj/item/bodypart/leg/right/oozeling
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/oozeling/bodyparts.dmi'
	limb_id = SPECIES_OOZELING
	biological_state = BIO_INORGANIC

	dmg_overlay_type = null

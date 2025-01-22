/obj/item/organ/brain/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/brain_permanent_death))
		decay_factor = STANDARD_ORGAN_DECAY * 2 //7 минут до полной смерти (в 4 раза быстрее чем по умолчанию (30 минут))

/datum/surgery/brain_surgery/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(.)
		return

	var/obj/item/organ/brain/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	return !(brain.organ_flags & ORGAN_FAILING) && !CONFIG_GET(flag/brain_permanent_death)

/datum/config_entry/flag/brain_permanent_death

/obj/item/bodybag/stasis
	name = "Stasis body bag"
	desc = "A folded bag designed for the storage and transportation of cadavers with portable stasis module and little space."
	icon = 'icons/obj/medical/bodybag.dmi' //на замену
	icon_state = "bodybag_folded" //на замену
	// Stored path we use for spawning a new body bag entity when unfolded.
	unfoldedbag_path = /obj/structure/closet/body_bag/stasis

/datum/design/stasisbodybag
	name = "Stasis Body Bag"
	desc = "A folded bag designed for the storage and transportation of cadavers with portable stasis module and little space."
	id = "stasisbodybag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/bodybag/stasis
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/obj/structure/closet/body_bag/stasis
	name = "stasis body bag"
	desc = "A plastic bag designed for the storage and transportation of cadavers with portable stasis module and little space."
	icon = 'icons/obj/medical/bodybag.dmi' //на замену
	icon_state = "bodybag"
	mob_storage_capacity = 1
	open_sound = 'sound/items/zip/zip.ogg' //на замену
	close_sound = 'sound/items/zip/zip.ogg' //на замену
	foldedbag_path = /obj/item/bodybag/stasis

/obj/structure/closet/body_bag/stasis/close(mob/living/user)
	. = ..()
	for(var/mob/living/mob in contents)
		mob.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
		ADD_TRAIT(mob, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)
		mob.extinguish_mob()

/obj/structure/closet/body_bag/stasis/open(mob/living/user, force = FALSE, special_effects = TRUE)
	. = ..()
	for(var/mob/living/mob in contents)
		mob.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
		REMOVE_TRAIT(mob, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)

/datum/techweb_node/applied_bluespace/Initialize()
	. = ..()
	design_ids += list("stasisbodybag")

/obj/item/reagent_containers/hypospray/medipen/Initialize()
	. = ..()
	list_reagents = list(/datum/reagent/medicine/epinephrine = 10, /datum/reagent/medicine/coagulant = 2)

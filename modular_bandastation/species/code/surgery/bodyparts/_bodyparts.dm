/obj/item/bodypart/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	if(!.)
		return

	if((SPECIES_FUR in owner_species.species_traits))
		if(owner_species.fixed_mut_color)
			species_color = owner_species.fixed_mut_color
		else
			species_color = human_owner.dna.features["mcolor"]
	else
		species_color = null

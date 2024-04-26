/obj/item
	//Overrides for digitigrade and snouted clothing handling
	//Icon file for mob worn overlays, if the user is digitigrade.
	var/icon/worn_icon_digitigrade
	//Same as above, but for if the user is snouted.
	var/icon/worn_icon_snouted

	var/greyscale_config_worn_digitigrade
	var/greyscale_config_worn_snouted

	/// Used for BODYTYPE_CUSTOM: Needs to follow this syntax: a list() with the x and y coordinates of the pixel you want to get the color from. Colors are filled in as GAGs values for fallback.
	var/list/species_clothing_color_coords[3]

/// Checks if this atom uses the GAGS system and if so updates the worn and inhand icons
/obj/item/update_greyscale()
	. = ..()
	if(!greyscale_colors)
		return
	if(greyscale_config_worn_digitigrade)
		worn_icon_digitigrade = SSgreyscale.GetColoredIconByType(greyscale_config_worn_digitigrade, greyscale_colors)
	if(greyscale_config_worn_snouted)
		worn_icon_snouted = SSgreyscale.GetColoredIconByType(greyscale_config_worn_snouted, greyscale_colors)

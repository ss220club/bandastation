/**
 * Checks if the target's Z-level is the "main" station floor for the current map.
 *
 * This proc compares the Z-level of the target atom with the main station floor Z-level
 * specified in the map's JSON configuration. If the target's Z-level matches the main floor,
 * it returns TRUE; otherwise, it returns FALSE.
 *
 * @param target The atom whose Z-level is being checked.
 * @return TRUE if the target is on the main station floor, FALSE otherwise.
 */
/datum/controller/subsystem/mapping/proc/is_main_station_floor(atom/target)
	// If main_floor is not specified in the JSON, assume the target is ON the main floor
	if(isnull(current_map.main_floor))
		return TRUE

	// Get the main floor Z-level for the current map
	var/get_main_floor = current_map.main_floor

	// Get the Z-level of the target object
	var/target_z = target.z

	// Get the Z-level associated with the main station floor
	var/list/station_levels = levels_by_trait(ZTRAIT_STATION)

	// Get the Z-level of the main station floor
	var/station_z = station_levels[get_main_floor]

	// Check if the target's Z-level matches the main station floor
	if(target_z == station_z)
		return TRUE
	else
		return FALSE

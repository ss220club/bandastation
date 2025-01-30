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
/proc/main_station_floor(atom/target)
	// Access the current map configuration
	var/datum/map_config/current_map = SSmapping.current_map

	// If main_floors is not specified in the JSON, assume the target is ON the main floor
	if(isnull(current_map.main_floors))
		return TRUE

	// Get the main floor Z-level for the current map
	var/main_floor = current_map.main_floors

	// Get the Z-level of the target object
	var/target_z = target.z

	// Get the Z-level associated with the main station floor
	var/list/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)

	// Get the Z-level of the main station floor
	var/station_z = station_levels[main_floor]

	// Check if the target's Z-level matches the main station floor
	if(target_z == station_z)
		return TRUE
	else
		return FALSE

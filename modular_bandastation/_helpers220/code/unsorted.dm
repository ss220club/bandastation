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

	// Debug: Log the current map name and main_floors value
	to_chat(world, "main_station_floor: Current map = [current_map.map_name], main_floors = [current_map.main_floors]")

	// If main_floors is not specified in the JSON, assume the target is ON the main floor
	if(isnull(current_map.main_floors))
		to_chat(world, "main_station_floor: main_floors is null. Returning TRUE.")
		return TRUE

	// Get the main floor Z-level for the current map
	var/main_floor = current_map.main_floors

	// Get the Z-level of the target object
	var/target_z = target.z
	to_chat(world, "main_station_floor: target_z = [target_z]")

	// Get the Z-level associated with the main station floor
	var/list/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	to_chat(world, "main_station_floor: Station Z-levels = [station_levels]")

	// Check if the main_floor index is valid for the station levels
	if(main_floor < 1 || main_floor > station_levels.len)
		to_chat(world, "main_station_floor: main_floor index [main_floor] is invalid. Returning TRUE.")
		return TRUE // If the main_floor index is invalid, assume the target is on the main floor

	// Get the Z-level of the main station floor
	var/station_z = station_levels[main_floor]
	to_chat(world, "main_station_floor: station_z = [station_z]")

	// Check if the target's Z-level matches the main station floor
	if(target_z == station_z)
		to_chat(world, "main_station_floor: target_z matches station_z. Returning TRUE.")
		return TRUE
	else
		to_chat(world, "main_station_floor: target_z does not match station_z. Returning FALSE.")
		return FALSE

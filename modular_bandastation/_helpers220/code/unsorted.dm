/**
 * Contains maps with more than one floor
 * Sets the ‘main’ floor for the station
 * The floor in the list matches the floor in the StrongDMM
 */
var/static/list/map_to_main_floor = list(
	"Cyberiad" = 2,
	"Ice Box Station" = 3,
	"NebulaStation" = 2,
	"Tramstation" = 2,
	"Wawastation" = 1
)

/// Procedure to check if the current Z-level is the "main" station floor
/proc/main_station_floor(atom/target)
	var/current_map_name = SSmapping.current_map.map_name

	// Skip the check and return TRUE if there is no additional floors on map
	if(isnull(map_to_main_floor[current_map_name]))
		return TRUE

	// Check if the current map exists in the list
	if(current_map_name in map_to_main_floor)
		var/main_floor = map_to_main_floor[current_map_name]

		// Get the Z-level of the target object
		var/target_z = target.z

		// Get the Z-level associated with the main station floor
		var/station_z = SSmapping.levels_by_trait(ZTRAIT_STATION)[main_floor]

		// Check if the target's Z-level matches the main station floor
		if(target_z == station_z)
			return TRUE
		else
			return FALSE
	else
		return FALSE

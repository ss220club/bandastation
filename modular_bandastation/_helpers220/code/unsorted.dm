/// List to store information about Z-levels and their association with maps
var/static/list/map_to_main_floor = list(
	"Cyberiad" = 2,
	"Ice Box Station" = 3,
	"DeltaStation" = 1,
	"MetaStation" = 1,
)

/// Procedure to check if the current Z-level is the "main" station floor
/proc/main_station_floor(atom/target)
	var/current_map_name = SSmapping.current_map.map_name

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

// TODO: Delete this tool after all tests
/obj/item/debug_tool
	name = "Debug Tool"
	desc = "A tool to check if you are on the main station floor."
	icon = 'icons/obj/food/lollipop.dmi'
	icon_state = "lollipop"

/obj/item/debug_tool/attack_self(mob/user)
	var/current_floor = user.z - 1
	to_chat(user, span_notice("You are on floor: [current_floor]."))

	var/current_map_name = SSmapping.current_map.map_name
	var/main_floor_z = map_to_main_floor[current_map_name]

	if(isnull(main_floor_z))
		to_chat(user, span_warning("Current map [current_map_name] is not in the map_to_main_floor list!"))
		return

	var/actual_main_floor = map_to_main_floor[current_map_name]
	to_chat(user, span_notice("Current map: [current_map_name]"))
	to_chat(user, span_notice("Main floor for this map: Z-level [actual_main_floor]"))
	to_chat(user, span_notice("Your current z-level: [current_floor]"))

	var/is_main_floor = main_station_floor(user)
	if(is_main_floor)
		to_chat(user, span_boldnotice("You are on the main station floor."))
	else
		to_chat(user, span_boldwarning("You are NOT on the main station floor."))

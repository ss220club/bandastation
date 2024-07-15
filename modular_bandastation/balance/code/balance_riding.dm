#define TG_SPEED 1.5

/datum/component/riding/Initialize(mob/living/riding_mob, force, buckle_mob_flags, potion_boost)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	if(vehicle_move_delay == 0)
		vehicle_move_delay = max(CONFIG_GET(number/movedelay/run_delay) - TG_SPEED, 0) * TG_SPEED
		return
	vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) / TG_SPEED * vehicle_move_delay, 0.01)

#undef TG_SPEED

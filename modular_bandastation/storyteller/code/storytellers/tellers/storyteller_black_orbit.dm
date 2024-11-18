/datum/storyteller/black_orbit
	name = "Black Orbit"
	desc = "Black Orbit exist only for one purpose. To make you suffer."
	welcome_text = "Suffer, b*tch!"

	event_repetition_multiplier = 0.1

	track_data = /datum/storyteller_data/tracks/black_orbit

	guarantees_roundstart_crewset = FALSE
	antag_divisor = 100 //Чтобы было больше антагов
	population_min = 10

	tag_multipliers = list(
		TAG_COMBAT = 10,
		TAG_DESTRUCTIVE = 10,
		TAG_CHAOTIC = 10
	)
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller_data/tracks/black_orbit
	threshold_mundane = 12000000
	threshold_moderate = 18000000
	threshold_major = 80000000
	threshold_crewset = 30000000
	threshold_ghostset = 80000000

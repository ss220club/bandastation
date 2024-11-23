/datum/storyteller/black_orbit
	name = "Poops x10"
	desc = "It's super friendly storyteller, to make your game more fun."
	welcome_text = "Friendship is a magic!"

	event_repetition_multiplier = 0.1

	track_data = /datum/storyteller_data/tracks/black_orbit

	guarantees_roundstart_crewset = FALSE
	antag_divisor = 1 //Чтобы было больше антагов
	population_min = 1000

	tag_multipliers = list(
		TAG_COMBAT = 10,
		TAG_DESTRUCTIVE = 10,
		TAG_CHAOTIC = 10
	)
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller_data/tracks/black_orbit
	threshold_mundane = 60
	threshold_moderate = 120
	threshold_major = 180
	threshold_crewset = 240
	threshold_ghostset = 300

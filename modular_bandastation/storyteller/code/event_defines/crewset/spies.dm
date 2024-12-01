/datum/round_event_control/antagonist/solo/spy
	name = "Spies"
	roundstart = TRUE
	earliest_start = 1 MINUTES

	antag_flag = ROLE_SPY
	antag_datum = /datum/antagonist/spy
	weight = 0
	maximum_antags_global = 4
	category = EVENT_CATEGORY_INVASION
	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/spy/midround
	name = "Spies (Midround)"
	roundstart = FALSE

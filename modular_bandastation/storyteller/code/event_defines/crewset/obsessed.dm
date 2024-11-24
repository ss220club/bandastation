/datum/round_event_control/antagonist/solo/obsessed
	name = "Obseesed"
	roundstart = TRUE

	antag_flag = ROLE_OBSESSED
	antag_datum = /datum/antagonist/obsessed
	weight = 10
	maximum_antags_global = 4
	category = EVENT_CATEGORY_INVASION
	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/obsessed/midround
	name = "Yandere (Obseesed)"
	roundstart = FALSE

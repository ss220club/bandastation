/datum/round_event_control/antagonist/solo/changeling
	name = "Changelings"
	roundstart = 1.9
	earliest_start = 0 SECONDS

	antag_flag = ROLE_CHANGELING
	antag_datum = /datum/antagonist/changeling
	weight = 8
	min_players = 20
	maximum_antags_global = 4
	category = EVENT_CATEGORY_INVASION
	tags = list(TAG_COMBAT, TAG_CREW_ANTAG)
	protected_roles = list()

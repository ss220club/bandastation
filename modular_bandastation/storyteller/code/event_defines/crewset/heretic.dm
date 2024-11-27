/datum/round_event_control/antagonist/solo/heretic
	name = "Heretics"
	roundstart = 20

	antag_flag = ROLE_HERETIC
	antag_datum = /datum/antagonist/heretic
	weight = 3
	min_players = 30

	maximum_antags_global = 2
	category = EVENT_CATEGORY_INVASION
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/heretic/New()
	protected_roles |= JOB_CHAPLAIN // Would be silly to get chaplain heretics
	. = ..()

/datum/round_event_control/antagonist/solo/heretic/midround
	name = "Midround Heretics"
	roundstart = FALSE

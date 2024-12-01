/datum/round_event_control/antagonist/solo/blood_brothers
	name = "Blood Brother"
	roundstart = 1
	earliest_start = 0 SECONDS

	track = EVENT_TRACK_CREWSET
	antag_flag = ROLE_BROTHER
	antag_datum = /datum/antagonist/brother

	weight = 6
	tags = list(TAG_CREW_ANTAG, TAG_COMMUNAL)

	base_antags = 1
	maximum_antags_global = 4

	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)

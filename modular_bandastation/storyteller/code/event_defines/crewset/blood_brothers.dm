/datum/round_event_control/antagonist/team/blood_brothers
	name = "Blood Brother"
	roundstart = TRUE
	track = EVENT_TRACK_CREWSET
	antag_flag = ROLE_BROTHER
	antag_datum = /datum/antagonist/brother

	weight = 6
	tags = list(TAG_CREW_ANTAG, TAG_COMMUNAL)

	base_antags = 2
	minimum_candidate_base = 2
	maximum_antags_global = 6

	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)

/datum/round_event/antagonist/team/blood_brothers
	var/required_role = ROLE_BROTHER

	var/datum/team/brother_team/brother_team

/datum/round_event/antagonist/team/blood_brothers/candidate_roles_setup(mob/candidate)
	candidate.mind.special_role = required_role

/datum/round_event/antagonist/team/blood_brothers/start()
	for(var/datum/mind/assigned_player in setup_minds)
		add_datum_to_mind(assigned_player, brother_team)
	return TRUE

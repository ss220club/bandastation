/datum/round_event_control/antagonist/team/Cult
	name = "Cult"
	roundstart = 20
	track = EVENT_TRACK_CREWSET
	antag_flag = ROLE_CULTIST
	antag_datum = /datum/antagonist/cult

	weight = 6
	tags = list(TAG_CREW_ANTAG, TAG_CHAOTIC, TAG_COMBAT)

	base_antags = 3
	maximum_antags = 6
	maximum_antags_global = 6
	min_players = 40

	restricted_roles = list(
			JOB_AI,
			JOB_CAPTAIN,
			JOB_CHAPLAIN,
			JOB_CYBORG,
			JOB_DETECTIVE,
			JOB_HEAD_OF_PERSONNEL,
			JOB_HEAD_OF_SECURITY,
			JOB_PRISONER,
			JOB_SECURITY_OFFICER,
			JOB_WARDEN,
		)

	category = EVENT_CATEGORY_INVASION

/datum/round_event/antagonist/team/cult
	var/required_role = ROLE_CULTIST

	var/datum/team/nuclear/nuke_team

/datum/round_event/antagonist/team/cult/candidate_roles_setup(mob/candidate)
	candidate.mind.special_role = required_role

/datum/round_event/antagonist/team/cult/start()
	// Setup everyone else
	for(var/datum/mind/assigned_player in setup_minds)
		add_datum_to_mind(assigned_player)
	return TRUE

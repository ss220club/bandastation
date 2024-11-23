/datum/round_event_control/antagonist/team/revolution
	name = "revolution"
	roundstart = TRUE
	track = EVENT_TRACK_MAJOR
	antag_flag = ROLE_REV
	antag_datum = /datum/antagonist/rev/
	antag_leader_datum = /datum/antagonist/rev/head

	weight = 0
	tags = list(TAG_CREW_ANTAG, TAG_COMMUNAL)

	base_antags = 3
	maximum_antags_global = 6
	min_players = 40

	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)

	typepath = /datum/team/revolution

/datum/round_event/antagonist/team/revolution
	var/datum/job/job_type = /datum/job/clown_operative
	var/required_role = ROLE_REV

	var/datum/team/revolution/rev_team

/datum/round_event/antagonist/team/revolution/candidate_roles_setup(mob/candidate)
	candidate.mind.set_assigned_role(SSjob.get_job_type(job_type))
	candidate.mind.special_role = required_role

/datum/round_event/antagonist/team/revolution/start()
	// Get our nukie leader
	var/datum/mind/most_experienced = get_most_experienced(setup_minds, required_role)
	if(!most_experienced)
		most_experienced = setup_minds[1]
	var/datum/antagonist/rev/head/leader = most_experienced.add_antag_datum(antag_leader_datum)
	rev_team = leader.rev_team

	// Setup everyone else
	for(var/datum/mind/assigned_player in setup_minds)
		if(assigned_player == most_experienced)
			continue
		add_datum_to_mind(assigned_player)
	return TRUE

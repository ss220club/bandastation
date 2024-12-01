/datum/round_event_control/antagonist/team/clown_ops
	name = "Clown Operatives"
	roundstart = TRUE

	track = EVENT_TRACK_CREWSET
	antag_flag = ROLE_CLOWN_OPERATIVE
	antag_datum = /datum/antagonist/nukeop/clownop
	antag_leader_datum = /datum/antagonist/nukeop/leader/clownop

	weight = 0
	tags = list(TAG_CREW_ANTAG, TAG_CHAOTIC)

	base_antags = 2
	maximum_antags = 5
	maximum_antags_global = 5
	min_players = 40

	typepath = /datum/round_event/antagonist/team/clown_ops

	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_NUKIEBASE)
	category = EVENT_CATEGORY_INVASION

/datum/round_event/antagonist/team/clown_ops
	var/datum/job/job_type = /datum/job/clown_operative
	var/required_role = ROLE_NUCLEAR_OPERATIVE

	var/datum/team/nuclear/nuke_team

/datum/round_event/antagonist/team/clown_ops/candidate_roles_setup(mob/candidate)
	candidate.mind.set_assigned_role(SSjob.get_job_type(job_type))
	candidate.mind.special_role = required_role

/datum/round_event/antagonist/team/clown_ops/start()
	// Get our nukie leader
	var/datum/mind/most_experienced = get_most_experienced(setup_minds, required_role)
	if(!most_experienced)
		most_experienced = setup_minds[1]
	var/datum/antagonist/nukeop/leader/leader = most_experienced.add_antag_datum(antag_leader_datum)
	nuke_team = leader.nuke_team

	// Setup everyone else
	for(var/datum/mind/assigned_player in setup_minds)
		if(assigned_player == most_experienced)
			continue
		add_datum_to_mind(assigned_player)
	return TRUE

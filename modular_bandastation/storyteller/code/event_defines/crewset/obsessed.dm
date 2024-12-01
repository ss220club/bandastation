/datum/round_event_control/antagonist/solo/obsessed
	name = "Obseesed"
	roundstart = FALSE

	antag_flag = ROLE_OBSESSED
	antag_datum = /datum/antagonist/obsessed
	weight = 10
	maximum_antags_global = 4
	typepath = /datum/round_event/antagonist/solo/obsessed
	category = EVENT_CATEGORY_INVASION
	tags = list(TAG_CREW_ANTAG)
	protected_roles = list()

/datum/round_event/antagonist/solo/obsessed/start()
	var/datum/round_event_control/antagonist/re_control = control
	var/candidate_list = re_control.get_candidates()
	var/mob/living/carbon/human/obsessed = pick_n_take(candidate_list)
	obsessed.gain_trauma(/datum/brain_trauma/special/obsessed)

/datum/round_event/antagonist/solo/obsessed/candidate_setup(datum/round_event_control/antagonist/cast_control)
	return

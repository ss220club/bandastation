/**
 * Job antagonist restriction file
 *
 * Add relative restrictions to any jobs that you wish to prevent from being
 * an antagonist. If you set antagonist_restricted to true without setting restricted_antagonist,
 * then the job will be restricted from all antagonists.
 */

/datum/job
	/// Do we allow this job to be an antag of any kind?
	var/antagonist_restricted = FALSE
	/// If we restrict this job from antagonists, what antags? Leave blank for all antags.
	var/list/restricted_antagonists

/datum/job/head_of_personnel
	antagonist_restricted = TRUE

/datum/job/chief_engineer
	antagonist_restricted = TRUE

/datum/job/chief_medical_officer
	antagonist_restricted = TRUE

/datum/job/research_director
	antagonist_restricted = TRUE

/datum/job/quartermaster
	antagonist_restricted = TRUE

/*
/datum/job/nanotrasen_consultant
	antagonist_restricted = TRUE

/datum/job/blueshield
	antagonist_restricted = TRUE

/datum/job/corrections_officer
	antagonist_restricted = TRUE

/datum/job/orderly
	antagonist_restricted = TRUE

/datum/job/bouncer
	antagonist_restricted = TRUE

/datum/job/customs_agent
	antagonist_restricted = TRUE

/datum/job/engineering_guard
	antagonist_restricted = TRUE

/datum/job/science_guard
	antagonist_restricted = TRUE
*/

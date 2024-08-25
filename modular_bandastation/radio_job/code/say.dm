GLOBAL_LIST_INIT(department_span_by_assignment, list(
	"servradio" = list(
		JOB_HEAD_OF_PERSONNEL_RU,
		JOB_BARTENDER_RU,
		JOB_CHEF_RU,
		JOB_COOK_RU,
		JOB_BOTANIST_RU,
		JOB_CURATOR_RU,
		JOB_CHAPLAIN_RU,
		JOB_CLOWN_RU,
		JOB_MIME_RU,
		JOB_JANITOR_RU,
		JOB_LAWYER_RU,
		JOB_PSYCHOLOGIST_RU
	),
	"secradio" = list(
		JOB_HEAD_OF_SECURITY_RU,
		JOB_WARDEN_RU,
		JOB_SECURITY_OFFICER_RU,
		JOB_SECURITY_OFFICER_MEDICAL_RU,
		JOB_SECURITY_OFFICER_ENGINEERING_RU,
		JOB_SECURITY_OFFICER_SCIENCE_RU,
		JOB_SECURITY_OFFICER_SUPPLY_RU,
		JOB_DETECTIVE_RU,
		JOB_VETERAN_ADVISOR_RU
	),
	"comradio" = list(
		JOB_CAPTAIN_RU,
		JOB_BRIDGE_ASSISTANT_RU
	),
	"sciradio" = list(
		JOB_RESEARCH_DIRECTOR_RU,
		JOB_SCIENTIST_RU,
		JOB_ROBOTICIST_RU,
		JOB_GENETICIST_RU
	),
	"suppradio" = list(
		JOB_QUARTERMASTER_RU,
		JOB_SHAFT_MINER_RU,
		JOB_CARGO_TECHNICIAN_RU,
		JOB_BITRUNNER_RU,
		JOB_CARGO_GORILLA_RU
	),
	"aiprivradio" = list(
		JOB_AI_RU,
		JOB_CYBORG_RU,
		JOB_PERSONAL_AI_RU,
		JOB_HUMAN_AI_RU
	),
	"engradio" = list(
		JOB_CHIEF_ENGINEER_RU,
		JOB_STATION_ENGINEER_RU,
		JOB_ATMOSPHERIC_TECHNICIAN_RU
	),
	"medradio" = list(
		JOB_CHIEF_MEDICAL_OFFICER_RU,
		JOB_CHEMIST_RU,
		JOB_MEDICAL_DOCTOR_RU,
		JOB_PARAMEDIC_RU,
		JOB_CORONER_RU
	)/*,
	"centcomradio" = list(
		JOB_CENTCOM_ADMIRAL_RU,
		JOB_CENTCOM_RU,
		JOB_CENTCOM_OFFICIAL_RU,
		JOB_CENTCOM_COMMANDER_RU,
		JOB_CENTCOM_BARTENDER_RU,
		JOB_CENTCOM_CUSTODIAN_RU,
		JOB_CENTCOM_MEDICAL_DOCTOR_RU,
		JOB_CENTCOM_RESEARCH_OFFICER_RU,		// not translated
		JOB_ERT_COMMANDER_RU,
		JOB_ERT_OFFICER_RU,
		JOB_ERT_ENGINEER_RU,
		JOB_ERT_MEDICAL_DOCTOR_RU,
		JOB_ERT_CLOWN_RU,
		JOB_ERT_CHAPLAIN_RU,
		JOB_ERT_JANITOR_RU,
		JOB_ERT_DEATHSQUAD_RU
	)
	*/
))

/proc/get_department_span(assignment)
	for(var/dep_span in GLOB.department_span_by_assignment)
		for(var/i in 1 to length(GLOB.department_span_by_assignment[dep_span]))
			if(assignment == GLOB.department_span_by_assignment[dep_span][i])
				return dep_span
	return "radio"

/atom/movable/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	var/mob/living/carbon/human/H = usr
	if(!H?.get_assignment() || !radio_freq)
		return ""
	var/assignment = H?.get_assignment(if_no_id = "Неизвестный", if_no_job = "Неизвестный", hand_first = FALSE)
	return "<span class='[get_department_span(assignment)]'><small>" + @"[" + assignment + @"]</small> "

/atom/movable/proc/job_end_span()
	if(compose_job() == "")
		return ""
	return "</span>"

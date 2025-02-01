/datum/id_trim/job/brigmed
	assignment = JOB_BRIGMED
	trim_icon = 'modular_bandastation/jobs/icons/obj/card.dmi'
	trim_state = "trim_brigmed"
	department_color = COLOR_SECURITY_RED
	subdepartment_color = "#ff0000"
	sechud_icon_state = SECHUD_BRIGMED
	minimal_access = list(
		ACCESS_BRIG,
		ACCESS_SECURITY,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_EVA,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MEDICAL,
		ACCESS_MORGUE,
		ACCESS_PHARMACY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_BRIGMED,
	)
	job = /datum/job/brigmed

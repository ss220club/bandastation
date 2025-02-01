/datum/job/brigmed
	title = JOB_BRIGMED
	description = "Лечение преступников и офицеров СБ."
	department_head = list("Глава службы безопасности")
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 0
	supervisors = "Глава службы безопасности"
	minimal_player_age = 7
	exp_requirements = 1500
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_MEDICAL
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BRIGMED"

	outfit = /datum/outfit/job/brigmed
	plasmaman_outfit = /datum/outfit/plasmaman/brigmed

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_MEDICAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_BRIGMED
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/medical,
	)

	family_heirlooms = list(/obj/item/clothing/neck/stethoscope)

	mail_goodies = list(
		/obj/effect/spawner/random/medical/organs = 5,
		/obj/item/clothing/neck/stethoscope = 2,
		/obj/item/scalpel/advanced = 6,
		/obj/item/retractor/advanced = 6,
		/obj/item/cautery/advanced = 6,
		/obj/item/reagent_containers/pill/patch/libital = 5,
		/obj/item/reagent_containers/pill/patch/aiuri = 5,
	)

	rpg_title = "staff-medical"
	job_flags = STATION_JOB_FLAGS | JOB_CANNOT_OPEN_SLOTS

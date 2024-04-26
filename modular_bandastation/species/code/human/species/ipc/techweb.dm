/datum/techweb_node/ipc_parts
	id = "ipc_parts"
	display_name = "I.P.C Repair Parts"
	description = "Through purchasing licenses to print IPC Parts, we can rebuild our silicon friends, no, not those silicon friends."
	prereq_ids = list("robotics")
	design_ids = list(
		"ipc_head",
		"ipc_chest",
		"ipc_arm_left",
		"ipc_arm_right",
		"ipc_leg_left",
		"ipc_leg_right"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

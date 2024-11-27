/area/centcom/syndicate_base
	name = "Syndicate Forward Base"
	icon = 'modular_bandastation/mapping/icons/areas/areas_centcom.dmi'
	icon_state = "syndie-ship"
	static_lighting = FALSE
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | NOTELEPORT
	flags_1 = NONE
	ambience_index = AMBIENCE_DANGER

/area/centcom/syndicate_base/outside
	name = "Syndicate Controlled Territory"
	icon_state = "syndie-outside"
	static_lighting = TRUE

/area/centcom/syndicate_base/control
	name = "Syndicate Control Room"
	icon_state = "syndie-control"

/area/centcom/syndicate_base/elite_squad
	name = "Syndicate Elite Squad"
	icon_state = "syndie-elite"

/area/centcom/syndicate_base/infteam
	name = "Syndicate Infiltrators"
	icon_state = "syndie-infiltrator"

/area/centcom/syndicate_base/jail
	name = "Syndicate Jail"
	icon_state = "syndie-jail"

/area/centcom/syndicate_base/cargo
	name = "Syndicate Cargo"
	icon_state = "syndie-cargo"
	ambience_index = AMBIENCE_ENGI


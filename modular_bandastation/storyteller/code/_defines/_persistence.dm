/datum/controller/subsystem/persistence
	var/last_storyteller_type = ""

/datum/controller/subsystem/persistence/Initialize()
	. = ..()
	load_storyteller_type()
	return .

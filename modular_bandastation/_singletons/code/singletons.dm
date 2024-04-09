/singleton
	var/abstract_type = /singleton

/singleton/proc/Initialize()
	SHOULD_CALL_PARENT(TRUE)
	SHOULD_NOT_SLEEP(TRUE)

/singleton/Destroy()
	SHOULD_CALL_PARENT(FALSE)
	. = QDEL_HINT_LETMELIVE
	CRASH("Prevented attempt to delete a singleton instance: [src]")

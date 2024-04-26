/datum/modpack/species
	/// A string name for the modpack. Used for looking up other modpacks in init.
	name = "Species Modpack"
	/// A string desc for the modpack. Can be used for modpack verb list as description.
	desc = "Дополнительные расы."
	/// A string with authors of this modpack.
	author = "PhantomRU"

/datum/modpack/species/pre_initialize()
	. = ..()

/datum/modpack/species/initialize()
	. = ..()

	GLOB.phobia_species["aliens"] |= typecacheof(list(
		/datum/species/oozeling
		))
	GLOB.phobia_species["robots"] |= typecacheof(list(
		/datum/species/ipc
		))

/datum/modpack/species/post_initialize()
	. = ..()


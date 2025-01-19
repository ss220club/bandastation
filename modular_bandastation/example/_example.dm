/datum/modpack/example
	/// A string name for the modpack. Used for looking up other modpacks in init.
	name = "Example name"
	/// A string desc for the modpack. Can be used for modpack verb list as description.
	desc = "Example desc"
	/// A string with authors of this modpack.
	author = "furior"

/datum/modpack/example/pre_initialize()
	. = ..()

/datum/modpack/example/initialize()
	. = ..()

/datum/modpack/example/post_initialize()
	. = ..()

/datum/modpack/example
	/// A string name for the modpack. Used for looking up other modpacks in init
	name = "Example"
	/// A string desc for the modpack. Can be used for modpack verb list as description
	desc = ""
	/// A string with authors of this modpack
	author = ""

/// If you don't know what this is for or you don't need it - remove it
/datum/modpack/example/pre_initialize()
	. = ..()

/// If you don't know what this is for or you don't need it - remove it
/datum/modpack/example/initialize()
	. = ..()

/// If you don't know what this is for or you don't need it - remove it
/datum/modpack/example/post_initialize()
	. = ..()

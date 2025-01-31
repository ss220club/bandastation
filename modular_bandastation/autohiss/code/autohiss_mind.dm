/datum/mind
	/// List of tongues which the mind will prevent from using speechmod (Auto-hiss)
	var/list/autohiss_disabled_types = list()

/datum/mind/proc/toggle_autohiss(obj/item/organ/tongue/tongue)
	if(tongue::type in autohiss_disabled_types)
		autohiss_disabled_types -= tongue::type
		to_chat(src, span_notice("Вы включили автошипение для языков типа [declent_ru_initial(tongue::name, declent = GENITIVE, override_backup = tongue::name)]."))
		return
	autohiss_disabled_types += tongue::type
	to_chat(src, span_notice("Вы отключили автошипение для языков типа [declent_ru_initial(tongue::name, declent = GENITIVE, override_backup = tongue::name)]."))

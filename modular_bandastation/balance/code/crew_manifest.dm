/datum/computer_file/program/crew_manifest
	download_access = SSid_access.get_flag_access_list(ACCESS_FLAG_COMMON)
	downloader_category = PROGRAM_CATEGORY_DEVICE

/obj/item/modular_computer/pda/install_default_programs()
	starting_programs |= /datum/computer_file/program/crew_manifest
	. = ..()

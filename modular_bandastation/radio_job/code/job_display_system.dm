GLOBAL_VAR_INIT(job_display_style, "none")

// Board and techweb
/datum/design/board/job_display_system
	name = "Job Display System Board"
	desc = "The circuit board for a job display system."
	id = "job_display_system"
	build_path = /obj/item/circuitboard/machine/job_display_system
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/obj/item/circuitboard/machine/job_display_system
	name = "Job Display System"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/job_display_system
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 1)

/datum/techweb_node/consoles/New()
	. = ..()
	design_ids += "job_display_system"

// Tech storage spawn
/obj/effect/spawner/random/techstorage/tcomms_all/spawn_loot()
	loot |= list(/obj/item/circuitboard/machine/job_display_system)
	. = ..()

// machine
/obj/machinery/job_display_system
	density = TRUE
	name = "\improper Job Display System"
	desc = "A job display system that handles job display over the radio."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "AAS_On"
	base_icon_state = "AAS"
	var/displayStyle = "Отсутствует (Имя)"

	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.05

	circuit = /obj/item/circuitboard/machine/job_display_system

/obj/machinery/job_display_system/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/job_display_system/update_icon_state()
	icon_state = "[base_icon_state]_[is_operational ? "On" : "Off"][panel_open ? "_Open" : null]"
	return ..()

/obj/machinery/job_display_system/Destroy()
	displayStyle = "Отсутствует (Имя)"
	GLOB.job_display_style = "none"
	return ..()

/obj/machinery/job_display_system/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	toggle_panel_open()
	to_chat(user, span_notice("You [panel_open ? "open" : "close"] the maintenance hatch of [src]."))
	update_appearance()
	return TRUE

/obj/machinery/job_display_system/crowbar_act(mob/living/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return TRUE

/obj/machinery/job_display_system/on_set_is_operational(old_value)
	if(!is_operational)
		displayStyle = "Отсутствует (Имя)"
		GLOB.job_display_style = "none"

/obj/machinery/job_display_system/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "JobDisplay")
		ui.open()

/obj/machinery/job_display_system/ui_data()
	var/list/data = list()
	data["displayStyle"] = displayStyle
	return data

/obj/machinery/job_display_system/ui_act(action, param)
	. = ..()
	if(.)
		return
	if(!usr.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	if(machine_stat & BROKEN)
		visible_message(span_warning("[src] buzzes."), span_hear("You hear a faint buzz."))
		playsound(src.loc, 'sound/machines/buzz-two.ogg', 50, TRUE)
		return
	switch(action)
		if("changeStyle")
			displayStyle = param["displayStyle"]
			if(displayStyle == "Отсутствует (Имя)")
				GLOB.job_display_style = "none"
			else if(displayStyle == @"По умолчанию ([Работа] Имя)")
				GLOB.job_display_style = "default"
			else if(displayStyle == "Альтернативный (Имя (Работа))")
				GLOB.job_display_style = "alternative"
			else if(displayStyle == "Альтернативный 2 (Имя - Работа)")
				GLOB.job_display_style = "alternative2"

			usr.log_message("updated the job display style to: [displayStyle]", LOG_GAME)
	add_fingerprint(usr)

/obj/machinery/job_display_system/attack_robot(mob/living/silicon/user)
	. = attack_ai(user)

/obj/machinery/job_display_system/attack_ai(mob/user)
	if(!user.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	interact(user)

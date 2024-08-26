GLOBAL_VAR_INIT(job_display_style, "none")

/obj/machinery/job_display_system
	density = TRUE
	name = "\improper Job Display System"
	desc = "A job display system that handles job display over the radio."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "AAS_On"
	base_icon_state = "AAS"
	var/displayStyle = "Отсутствует (Имя)"

	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.05

	// circuit = /obj/item/circuitboard/machine/job_display_system

/obj/machinery/job_display_system/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/announcement_system/randomize_language_if_on_station()
	return

/obj/machinery/announcement_system/update_icon_state()
	icon_state = "[base_icon_state]_[is_operational ? "On" : "Off"][panel_open ? "_Open" : null]"
	return ..()

/obj/machinery/job_display_system/Destroy()
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

			usr.log_message("updated the job display style to: [param["displayStyle"]]", LOG_GAME)
	add_fingerprint(usr)

/obj/machinery/job_display_system/attack_robot(mob/living/silicon/user)
	. = attack_ai(user)

/obj/machinery/job_display_system/attack_ai(mob/user)
	if(!user.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src]'s firmware appears to be malfunctioning!"))
		return
	interact(user)

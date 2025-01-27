GLOBAL_VAR_INIT(ert_request_answered, FALSE)
GLOBAL_LIST_EMPTY(ert_request_messages)

ADMIN_VERB(ert_manager, R_NONE, "ERT Manager", "Manage ERT reqests.", ADMIN_CATEGORY_GAME)
	var/datum/ert_manager/tgui = new(user)
	tgui.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("ERT Manager")

/datum/ert_manager
	var/name = "ERT Manager"
	var/ert_type = "Red"
	var/commander_slots = 1 // defaults for open slots
	var/security_slots = 4
	var/medical_slots = 0
	var/engineering_slots = 0
	var/janitor_slots = 0
	var/paranormal_slots = 0

/datum/ert_manager/ui_state(mob/user)
	return GLOB.admin_state

/datum/ert_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ERTManager", name)
		ui.autoupdate = TRUE
		ui.open()

/datum/ert_manager/ui_data(mob/user)
	var/list/data = list()
	data["securityLevel"] = capitalize(SSsecurity_level.get_current_level_as_text())
	data["securityLevelColor"] = SSsecurity_level.current_security_level.announcement_color
	data["ertRequestAnswered"] = GLOB.ert_request_answered
	data["ertType"] = ert_type
	data["commanderSlots"] = commander_slots
	data["securitySlots"] = security_slots
	data["medicalSlots"] = medical_slots
	data["engineeringSlots"] = engineering_slots
	data["janitorSlots"] = janitor_slots
	data["paranormalSlots"] = paranormal_slots
	data["totalSlots"] = commander_slots + security_slots + medical_slots + engineering_slots + janitor_slots + paranormal_slots
	data["ertSpawnpoints"] = length(GLOB.emergencyresponseteamspawn)

	data["ertRequestMessages"] = GLOB.ert_request_messages
	return data

/datum/ert_manager/ui_act(action, params, datum/tgui/ui)
	if(..())
		return
	. = TRUE
	switch(action)
		if("toggleErtRequestAnswered")
			GLOB.ert_request_answered = !GLOB.ert_request_answered
		if("ertType")
			ert_type = params["ertType"]
		if("toggleCom")
			commander_slots = commander_slots ? 0 : 1
		if("setSec")
			security_slots = text2num(params["setSec"])
		if("setMed")
			medical_slots = text2num(params["setMed"])
		if("setEng")
			engineering_slots = text2num(params["setEng"])
		if("setJan")
			janitor_slots = text2num(params["setJan"])
		if("setPar")
			paranormal_slots = text2num(params["setPar"])
		if("dispatchErt")
			var/datum/ert/new_ert
			switch(ert_type)
				if("Blue")
					new_ert = new /datum/ert/blue
				if("Red")
					new_ert = new /datum/ert/red
				if("Gamma")
					new_ert = new /datum/ert/gamma
				else
					to_chat(usr, "<span class='userdanger'>Invalid ERT type.</span>")
					return
			GLOB.ert_request_answered = TRUE
			var/slots_list = list()
			if(commander_slots > 0)
				slots_list += "commander: [commander_slots]"
			if(security_slots > 0)
				slots_list += "security: [security_slots]"
			if(medical_slots > 0)
				slots_list += "medical: [medical_slots]"
			if(engineering_slots > 0)
				slots_list += "engineering: [engineering_slots]"
			if(janitor_slots > 0)
				slots_list += "janitor: [janitor_slots]"
			if(paranormal_slots > 0)
				slots_list += "paranormal: [paranormal_slots]"

			var/slot_text = english_list(slots_list)
			notify_ghosts("An ERT is being dispatched. Type: [ert_type]. Open positions: [slot_text]")
			message_admins("[key_name_admin(usr)] dispatched a [ert_type] ERT. Slots: [slot_text]", 1)
			log_admin("[key_name(usr)] dispatched a [ert_type] ERT. Slots: [slot_text]")
			priority_announce("Attention, [station_name()]. We are attempting to assemble an ERT. Standby.", "ERT Protocol Activated")
			message_admins("[new_ert], [commander_slots], [security_slots], [medical_slots], [engineering_slots], [janitor_slots], [paranormal_slots]")
			// trigger_armed_response_team(new_ert, commander_slots, security_slots, medical_slots, engineering_slots, janitor_slots, paranormal_slots)

		if("view_player_panel")
			SSadmin_verbs.dynamic_invoke_verb(usr, /datum/admin_verb/show_player_panel, locate(params["uid"]))

		if("denyErt")
			GLOB.ert_request_answered = TRUE
			var/message = "[station_name()], we are unfortunately unable to send you an Emergency Response Team at this time."
			if(params["reason"])
				message += " Your ERT request has been denied for the following reasons:\n\n[params["reason"]]"
			priority_announce(message, "ERT Unavailable")
		else
			return FALSE

/datum/ert/gamma


/// If we spawn an ERT with the "choose experienced leader" option, select the leader from the top X playtimes
#define ERT_EXPERIENCED_LEADER_CHOOSE_TOP 3

///Dummy mob reserve slot for admin use
#define DUMMY_HUMAN_SLOT_ADMIN "admintools"

GLOBAL_VAR_INIT(ert_request_answered, FALSE)
GLOBAL_LIST_EMPTY(ert_request_messages)

ADMIN_VERB(ert_manager, R_NONE, "ERT Manager", "Manage ERT reqests.", ADMIN_CATEGORY_GAME)
	var/datum/ert_manager/tgui = new(user)
	tgui.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("ERT Manager")

/datum/ert_manager
	var/name = "ERT Manager"
	var/ert_type = "Red"
	var/admin_slots = 0 // default
	var/commander_slots = 1 // defaults for open slots
	var/security_slots = 0
	var/medical_slots = 0
	var/engineering_slots = 0
	var/janitor_slots = 0
	var/inquisitor_slots = 0

/datum/ert_manager/ui_state(mob/user)
	return GLOB.admin_state

/datum/ert_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ErtManager", name)
		ui.autoupdate = TRUE
		ui.open()

/datum/ert_manager/ui_data(mob/user)
	var/list/data = list()
	data["securityLevel"] = capitalize(SSsecurity_level.get_current_level_as_text())
	data["securityLevelColor"] = SSsecurity_level.current_security_level.announcement_color
	data["ertRequestAnswered"] = GLOB.ert_request_answered
	data["ertType"] = ert_type
	data["adminSlots"] = admin_slots
	data["commanderSlots"] = commander_slots
	data["securitySlots"] = security_slots
	data["medicalSlots"] = medical_slots
	data["engineeringSlots"] = engineering_slots
	data["janitorSlots"] = janitor_slots
	data["inquisitorSlots"] = inquisitor_slots
	data["totalSlots"] = commander_slots + security_slots + medical_slots + engineering_slots + janitor_slots + inquisitor_slots
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
		if("toggleAdmin")
			admin_slots = admin_slots ? 0 : 1
		// if("toggleCom")
		// 	commander_slots = commander_slots ? 0 : 1	no can do sir, leader must be
		if("setSec")
			security_slots = text2num(params["setSec"])
		if("setMed")
			medical_slots = text2num(params["setMed"])
		if("setEng")
			engineering_slots = text2num(params["setEng"])
		if("setJan")
			janitor_slots = text2num(params["setJan"])
		if("setInq")
			inquisitor_slots = text2num(params["setInq"])
		if("dispatchErt")
			var/datum/ert/new_ert
			switch(ert_type)
				if("Amber")
					new_ert = new /datum/ert/amber
				if("Red")
					new_ert = new /datum/ert/red
				if("Gamma")
					new_ert = new /datum/ert/gamma
				else
					to_chat(usr, "<span class='userdanger'>Invalid ERT type.</span>")
					return

			new_ert.teamsize = commander_slots + security_slots + medical_slots + engineering_slots + janitor_slots + inquisitor_slots
			new_ert.roles = slots_to_roles(security_slots, medical_slots, engineering_slots, janitor_slots, inquisitor_slots, ert_type)

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
			if(inquisitor_slots > 0)
				slots_list += "inquisitor: [inquisitor_slots]"

			var/slot_text = english_list(slots_list)
			message_admins("[key_name_admin(usr)] dispatched a [ert_type] ERT. Slots: [slot_text]")
			log_admin("[key_name(usr)] dispatched a [ert_type] ERT. Slots: [slot_text]")
			priority_announce("Attention, [station_name()]. We are attempting to assemble an ERT. Standby.", "ERT Protocol Activated")
			makeERTFromSlots(new_ert, admin_slots, commander_slots, security_slots, medical_slots, engineering_slots, janitor_slots, inquisitor_slots)

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

/datum/ert_manager/proc/slots_to_roles(security_slots, medical_slots, engineering_slots, janitor_slots, inquisitor_slots, ert_type)
	var/list/roles = list()
	var/slots_sans_leader = security_slots + medical_slots + engineering_slots + janitor_slots + inquisitor_slots
	if(ert_type != "Amber")
		for(var/role in 1 to slots_sans_leader)
			if(security_slots > 0)
				roles.Add(/datum/antagonist/ert/security/red)
				security_slots--
			if(medical_slots > 0)
				roles.Add(/datum/antagonist/ert/medic/red)
				medical_slots--
			if(engineering_slots > 0)
				roles.Add(/datum/antagonist/ert/engineer/red)
				engineering_slots--
			if(janitor_slots > 0)
				roles.Add(/datum/antagonist/ert/janitor)
				janitor_slots--
			if(inquisitor_slots > 0)
				roles.Add(/datum/antagonist/ert/chaplain/inquisitor)
				inquisitor_slots--
	else
		for(var/role in 1 to slots_sans_leader)
			if(security_slots > 0)
				roles.Add(/datum/antagonist/ert/security)
				security_slots--
			if(medical_slots > 0)
				roles.Add(/datum/antagonist/ert/medic)
				medical_slots--
			if(engineering_slots > 0)
				roles.Add(/datum/antagonist/ert/engineer)
				engineering_slots--
			if(janitor_slots > 0)
				roles.Add(/datum/antagonist/ert/janitor)
				janitor_slots--
			if(inquisitor_slots > 0)
				roles.Add(/datum/antagonist/ert/chaplain/inquisitor)
				inquisitor_slots--
	return roles

/datum/ert_manager/proc/makeERTFromSlots(datum/ert/ertemplate, admin_slots, commander_slots, security_slots, medical_slots, engineering_slots, janitor_slots, inquisitor_slots)
	var/human_authority_setting = CONFIG_GET(string/human_authority)

	ertemplate.enforce_human = (human_authority_setting == HUMAN_AUTHORITY_ENFORCED ? TRUE : FALSE)
	ertemplate.spawn_admin = admin_slots

	var/list/spawnpoints = GLOB.emergencyresponseteamspawn
	var/index = 0

	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates("Do you wish to be considered for [span_notice(ertemplate.polldesc)]?", check_jobban = "deathsquad", alert_pic = /obj/item/card/id/advanced/centcom/ert, role_name_text = "emergency response team")
	var/teamSpawned = FALSE

	// This list will take priority over spawnpoints if not empty
	var/list/spawn_turfs = list()

	// Takes precedence over spawnpoints[1] if not null
	var/obj/effect/landmark/ert_brief_spawn/brief_spawn = locate()

	if(!length(candidates))
		return FALSE

	if(ertemplate.spawn_admin)
		if(isobserver(usr))
			var/mob/living/carbon/human/admin_officer = new (brief_spawn.loc || spawnpoints[1])
			var/chosen_outfit = usr.client?.prefs?.read_preference(/datum/preference/choiced/brief_outfit)
			usr.client.prefs.safe_transfer_prefs_to(admin_officer, is_antag = TRUE)
			admin_officer.equipOutfit(chosen_outfit)
			admin_officer.key = usr.key
		else
			to_chat(usr, span_warning("Could not spawn you in as briefing officer as you are not a ghost!"))

	//Pick the (un)lucky players
	var/numagents = min(ertemplate.teamsize, length(candidates))

	//Create team
	var/datum/team/ert/ert_team = new ertemplate.team()
	if(ertemplate.rename_team)
		ert_team.name = ertemplate.rename_team

	//Assign team objective
	var/datum/objective/missionobj = new ()
	missionobj.team = ert_team
	missionobj.explanation_text = ertemplate.mission
	missionobj.completed = TRUE
	ert_team.objectives += missionobj
	ert_team.mission = missionobj

	var/mob/dead/observer/earmarked_leader
	var/leader_spawned = FALSE // just in case the earmarked leader disconnects or becomes unavailable, we can try giving leader to the last guy to get chosen

	if(ertemplate.leader_experience)
		var/list/candidate_living_exps = list()
		for(var/i in candidates)
			var/mob/dead/observer/potential_leader = i
			candidate_living_exps[potential_leader] = potential_leader.client?.get_exp_living(TRUE)

		candidate_living_exps = sort_list(candidate_living_exps, cmp=/proc/cmp_numeric_dsc)
		if(candidate_living_exps.len > ERT_EXPERIENCED_LEADER_CHOOSE_TOP)
			candidate_living_exps.Cut(ERT_EXPERIENCED_LEADER_CHOOSE_TOP+1) // pick from the top ERT_EXPERIENCED_LEADER_CHOOSE_TOP contenders in playtime
		earmarked_leader = pick(candidate_living_exps)
	else
		earmarked_leader = pick(candidates)

	while(numagents && candidates.len)
		var/turf/spawnloc
		if(length(spawn_turfs))
			spawnloc = pick(spawn_turfs)
		else
			spawnloc = spawnpoints[index+1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len

		var/mob/dead/observer/chosen_candidate = earmarked_leader || pick(candidates) // this way we make sure that our leader gets chosen
		candidates -= chosen_candidate
		if(!chosen_candidate?.key)
			continue

		//Spawn the body
		var/mob/living/carbon/human/ert_operative
		if(ertemplate.mob_type)
			ert_operative = new ertemplate.mob_type(spawnloc)
		else
			ert_operative = new /mob/living/carbon/human(spawnloc)
			chosen_candidate.client.prefs.safe_transfer_prefs_to(ert_operative, is_antag = TRUE)
		ert_operative.key = chosen_candidate.key

		if(ertemplate.enforce_human || !(ert_operative.dna.species.changesource_flags & ERT_SPAWN))
			ert_operative.set_species(/datum/species/human)

		//Give antag datum
		var/datum/antagonist/ert/ert_antag

		if((chosen_candidate == earmarked_leader) || (numagents == 1 && !leader_spawned))
			ert_antag = new ertemplate.leader_role ()
			earmarked_leader = null
			leader_spawned = TRUE
		else
			ert_antag = ertemplate.roles[WRAP(numagents,1,length(ertemplate.roles) + 1)]
			ert_antag = new ert_antag ()
		ert_antag.random_names = ertemplate.random_names

		ert_operative.mind.add_antag_datum(ert_antag,ert_team)
		ert_operative.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))

		//Logging and cleanup
		ert_operative.log_message("has been selected as \a [ert_antag.name].", LOG_GAME)
		numagents--
		teamSpawned++

	if (teamSpawned)
		message_admins("[ertemplate.polldesc] has spawned with the mission: [ertemplate.mission]")

	//Open the Armory doors
	if(ertemplate.opendoors)
		for(var/obj/machinery/door/poddoor/ert/door as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor/ert))
			door.open()
			CHECK_TICK
	return TRUE

/datum/ert/gamma
	leader_role = /datum/antagonist/ert/commander/red
	roles = list(/datum/antagonist/ert/security/red, /datum/antagonist/ert/medic/red, /datum/antagonist/ert/engineer/red)
	code = "Gamma"

/obj/effect/landmark/ert_brief_spawn
	name = "ertbriefspawn"
	icon_state = "ert_brief_spawn"

#undef ERT_EXPERIENCED_LEADER_CHOOSE_TOP
#undef DUMMY_HUMAN_SLOT_ADMIN

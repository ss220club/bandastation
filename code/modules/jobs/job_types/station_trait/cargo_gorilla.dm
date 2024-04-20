/datum/job/cargo_gorilla
	title = JOB_CARGO_GORILLA
	description = "Помогайте отделу поставок в перемещении грузов и утилизации ненужных фруктов."
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	supervisors = SUPERVISOR_QM
	spawn_type = /mob/living/basic/gorilla/cargorilla
	config_tag = "CARGO_GORILLA"
	random_spawns_possible = FALSE
	display_order = JOB_DISPLAY_ORDER_CARGO_GORILLA
	departments_list = list(/datum/job_department/cargo)
	mail_goodies = list(
		/obj/item/food/grown/banana = 1,
	)
	rpg_title = "Beast of Burden"
	allow_bureaucratic_error = FALSE
	job_flags = STATION_TRAIT_JOB_FLAGS | JOB_ANNOUNCE_ARRIVAL | JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK

/datum/job/cargo_gorilla/get_roundstart_spawn_point()
	if (length(GLOB.gorilla_start))
		return pick(GLOB.gorilla_start)
	return ..()

/datum/job/cargo_gorilla/get_spawn_mob(client/player_client, atom/spawn_point)
	if (!player_client)
		return
	var/mob/living/the_big_man = new spawn_type(get_turf(spawn_point))
	the_big_man.fully_replace_character_name(the_big_man.real_name, pick(GLOB.cargorilla_names))
	return the_big_man

/datum/job/cargo_gorilla/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	// Gorilla with a wage, what's he buyin?
	var/datum/bank_account/bank_account = new(spawned.real_name, src)
	bank_account.payday(STARTING_PAYCHECKS, TRUE)
	bank_account.replaceable = FALSE
	spawned.add_mob_memory(/datum/memory/key/account, remembered_id = bank_account.account_id)

	var/obj/item/card/id/advanced/cargo_gorilla/gorilla_id = new(spawned.loc)
	gorilla_id.registered_name = spawned.name
	gorilla_id.update_label()
	gorilla_id.registered_account = bank_account
	bank_account.bank_cards += gorilla_id
	spawned.put_in_hands(gorilla_id, del_on_fail = TRUE)

	to_chat(spawned, span_boldnotice("Вы Каргорила, дружелюбный член станции и грузоперевозчик."))
	to_chat(spawned, span_notice("Вы можете поднимать ящики, кликая на них, и класть их на пол, кликая по нему."))
	spawned.mind.special_role = "Cargorilla"

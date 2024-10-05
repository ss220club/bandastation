///Percentage of a civilian bounty the civilian will make.
#define CIV_BOUNTY_SPLIT 30

///Pad for the Civilian Bounty Control.
/obj/machinery/piratepad/civilian
	name = "civilian bounty pad"
	desc = "A machine designed to send civilian bounty targets to centcom."
	layer = TABLE_LAYER
	resistance_flags = FIRE_PROOF
	circuit = /obj/item/circuitboard/machine/bountypad
	var/cooldown_reduction = 0

/obj/machinery/piratepad/civilian/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, "lpad-idle-open", "lpad-idle-off", tool)

/obj/machinery/piratepad/civilian/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_crowbar(tool)

/obj/machinery/piratepad/civilian/RefreshParts()
	. = ..()
	var/T = -2
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		T += micro_laser.tier

	for(var/datum/stock_part/scanning_module/scanning_module in component_parts)
		T += scanning_module.tier

	cooldown_reduction = T * (30 SECONDS)

/obj/machinery/piratepad/civilian/proc/get_cooldown_reduction()
	return cooldown_reduction

///Computer for assigning new civilian bounties, and sending bounties for collection.
/obj/machinery/computer/piratepad_control/civilian
	name = "civilian bounty control terminal"
	desc = "A console for assigning civilian bounties to inserted ID cards, and for controlling the bounty pad for export."
	status_report = "Готов к доставке."
	icon_screen = "civ_bounty"
	icon_keyboard = "id_key"
	warmup_time = 3 SECONDS
	circuit = /obj/item/circuitboard/computer/bountypad
	interface_type = "CivCargoHoldTerminal"
	///Typecast of an inserted, scanned ID card inside the console, as bounties are held within the ID card.
	var/obj/item/card/id/inserted_scan_id

/obj/machinery/computer/piratepad_control/civilian/attackby(obj/item/I, mob/living/user, params)
	if(isidcard(I))
		if(id_insert(user, I, inserted_scan_id))
			inserted_scan_id = I
			return TRUE
	return ..()

/obj/machinery/computer/piratepad_control/multitool_act(mob/living/user, obj/item/multitool/I)
	if(istype(I) && istype(I.buffer,/obj/machinery/piratepad/civilian))
		to_chat(user, span_notice("Вы привязываете [src.declent_ru(ACCUSATIVE)] к [I.buffer] с помощью буффера [I.declent_ru(GENITIVE)]."))
		pad_ref = WEAKREF(I.buffer)
		return TRUE

/obj/machinery/computer/piratepad_control/civilian/post_machine_initialize()
	. = ..()
	if(cargo_hold_id)
		for(var/obj/machinery/piratepad/civilian/C as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/piratepad/civilian))
			if(C.cargo_hold_id == cargo_hold_id)
				pad_ref = WEAKREF(C)
				return
	else
		var/obj/machinery/piratepad/civilian/pad = locate() in range(4,src)
		pad_ref = WEAKREF(pad)

/obj/machinery/computer/piratepad_control/civilian/recalc()
	if(sending)
		return FALSE
	if(!inserted_scan_id)
		status_report = "Пожалуйста, вставьте сначала ID карту."
		playsound(loc, 'sound/machines/synth/synth_no.ogg', 30 , TRUE)
		return FALSE
	if(!inserted_scan_id.registered_account.civilian_bounty)
		status_report = "Пожалуйста, возьмите сначала новый заказ."
		playsound(loc, 'sound/machines/synth/synth_no.ogg', 30 , TRUE)
		return FALSE
	status_report = "Гражданский заказ: "
	var/obj/machinery/piratepad/civilian/pad = pad_ref?.resolve()
	for(var/atom/movable/AM in get_turf(pad))
		if(AM == pad)
			continue
		if(inserted_scan_id.registered_account.civilian_bounty.applies_to(AM))
			status_report += "Цель применима."
			playsound(loc, 'sound/machines/synth/synth_yes.ogg', 30 , TRUE)
			return
	status_report += "Цель неприменима."
	playsound(loc, 'sound/machines/synth/synth_no.ogg', 30 , TRUE)

/**
 * This fully rewrites base behavior in order to only check for bounty objects, and no other types of objects like pirate-pads do.
 */
/obj/machinery/computer/piratepad_control/civilian/send()
	playsound(loc, 'sound/machines/wewewew.ogg', 70, TRUE)
	if(!sending)
		return
	if(!inserted_scan_id)
		stop_sending()
		return FALSE
	if(!inserted_scan_id.registered_account.civilian_bounty)
		stop_sending()
		return FALSE
	var/datum/bounty/curr_bounty = inserted_scan_id.registered_account.civilian_bounty
	var/active_stack = 0
	var/obj/machinery/piratepad/civilian/pad = pad_ref?.resolve()
	for(var/atom/movable/AM in get_turf(pad))
		if(AM == pad)
			continue
		if(curr_bounty.applies_to(AM))
			active_stack ++
			curr_bounty.ship(AM)
			qdel(AM)
	if(active_stack >= 1)
		status_report += "Цель заказа найдена x[active_stack]. "
	else
		status_report = "Цель заказа не обнаружена. Отмена."
		stop_sending()
	if(curr_bounty.can_claim())
		//Pay for the bounty with the ID's department funds.
		status_report += "Заказ выполнен! Пожалуйста, передайте свой куб-награду в отдел снабжения для перевода средств на ваш аккаунт."
		SSblackbox.record_feedback("tally", "bounties_completed", 1, curr_bounty.type)
		inserted_scan_id.registered_account.reset_bounty()
		SSeconomy.civ_bounty_tracker++

		var/obj/item/bounty_cube/reward = new /obj/item/bounty_cube(drop_location())
		reward.set_up(curr_bounty, inserted_scan_id)

	pad.visible_message(span_notice("[capitalize(pad.declent_ru(NOMINATIVE))] активируется!"))
	flick(pad.sending_state,pad)
	pad.icon_state = pad.idle_state
	playsound(loc, 'sound/machines/synth/synth_yes.ogg', 30 , TRUE)
	sending = FALSE

///Here is where cargo bounties are added to the player's bank accounts, then adjusted and scaled into a civilian bounty.
/obj/machinery/computer/piratepad_control/civilian/proc/add_bounties(cooldown_reduction = 0)
	if(!inserted_scan_id || !inserted_scan_id.registered_account)
		return
	var/datum/bank_account/pot_acc = inserted_scan_id.registered_account
	if((pot_acc.civilian_bounty || pot_acc.bounties) && !COOLDOWN_FINISHED(pot_acc, bounty_timer))
		var/curr_time = round((COOLDOWN_TIMELEFT(pot_acc, bounty_timer)) / (1 MINUTES), 0.01)
		say("Внутренняя сеть идентификаторов наматывает катушки, попробуйте ещё раз через [curr_time] минут!")
		return FALSE
	if(!pot_acc.account_job)
		say("Запрашиваемая ID карта не имеет зарегистрированной должности!")
		return FALSE
	var/list/datum/bounty/crumbs = list(random_bounty(pot_acc.account_job.bounty_types), // We want to offer 2 bounties from their appropriate job catagories
										random_bounty(pot_acc.account_job.bounty_types), // and 1 guaranteed assistant bounty if the other 2 suck.
										random_bounty(CIV_JOB_BASIC))
	COOLDOWN_START(pot_acc, bounty_timer, (5 MINUTES) - cooldown_reduction)
	pot_acc.bounties = crumbs

/**
 * Proc that assigned a civilian bounty to an ID card, from the list of potential bounties that that bank account currently has available.
 * Available choices are assigned during add_bounties, and one is locked in here.
 *
 * @param choice The index of the bounty in the list of bounties that the player can choose from.
 */
/obj/machinery/computer/piratepad_control/civilian/proc/pick_bounty(datum/bounty/choice)
	if(!inserted_scan_id || !inserted_scan_id.registered_account || !inserted_scan_id.registered_account.bounties || !inserted_scan_id.registered_account.bounties[choice])
		playsound(loc, 'sound/machines/synth/synth_no.ogg', 40 , TRUE)
		return
	inserted_scan_id.registered_account.civilian_bounty = inserted_scan_id.registered_account.bounties[choice]
	inserted_scan_id.registered_account.bounties = null
	SSblackbox.record_feedback("tally", "bounties_assigned", 1, inserted_scan_id.registered_account.civilian_bounty.type)
	return inserted_scan_id.registered_account.civilian_bounty

/obj/machinery/computer/piratepad_control/civilian/click_alt(mob/user)
	id_eject(user, inserted_scan_id)
	return CLICK_ACTION_SUCCESS

/obj/machinery/computer/piratepad_control/civilian/ui_data(mob/user)
	var/list/data = list()
	data["points"] = points
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["sending"] = sending
	data["status_report"] = status_report
	data["id_inserted"] = inserted_scan_id
	if(inserted_scan_id?.registered_account)
		if(inserted_scan_id.registered_account.civilian_bounty)
			data["id_bounty_info"] = inserted_scan_id.registered_account.civilian_bounty.description
			data["id_bounty_num"] = inserted_scan_id.registered_account.bounty_num()
			data["id_bounty_value"] = (inserted_scan_id.registered_account.civilian_bounty.reward) * (CIV_BOUNTY_SPLIT/100)
		if(inserted_scan_id.registered_account.bounties)
			data["picking"] = TRUE
			data["id_bounty_names"] = list(inserted_scan_id.registered_account.bounties[1].name,
											inserted_scan_id.registered_account.bounties[2].name,
											inserted_scan_id.registered_account.bounties[3].name)
			data["id_bounty_infos"] = list(inserted_scan_id.registered_account.bounties[1].description,
											inserted_scan_id.registered_account.bounties[2].description,
											inserted_scan_id.registered_account.bounties[3].description)
			data["id_bounty_values"] = list(inserted_scan_id.registered_account.bounties[1].reward * (CIV_BOUNTY_SPLIT/100),
											inserted_scan_id.registered_account.bounties[2].reward * (CIV_BOUNTY_SPLIT/100),
											inserted_scan_id.registered_account.bounties[3].reward * (CIV_BOUNTY_SPLIT/100))
		else
			data["picking"] = FALSE

	return data

/obj/machinery/computer/piratepad_control/civilian/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/obj/machinery/piratepad/civilian/pad = pad_ref?.resolve()
	if(!pad)
		return
	if(!usr.can_perform_action(src) || (machine_stat & (NOPOWER|BROKEN)))
		return
	switch(action)
		if("recalc")
			recalc()
		if("send")
			start_sending()
		if("stop")
			stop_sending()
		if("pick")
			pick_bounty(params["value"])
		if("bounty")
			add_bounties(pad.get_cooldown_reduction())
		if("eject")
			id_eject(usr, inserted_scan_id)
			inserted_scan_id = null
	. = TRUE

///Self explanitory, holds the ID card in the console for bounty payout and manipulation.
/obj/machinery/computer/piratepad_control/civilian/proc/id_insert(mob/user, obj/item/inserting_item, obj/item/target)
	var/obj/item/card/id/card_to_insert = inserting_item
	var/holder_item = FALSE

	if(!isidcard(card_to_insert))
		card_to_insert = inserting_item.RemoveID()
		holder_item = TRUE

	if(!card_to_insert || !user.transferItemToLoc(card_to_insert, src))
		return FALSE

	if(target)
		if(holder_item && inserting_item.InsertID(target))
			playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 50, FALSE)
		else
			id_eject(user, target)

	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] вставляет [card_to_insert.declent_ru(ACCUSATIVE)] в [src.declent_ru(ACCUSATIVE)]."),
						span_notice("Вы вставляете [card_to_insert.declent_ru(ACCUSATIVE)] в [src.declent_ru(ACCUSATIVE)]."))
	playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 50, FALSE)
	ui_interact(user)
	return TRUE

///Removes A stored ID card.
/obj/machinery/computer/piratepad_control/civilian/proc/id_eject(mob/user, obj/target)
	if(!target)
		to_chat(user, span_warning("Этот слот пуст!"))
		return FALSE
	else
		target.forceMove(drop_location())
		if(!issilicon(user) && Adjacent(user))
			user.put_in_hands(target)
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] получает [target.declent_ru(ACCUSATIVE)] из [src.declent_ru(GENITIVE)]."), \
							span_notice("Вы получаете [target.declent_ru(ACCUSATIVE)] из [src.declent_ru(GENITIVE)]."))
		playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 50, FALSE)
		inserted_scan_id = null
		return TRUE

///Upon completion of a civilian bounty, one of these is created. It is sold to cargo to give the cargo budget bounty money, and the person who completed it cash.
/obj/item/bounty_cube
	name = "bounty cube"
	desc = "A bundle of compressed hardlight data, containing a completed bounty. Sell this on the cargo shuttle to claim it!"
	icon = 'icons/obj/economy.dmi'
	icon_state = "bounty_cube"
	///Value of the bounty that this bounty cube sells for.
	var/bounty_value = 0
	///Multiplier for the bounty payout received by the Supply budget if the cube is sent without having to nag.
	var/speed_bonus = 0.2
	///Multiplier for the bounty payout received by the person who completed the bounty.
	var/holder_cut = 0.3
	///Multiplier for the bounty payout received by the person who claims the handling tip.
	var/handler_tip = 0.1
	///Time between nags.
	var/nag_cooldown = 5 MINUTES
	///How much the time between nags extends each nag.
	var/nag_cooldown_multiplier = 1.25
	///Next world tick to nag Supply listeners.
	var/next_nag_time
	///Who completed the bounty.
	var/bounty_holder
	///What job the bounty holder had.
	var/bounty_holder_job
	///What the bounty was for.
	var/bounty_name
	///Bank account of the person who completed the bounty.
	var/datum/bank_account/bounty_holder_account
	///Bank account of the person who receives the handling tip.
	var/datum/bank_account/bounty_handler_account
	///Our internal radio.
	var/obj/item/radio/radio
	///The key our internal radio uses.
	var/radio_key = /obj/item/encryptionkey/headset_cargo

/obj/item/bounty_cube/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_BARCODES, INNATE_TRAIT) // Don't allow anyone to override our pricetag component with a barcode
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()
	RegisterSignal(radio, COMSIG_ITEM_PRE_EXPORT, PROC_REF(on_export))

/obj/item/bounty_cube/Destroy()
	if(radio)
		UnregisterSignal(radio, COMSIG_ITEM_PRE_EXPORT)
		QDEL_NULL(radio)
	return ..()

/obj/item/bounty_cube/examine()
	. = ..()
	if(speed_bonus)
		. += span_notice("<b>[time2text(next_nag_time - world.time,"mm:ss")]</b> остаётся до потери бонуса за быструю доставку в размере <b>[bounty_value * speed_bonus]</b> кредитов.")
	if(handler_tip && !bounty_handler_account)
		. += span_notice("Просканируйте его на шаттле отдела поставок с помощью экспорт сканера, чтобы вписать свой банковский аккаунт в инструкцию по обращению стоимостью <b>[bounty_value * handler_tip]</b> кредитов.")

/*
 * Signal proc for [COMSIG_ITEM_EXPORTED], registered on the internal radio.
 *
 * Deletes the internal radio before being exported,
 * to stop it from bring counted as an export.
 *
 * No 4 free credits for you!
 */
/obj/item/bounty_cube/proc/on_export(datum/source)
	SIGNAL_HANDLER

	QDEL_NULL(radio)
	return COMPONENT_STOP_EXPORT // stops the radio from exporting, not the cube

/obj/item/bounty_cube/process(seconds_per_tick)
	//if our nag cooldown has finished and we aren't on Centcom or in transit, then nag
	if(COOLDOWN_FINISHED(src, next_nag_time) && !is_centcom_level(z) && !is_reserved_level(z))
		//set up our nag message
		var/nag_message = "[capitalize(src.declent_ru(NOMINATIVE))] лежит неотправленным в [get_area(src)]."

		//nag on Supply channel and reduce the speed bonus multiplier to nothing
		var/speed_bonus_lost = "[speed_bonus ? " Бонус за быструю доставку стоимостью [bounty_value * speed_bonus] кредитов был потерян." : ""]"
		radio.talk_into(src, "[nag_message][speed_bonus_lost]", RADIO_CHANNEL_SUPPLY)
		speed_bonus = 0

		//alert the holder
		bounty_holder_account.bank_card_talk("[nag_message]")

		//if someone has registered for the handling tip, nag them
		bounty_handler_account?.bank_card_talk(nag_message)

		//increase our cooldown length and start it again
		nag_cooldown = nag_cooldown * nag_cooldown_multiplier
		COOLDOWN_START(src, next_nag_time, nag_cooldown)

/obj/item/bounty_cube/proc/set_up(datum/bounty/my_bounty, obj/item/card/id/holder_id)
	bounty_value = my_bounty.reward
	bounty_name = my_bounty.name
	bounty_holder = holder_id.registered_name
	bounty_holder_job = holder_id.assignment
	bounty_holder_account = holder_id.registered_account
	name = "\improper [bounty_value] cr [declent_ru(NOMINATIVE)]"
	desc += " Торговая бирка показывает, что этот куб-награда для <i>[bounty_holder] ([bounty_holder_job])</i> за выполнение заказа \"<i>[bounty_name]</i>\" ."
	AddComponent(/datum/component/pricetag, holder_id.registered_account, holder_cut, FALSE)
	AddComponent(/datum/component/gps, "[src]")
	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, next_nag_time, nag_cooldown)
	radio.talk_into(src,"Куб-награда был создан в [get_area(src)] пользователем [bounty_holder] ([bounty_holder_job]). Бонус за быструю доставку будет потерян через [time2text(next_nag_time - world.time,"mm:ss")].", RADIO_CHANNEL_SUPPLY)

//for when you need a REAL bounty cube to test with and don't want to do a bounty each time your code changes
/obj/item/bounty_cube/debug_cube
	name = "debug bounty cube"
	desc = "Use in-hand to set it up with a random bounty. Requires an ID it can detect with a bank account attached. \
	This will alert Supply over the radio with your name and location, and cargo techs will be dispatched with kill on sight clearance."
	var/set_up = FALSE

/obj/item/bounty_cube/debug_cube/attack_self(mob/user)
	if(!isliving(user))
		to_chat(user, span_warning("You aren't eligible to use this!"))
		return ..()

	if(!set_up)
		var/mob/living/squeezer = user
		if(squeezer.get_bank_account())
			set_up(random_bounty(), squeezer.get_idcard())
			set_up = TRUE
			return ..()
		to_chat(user, span_notice("It can't detect your bank account."))

	return ..()

///Beacon to launch a new bounty setup when activated.
/obj/item/civ_bounty_beacon
	name = "civilian bounty beacon"
	desc = "N.T. approved civilian bounty beacon, toss it down and you will have a bounty pad and computer delivered to you."
	icon = 'icons/obj/machines/floor.dmi'
	icon_state = "floor_beacon"
	var/uses = 2

/obj/item/civ_bounty_beacon/attack_self()
	loc.visible_message(span_warning("[capitalize(src.declent_ru(NOMINATIVE))] начинает громко гудеть!"))
	addtimer(CALLBACK(src, PROC_REF(launch_payload)), 1 SECONDS)

/obj/item/civ_bounty_beacon/proc/launch_payload()
	playsound(src, SFX_SPARKS, 80, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	switch(uses)
		if(2)
			new /obj/machinery/piratepad/civilian(drop_location())
		if(1)
			new /obj/machinery/computer/piratepad_control/civilian(drop_location())
			qdel(src)
	uses--

#undef CIV_BOUNTY_SPLIT

/obj/machinery/optable/v2
	name = "advanced operating table"
	desc = "Used for advanced medical procedures. This one have build in mask and slot for anestetic tanks"
	icon = 'modular_bandastation/medical/icons/surgery_table.dmi'
	icon_state = "optable"
	var/obj/item/tank/internals/tank = null
	var/obj/item/clothing/mask/mask = null
	var/current_breathing = FALSE

/obj/machinery/optable/v2/Initialize(mapload)
	. = ..()
	for(var/direction in GLOB.alldirs)
		computer = locate(/obj/machinery/computer/operating) in get_step(src, direction)
		if(computer)
			computer.table = src
			break

	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(mark_patient))
	RegisterSignal(loc, COMSIG_ATOM_EXITED, PROC_REF(unmark_patient))
	START_PROCESSING(SSobj, src)

/obj/machinery/optable/v2/examine(mob/user)
	. = ..()
	. += "<hr>"

	if(tank)
		. += span_info("There is a [tank] on side.")
	else
		. += span_warning("There is an empty place for tank.")

	if(mask)
		. += span_info("There is a [mask].")
	else
		. += span_warning("There is an empty place for mask")

/obj/machinery/optable/v2/examine_more(mob/user)
	. = ..()
	. += span_notice("You can remove tank by pressing Alt.")
	if(tank && mask) . += span_info("<br>You can turn on anestesia when someone lying on it.")

/obj/machinery/optable/v2/attack_hand(mob/user, act_intent, attackchain_flags)
	recheck_patient(patient)
	if (isnull(patient))
		return
	if(tank && mask)
		if(!patient.internal)
			to_chat(user, span_notice("You begin to turn on anestesia."))
			if(patient.stat != UNCONSCIOUS)
				to_chat(patient, span_danger("[user] begin to turn on anestesia!"))
			if(!do_after(user, 5 SECONDS, patient))
				return
			recheck_patient(patient)
			if (isnull(patient))
				to_chat(user, span_danger("You failed to equip breath mask on [patient]!"))
				return
			if(patient.wear_mask)
				if(isclothing(patient.wear_mask))
					var/obj/item/clothing/patient_item_in_mask_slot = patient.wear_mask
					if(!patient_item_in_mask_slot.clothing_flags)
						if(!patient.dropItemToGround(patient.wear_mask))
							to_chat(user, span_danger("You failed to drop mask from [patient], to equip breath mask!"))
							return
				else
					if(!patient.dropItemToGround(patient.wear_mask))
						to_chat(user, span_danger("You failed to drop item from [patient], to equip breath mask!"))
						return
			patient.equip_to_slot_if_possible(mask, ITEM_SLOT_MASK)
			if(!patient.wear_mask)
				to_chat(user, span_danger("You failed to equip breath mask on [patient]!"))
				return
			patient.internal = tank
			tank.loc = patient
			user.visible_message("[user] switch on anestesia on [patient].", span_notice("You open a vent for anestesia."))
			patient.open_internals(patient.internal)
			current_breathing = TRUE
			update_overlays()
			return
		else
			if(patient.internal != tank)
				to_chat(user, span_danger("You need to turn off [patient]'s tank!"))
				return
			if(!do_after(user, 1 SECONDS, patient))
				return
			user.visible_message("[user] switch off anestesia on [patient].", span_notice("You close a vent for anestesia."))
			stop_breath()
	else
		to_chat(user, span_warning("[src] don't have a tank or mask!"))

/obj/machinery/optable/v2/process()
	if (!isnull(patient))
		recheck_patient(patient)
		if(mask?.loc != patient || isnull(tank) || patient?.loc != loc)
			stop_breath()

/obj/machinery/optable/v2/proc/stop_breath()
	recheck_patient(patient)
	if(!patient)
		if(mask)
			mask.forceMove(src)
		return
	if(mask && mask.loc != src)
		visible_message(span_notice("[mask] returning to it's place."))
		patient.transferItemToLoc(mask, src, TRUE)
	tank.loc = src
	tank.after_internals_closed(patient)
	patient.internal = null
	current_breathing = FALSE
	if (patient.body_position != LYING_DOWN)
		patient = null
	update_overlays()

/obj/machinery/optable/v2/click_alt(mob/living/user)
	if(!ishuman(user))
		to_chat(user, span_warning("it's to difficult for you!"))
		return
	if(patient)
		to_chat(user, span_warning("Need to remove patient first!"))
		return
	if(tank && !patient?.internal)
		to_chat(user, span_notice("You remove [tank] from side of table."))
		user.put_in_hands(tank)
		tank = null
		update_overlays()

	else if(mask && !patient?.internal)
		to_chat(user, span_notice("You remove [mask] from side of table."))
		user.put_in_hands(mask)
		mask = null
		update_overlays()
	return TRUE

/obj/machinery/optable/v2/update_overlays()
	SHOULD_CALL_PARENT(TRUE)
	.=..()
	var/static/mask_is
	var/static/tank_is
	var/static/bad_state
	var/static/good_state
	var/static/mid_state
	var/static/maskwork
	if(isnull(mask_is)) //static vars initialize with global variables, meaning src is null and this won't pass integration tests unless you check.
		tank_is = iconstate2appearance(icon, "balon_2")
		mask_is  = iconstate2appearance(icon, "mask")
		good_state = iconstate2appearance(icon, "over_green")
		mid_state = iconstate2appearance(icon, "over_yello")
		bad_state = iconstate2appearance(icon, "over_red")
		maskwork = iconstate2appearance(icon, "mask_equip")
	if (isnull(mask))
		cut_overlay(mask_is)
	else
		add_overlay(mask_is)
	if (isnull(tank))
		cut_overlay(tank_is)
	else
		add_overlay(tank_is)
	if (isnull(mask) && isnull(tank))
		add_overlay(bad_state)
		cut_overlay(good_state)
		cut_overlay(mid_state)
	else if (isnull(mask) || isnull(tank))
		add_overlay(mid_state)
		cut_overlay(good_state)
		cut_overlay(bad_state)
	else
		add_overlay(good_state)
		cut_overlay(mid_state)
		cut_overlay(bad_state)
	if (current_breathing)
		add_overlay(maskwork)
		cut_overlay(mask_is)
	else
		if (isnull(mask))
			cut_overlay(mask_is)
		else
			add_overlay(mask_is)
		cut_overlay(maskwork)

/obj/machinery/optable/v2/attacked_by(obj/item/I, mob/living/user)
	if(!user.combat_mode)
		if(!tank)
			if(istype(I, /obj/item/tank/internals))
				if(user.transferItemToLoc(I, src))
					user.visible_message("[user] fixes [I] from side of table.", span_notice("You fix [I] from side of table."))
					tank = I
					update_overlays()
					return ITEM_INTERACT_SUCCESS
		if(!mask)
			if(istype(I, /obj/item/clothing/mask))
				var/obj/item/clothing/mask/potential_mask = I
				if(potential_mask.clothing_flags)
					if(user.transferItemToLoc(I, src))
						user.visible_message("[user] fixes [I] on mask stand.", span_notice("You fix [I] on mask stand."))
						mask = I
						update_overlays()
						return ITEM_INTERACT_SUCCESS
	else
		. = ..()

/obj/machinery/optable/v2/Destroy()
	if(tank)
		tank.forceMove(loc)
		tank = null
	if(mask)
		mask.forceMove(loc)
		mask = null
	STOP_PROCESSING(SSobj, src)
	stop_breath()
	. = ..()

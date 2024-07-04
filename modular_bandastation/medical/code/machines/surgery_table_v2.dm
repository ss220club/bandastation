/obj/structure/table/optable/v2
	name = "advanced operating table"
	desc = "Used for advanced medical procedures. This one have build in mask and slot for anestetic tanks"
	icon = 'icons/obj/medical/surgery_table.dmi'
	icon_state = "surgery_table"
	var/obj/item/tank/internals/tank = null
	var/obj/item/clothing/mask/mask = null

/obj/structure/table/optable/v2/Initialize(mapload)
	. = ..()
	for(var/direction in GLOB.alldirs)
		computer = locate(/obj/machinery/computer/operating) in get_step(src, direction)
		if(computer)
			computer.table = src
			break

	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(mark_patient))
	RegisterSignal(loc, COMSIG_ATOM_EXITED, PROC_REF(unmark_patient))
	START_PROCESSING(SSobj, src)

/obj/structure/table/optable/v2/examine(mob/user)
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

/obj/structure/table/optable/v2/examine_more(mob/user)
	. = ..()
	. += span_notice("You can remove tank by pressing Alt.")
	if(tank && mask) . += span_info("<br>You can turn on anestesia when someone lying on it.")

/obj/structure/table/optable/v2/attack_hand(mob/user, act_intent, attackchain_flags)
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
	. = ..()

/obj/structure/table/optable/v2/process()
	if (!isnull(patient))
		recheck_patient(patient)
		if(mask?.loc != patient || isnull(tank) || patient?.loc != loc)
			stop_breath()

/obj/structure/table/optable/v2/proc/stop_breath()
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

/obj/structure/table/optable/v2/click_alt(mob/living/user)
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
	else if(mask && !patient?.internal)
		to_chat(user, span_notice("You remove [mask] from side of table."))
		user.put_in_hands(mask)
		mask = null
	return TRUE

/obj/structure/table/optable/v2/item_interaction(mob/living/user, obj/item/I, list/modifiers)
	if(!user.combat_mode)
		if(!tank)
			if(istype(I, /obj/item/tank/internals))
				if(user.transferItemToLoc(I, src))
					user.visible_message("[user] fixes [I] from side of table.", span_notice("You fix [I] from side of table."))
					tank = I
					return
		if(!mask)
			if(istype(I, /obj/item/clothing/mask))
				var/obj/item/clothing/mask/potential_mask = I
				if(potential_mask.clothing_flags)
					if(user.transferItemToLoc(I, src))
						user.visible_message("[user] fixes [I] on mask stand.", span_notice("You fix [I] on mask stand."))
						mask = I
						return
	. = ..()

/obj/structure/table/optable/v2/Destroy()
	if(tank)
		tank.forceMove(loc)
		tank = null
	if(mask)
		mask.forceMove(loc)
		mask = null
	STOP_PROCESSING(SSobj, src)
	stop_breath()
	. = ..()

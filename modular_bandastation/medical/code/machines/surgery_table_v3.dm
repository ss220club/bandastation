/obj/structure/table/optable/v3
	name = "operating table N.E.R.V."
	desc = "Used for advanced medical procedures. Comes with built-in neural suppressors to anesthetize a patient laying on top of it."
	icon = 'modular_bandastation/medical/icons/operation_table_v3.dmi'
	icon_state = "table2-idle"
	var/suppressing = FALSE

/obj/structure/table/optable/v3/Initialize(mapload)
	. = ..()
	for(var/direction in GLOB.alldirs)
		computer = locate(/obj/machinery/computer/operating) in get_step(src, direction)
		if(computer)
			computer.table = src
			break

	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(mark_patient))
	RegisterSignal(loc, COMSIG_ATOM_EXITED, PROC_REF(unmark_patient))
	START_PROCESSING(SSobj, src)

/obj/structure/table/optable/v3/examine(mob/user)
	. = ..()
	. += "<hr>"

	. += span_info("The neural suppressors are switched [suppressing ? "on" : "off"].")

/obj/structure/table/optable/v3/attack_hand(mob/user, act_intent, attackchain_flags)
	recheck_patient(patient)
	if(isnull(patient))
		to_chat(user, span_danger("There is nobody on \the [src]. It would be pointless to turn the suppressor on."))
		return TRUE

	if(user != patient && !suppressing) // Skip checks if you're doing it to yourself or turning it off, this is an anti-griefing mechanic more than anything.
		user.visible_message(span_danger("\The [user] begins switching on \the [src]'s neural suppressor."))
		if(!do_after(user, 2 SECONDS, patient))
			return TRUE
		if(isnull(patient))
			to_chat(user, span_danger("There is nobody on \the [src]. It would be pointless to turn the suppressor on."))
			return TRUE

	suppressing = !suppressing
	user.visible_message(span_notice("\The [user] switches [suppressing ? "on" : "off"] \the [src]'s neural suppressor."))
	if (patient.stat == UNCONSCIOUS)
		to_chat(patient, span_notice("... [pick("good feeling", "white light", "pain fades away", "safe now")] ..."))
	return TRUE

/obj/structure/table/optable/v3/process()
	if (!isnull(patient))
		recheck_patient(patient)
		if(patient?.loc != loc)
			stop_supress()
	if (suppressing)
		icon_state = "table2-active"
	else
		icon_state = "table2-idle"

/obj/structure/table/optable/v3/proc/stop_supress()
	suppressing = FALSE

/obj/structure/table/optable/v3/Destroy()
	STOP_PROCESSING(SSobj, src)
	stop_supress()
	. = ..()

/obj/structure/table/optable/v3/recheck_patient()
	. = .. ()
	if(patient && suppressing)
		patient.apply_status_effect(/datum/status_effect/incapacitating/sleeping, 40)

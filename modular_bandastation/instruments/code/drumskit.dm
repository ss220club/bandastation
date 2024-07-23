/obj/structure/musician/drumskit
	name = "\proper барабанная установка"
	desc = "Складная барбанная установка с несколькими томами и тарелками."
	icon = 'modular_bandastation/instruments/icons/samurai_guitar.dmi'
	icon_state = "drum_red_unanchored"
	base_icon_state = "drum_red"
	layer = 2.5
	anchored = FALSE
	var/active = FALSE
	//Использутся, чтобы отслеживать, персонаж должен лежать или "сидеть" (стоять)
	buckle_lying = FALSE
	var/broken_icon_state = "drum_red_broken"
	allowed_instrument_ids = "drums"

/obj/structure/musician/drumskit/examine()
	. = ..()
	. += "<span class='notice'>Используйте гаечный ключ, чтобы разобрать для транспортировки и собрать для игры.</span>"

/obj/structure/musician/drumskit/Destroy()
	UnregisterSignal(src, list(COMSIG_INSTRUMENT_START, COMSIG_INSTRUMENT_END, COMSIG_COMPONENT_CLEAN_ACT))
	return ..()

/obj/structure/musician/drumskit/proc/start_playing()
	SIGNAL_HANDLER
	active = TRUE
	update_icon(UPDATE_ICON_STATE)

/obj/structure/musician/drumskit/proc/stop_playing()
	SIGNAL_HANDLER
	active = FALSE
	update_icon(UPDATE_ICON_STATE)

/obj/structure/musician/drumskit/wrench_act(mob/living/user, obj/item/I)
	if(active || (resistance_flags & INDESTRUCTIBLE))
		return

	if(!anchored && !isinspace())
		to_chat(user, span_notice("You secure [src] to the floor."))
		anchored = TRUE
		can_buckle = TRUE
		layer = 5
		RegisterSignal(src, COMSIG_INSTRUMENT_START, PROC_REF(start_playing))
		RegisterSignal(src, COMSIG_INSTRUMENT_END, PROC_REF(stop_playing))
	else if(anchored)
		to_chat(user, span_notice("You unsecure and disconnect [src]."))
		anchored = FALSE
		can_buckle = FALSE
		layer = 2.5
		UnregisterSignal(src, list(COMSIG_INSTRUMENT_START, COMSIG_INSTRUMENT_END))

	update_icon()
	icon_state = "[base_icon_state][anchored ? null : "_unanchored"]"

	playsound(src, 'sound/items/deconstruct.ogg', 50, 1)

	return TRUE

/obj/structure/musician/piano/atom_break(damage_flag)
	. = ..()
	if(!broken)
		broken = TRUE
		icon_state = broken_icon_state

/obj/structure/musician/drumskit/attack_hand(mob/user)
	add_fingerprint(user)

	if(!anchored)
		return

	ui_interact(user)

/obj/structure/musician/drumskit/update_icon_state()
	.=..()
	if(anchored)
		icon_state = "[base_icon_state][active ? "_active" : null]"

	setDir(SOUTH)

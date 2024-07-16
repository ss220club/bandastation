/obj/structure/musician/piano/drumskit
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
	broken_icon_state = "drum_red_broken"

/obj/structure/musician/piano/drumskit/examine()
	. = ..()
	. += "<span class='notice'>Используйте гаечный ключ, чтобы разобрать для транспортировки и собрать для игры.</span>"

/obj/structure/musician/piano/drumskit/Initialize(mapload)
	. = ..()
	//Выбирает инструмент по умолчанию
	song = new(src, "drums", 15)
	allowed_instrument_ids = null

/obj/structure/musician/piano/drumskit/Destroy()
	UnregisterSignal(src, list(COMSIG_INSTRUMENT_START, COMSIG_INSTRUMENT_END))
	return ..()

/obj/structure/musician/piano/drumskit/proc/start_playing()
	SIGNAL_HANDLER
	active = TRUE
	update_icon(UPDATE_ICON_STATE)

/obj/structure/musician/piano/drumskit/proc/stop_playing()
	SIGNAL_HANDLER
	active = FALSE
	update_icon(UPDATE_ICON_STATE)

/obj/structure/musician/piano/drumskit/wrench_act(mob/living/user, obj/item/I)
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

/obj/structure/musician/piano/drumskit/attack_hand(mob/user)
	add_fingerprint(user)

	if(!anchored)
		return

	ui_interact(user)

/obj/structure/musician/piano/drumskit/update_icon_state()
	.=..()
	if(anchored)
		icon_state = "[base_icon_state][active ? "_active" : null]"

	setDir(SOUTH)

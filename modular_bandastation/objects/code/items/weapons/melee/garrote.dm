/obj/item/melee/garrote
	name = "fiber wire"
	desc = "A length of razor-thin wire with an elegant wooden handle on either end.<br>You suspect you'd have to be behind the target to use this weapon effectively."
	w_class = WEIGHT_CLASS_TINY
	icon = 'modular_bandastation/objects/icons/obj/weapons/misc.dmi'
	icon_state = "garrot_wrap"
	var/mob/living/carbon/human/strangling
	var/improvised = FALSE
	var/garrote_time

/obj/item/melee/garrote/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed)

/obj/item/melee/garrote/Destroy()
	strangling = null
	return ..()

/obj/item/melee/garrote/update_icon_state()
	if(strangling) // If we're strangling someone we want our icon to stay wielded
		icon_state = "garrot_[improvised ? "I_" : ""]unwrap"
	else
		icon_state = "garrot_[improvised ? "I_" : ""][HAS_TRAIT(src, TRAIT_WIELDED) ? "un" : ""]wrap"
	. = ..()

	/// Made via tablecrafting
/obj/item/melee/garrote/improvised
	name = "garrote"
	desc = "A length of cable with a shoddily-carved wooden handle tied to either end.<br>You suspect you'd have to be behind the target to use this weapon effectively."
	icon_state = "garrot_I_wrap"
	improvised = TRUE

/obj/item/melee/garrote/improvised/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, wield_callback = CALLBACK(src, PROC_REF(wield)))


/obj/item/melee/garrote/proc/wield(obj/item/source, mob/living/carbon/user)
	if(!strangling)
		return
	user.visible_message("<span class='notice'>[user] removes [src] from [strangling]'s neck.</span>",
			"<span class='warning'>You remove [src] from [strangling]'s neck.</span>")

	strangling = null
	update_icon(UPDATE_ICON_STATE)
	STOP_PROCESSING(SSobj, src)


/obj/item/melee/garrote/attack(mob/living/carbon/human/target, mob/living/carbon/user)
	if(garrote_time > world.time) // Cooldown
		return
	if(!ishuman(user)) // spap_hand is a proc of /mob/living, user is simply /mob
		return
	var/mob/living/carbon/human/U = user

	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		to_chat(user, "<span class = 'warning'>You must use both hands to garrote [M]!</span>")
		return
	if(!ishuman(M))
		to_chat(user, "<span class = 'warning'>You don't think that garroting [M] would be very effective...</span>")
		return
	if(!check_behind(U, M) && !HAS_TRAIT(M, TRAIT_INCAPACITATED))
		to_chat(user, "<span class='warning'>You cannot use [src] on [M] from that angle!</span>")
		return
	if(improvised && ((M.head && (M.head.flags_cover & HEADCOVERSMOUTH)) || (M.wear_mask && (M.wear_mask.flags_cover & MASKCOVERSMOUTH)))) // Improvised garrotes are blocked by mouth-covering items.
		to_chat(user, "<span class = 'warning'>[M]'s neck is blocked by something [M.p_theyre()] wearing!</span>")
	if(strangling && strangling != M)
		to_chat(user, "<span class = 'warning'>You cannot use [src] on two people at once!</span>")
		return
	if(user.grab_state == GRAB_KILL)
		return

	if(user.grab_state < 1)
		M.grabbedby(U, TRUE)
		if(improvised)
			U.setGrabState(GRAB_NECK)
		else
			U.setGrabState(GRAB_KILL)
	else
		if(user.grab_state != GRAB_KILL)
			U.setGrabState(user.grab_state + 1)

	if(improvised) // Improvised garrotes start you off with a passive grab, but will lock you in place. A quick stun to drop items but not to make it unescapable
		M.Stun(1 SECONDS)
		M.Immobilize(2 SECONDS)
	else
		M.adjust_silence(2 SECONDS)
	M.dir = user.dir
	garrote_time = world.time + 10
	START_PROCESSING(SSobj, src)
	strangling = M
	update_icon(UPDATE_ICON_STATE)

	playsound(loc, 'sound/items/weapons/cablecuff.ogg', 15, TRUE, -10, ignore_walls = FALSE)

	M.visible_message("<span class='danger'>[U] comes from behind and begins garroting [M] with [src]!</span>", \
				"<span class='userdanger'>[U] begins garroting you with [src]![improvised ? "" : " You are unable to speak!"]</span>", \
				"You hear struggling and wire strain against flesh!")
	return

/obj/item/melee/garrote/process()
	if(!strangling)
		// Our mark got gibbed or similar
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)
		return


	if(!ishuman(loc))
		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)
		return

	var/mob/living/carbon/human/user = loc
	strangling.dir = user.dir

	if(user.grab_state < 1)
		user.visible_message("<span class='warning'>[user] loses [user.p_their()] grip on [strangling]'s neck.</span>", \
				"<span class='warning'>You lose your grip on [strangling]'s neck.</span>")

		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)

		return
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		user.visible_message("<span class='warning'>[user] loses [user.p_their()] grip on [strangling]'s neck.</span>", \
				"<span class='warning'>You lose your grip on [strangling]'s neck.</span>")
		user.setGrabState(0)
		strangling = null
		update_icon(UPDATE_ICON_STATE)
		STOP_PROCESSING(SSobj, src)
		return

	if(user.grab_state < GRAB_NECK) // Only possible with improvised garrotes, essentially this will stun people as if they were aggressively grabbed. Allows for resisting out if you're quick, but not running away.
		strangling.Immobilize(3 SECONDS)

	if(improvised)
		strangling.adjust_stutter(6 SECONDS)
		strangling.apply_damage(2, OXY, "head")
		return


	strangling.adjust_silence(6 SECONDS) // Non-improvised effects
	if(user.grab_state == GRAB_KILL)
		//strangling.PreventOxyHeal(6 SECONDS)
		strangling.losebreath += 6
		strangling.apply_damage(4, OXY, "head")
		strangling.apply_damage(4, BRUTE, "head")

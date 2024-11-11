/obj/structure/closet/secure_closet/togglelock(mob/user)
	. = ..()
	var/list/togglelock_sound = list(
		'modular_bandastation/aesthetics_sounds/sound/lock_1.ogg',
		'modular_bandastation/aesthetics_sounds/sound/lock_2.ogg',
		'modular_bandastation/aesthetics_sounds/sound/lock_3.ogg'
	)
	if(allowed(user))
		locked = !locked
		playsound(loc, pick(togglelock_sound), 10, TRUE, -3)
		return ..()

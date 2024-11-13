/obj/structure/closet
	var/list/togglelock_sound = list()

/obj/structure/closet/secure_closet/Initialize(mapload)
	. = ..()
	togglelock_sound = list(
		'modular_bandastation/aesthetics_sounds/sound/lock_1.ogg',
		'modular_bandastation/aesthetics_sounds/sound/lock_2.ogg',
		'modular_bandastation/aesthetics_sounds/sound/lock_3.ogg'
	)

/obj/structure/closet/crate/secure/Initialize(mapload)
	. = ..()
	togglelock_sound = list(
		'modular_bandastation/aesthetics_sounds/sound/lock_1.ogg',
		'modular_bandastation/aesthetics_sounds/sound/lock_2.ogg',
		'modular_bandastation/aesthetics_sounds/sound/lock_3.ogg'
	)

/obj/structure/closet/secure_closet/togglelock(mob/living/user, silent)
	. = ..()
	if(!opened && !broken && !(user.loc == src) && allowed(user))
		playsound(loc, pick(togglelock_sound), 10, TRUE, -3)

/obj/structure/closet/crate/secure/togglelock(mob/living/user, silent)
	. = ..()
	if(!opened && !broken && !(user.loc == src) && allowed(user))
		playsound(loc, pick(togglelock_sound), 10, TRUE, -3)

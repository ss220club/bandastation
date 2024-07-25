// Тактическая бита Флота Nanotrasen
/obj/item/melee/baseball_bat/homerun/central_command
	name = "тактическая бита Флота Nanotrasen"
	desc = "Выдвижная тактическая бита Центрального Командования Nanotrasen. \
	В официальных документах эта бита проходит под элегантным названием \"Высокоскоростная система доставки СРП\". \
	Выдаваясь только самым верным и эффективным офицерам Nanotrasen, это оружие является одновременно символом статуса \
	и инструментом высшего правосудия."
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	lefthand_file = 'modular_bandastation/objects/icons/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/melee_righthand.dmi'
	icon = 'modular_bandastation/objects/icons/melee.dmi'
	icon_state = "centcom_bat"
	inhand_icon_state = "centcom_bat"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "nothing"
	homerun_able = FALSE

/obj/item/melee/baseball_bat/homerun/central_command/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = 20, \
		w_class_on = WEIGHT_CLASS_HUGE, \
		attack_verb_simple_on = list("smacked", "struck", "crack", "beat"), \
		attack_verb_simple_off = list("hit", "poked"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/baseball_bat/homerun/central_command/proc/on_transform(obj/item/source, mob/user, homerun_ready)
	SIGNAL_HANDLER

	src.homerun_ready = homerun_ready
	if(user)
		to_chat(user, homerun_able ? span_userdanger("Вы разложили [src.name] - время для правосудия!") : span_userdanger("Вы сложили [src.name]."))
	playsound(src, 'sound/weapons/batonextend.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/baseball_bat/homerun/central_command/attack_self(mob/user)
	homerun_able = !homerun_able

/obj/item/melee/baseball_bat/homerun/central_command/pickup(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user.get_item_by_slot(ITEM_SLOT_ID), /obj/item/card/id/advanced/centcom))
		user.AdjustParalyzed(10 SECONDS)
		user.drop_all_held_items(src, force)
		to_chat(user, span_userdanger("Это - оружие истинного правосудия. Тебе не дано обуздать его мощь."))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(rand(force/2, force), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			user.adjustBruteLoss(rand(force/2, force))

/obj/item/melee/baseball_bat/homerun/central_command/attack(mob/living/target, mob/living/user)
	if(homerun_able)
		homerun_ready = TRUE
	. = ..()

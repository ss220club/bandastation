/obj/item/toy/plush/brigadier_general
	name = "brigadier general Gold"
	desc = "Эта игрушка была сделана в честь бригадного генерала ТСФ, погибшего во время яростного сражения на Тау Ките во время \
	Великой межсистемной войны. На задней части игрушки имеется бирка с надписью: \"Важно дойти до конца!\"."
	icon = 'modular_bandastation/objects/icons/plushies.dmi'
	icon_state = "brigadier_general"
	lefthand_file = 'modular_bandastation/objects/icons/inhands/plushies_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/plushies_righthand.dmi'
	inhand_icon_state = "brigadier_general"
	COOLDOWN_DECLARE(squeeze_cooldown)

/obj/item/toy/plush/brigadier_general/attack_self(mob/user)
	if(!COOLDOWN_FINISHED(src, squeeze_cooldown))
		return
	COOLDOWN_START(src, squeeze_cooldown, 5 SECONDS)
	. = ..()
	say("Важно дойти до конца!")

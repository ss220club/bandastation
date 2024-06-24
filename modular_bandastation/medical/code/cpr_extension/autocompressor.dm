// Определяем новый объект автокомпрессора
/obj/item/clothing/suit/autocompressor
	name = "Auto Compressor Suit"
	desc = "A suit equipped with an auto compressor to perform automatic chest compressions during CPR."
	icon = 'modular_bandastation/medical/icons/medical_suits.dmi'
	icon_state = "pumper"

	var/mob/living/carbon/human/target
	var/active = FALSE

/obj/item/clothing/suit/autocompressor/Initialize()
	. = ..()

/obj/item/clothing/suit/autocompressor/equipped(mob/living/user, slot)
	. = ..()
	if (!istype(user))
		return

	if(slot & slot_flags) // Проверка, что предмет экипирован в слот, соответствующий slot_flags
		active = TRUE
		target = user
		spawn do_compression_loop()
	else
		active = FALSE
#define CPR_PANIC_SPEED (0.8 SECONDS)

// Процедура для выполнения цикла компрессий
/obj/item/clothing/suit/autocompressor/proc/do_compression_loop()

	var/panicking = FALSE

	do
		if(!active || !target)
			return

		if (HAS_TRAIT(target, TRAIT_NOBREATH))
			to_chat(target, span_unconscious("You feel a mechanical force performing compressions..."))
		else if (!target.get_organ_slot(ORGAN_SLOT_LUNGS))
			to_chat(target, span_unconscious("You feel a mechanical force performing compressions... but you don't feel any better..."))
		else
			target.apply_status_effect(/datum/status_effect/cpred)
			if (!(target.stat == DEAD || HAS_TRAIT(target, TRAIT_FAKEDEATH)))
				target.adjustOxyLoss(-min(target.getOxyLoss(), 7))
				to_chat(target, span_unconscious("You feel a mechanical force performing compressions... It feels good..."))

		if (target.d <= target.crit_threshold)
			if (!panicking)
				to_chat(src, span_warning("[target] still isn't up! The Auto Compressor Suit tries harder!"))
			panicking = TRUE
		else
			panicking = FALSE

		sleep 3;
	while (panicking)
#undef CPR_PANIC_SPEED

/datum/action/changeling/darkness_adaptation
	name = "Darkness Adaptation"
	desc = "Пигментация кожи и глаза быстро меняется в зависимости от темноты. Для включения требуется 10 химикатов в хранилище. Замедляет регенерацию химикатов на 15%."
	helptext = "Позволяет затемнить и изменить полупрозрачность пигментации, а также адаптировать глаза для видения в темных условиях. \
	Эффект полупрозрачности лучше всего работает в темном окружении и одежде. Можно включать и выключать."
	button_icon_state = "darkness_adaptation"
	dna_cost = 2
	chemical_cost = 10

	req_human = TRUE
	//// is ability active (we are invisible)?
	var/is_active = FALSE
	/// How much we slow chemical regeneration while active, in chems per second
	var/recharge_slowdown = 0.15

/datum/action/changeling/darkness_adaptation/on_purchase(mob/user, is_respec)
	. = ..()
	RegisterSignal(user, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(eye_implanted))
	RegisterSignal(user, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(eye_removed))

/datum/action/changeling/darkness_adaptation/sting_action(mob/living/carbon/human/cling) //SHOULD always be human, because req_human = TRUE
	..()
	is_active = !is_active
	if(is_active)
		enable_ability(cling)
	else
		disable_ability(cling)

/datum/action/changeling/darkness_adaptation/Remove(mob/living/carbon/human/cling)
	..()
	disable_ability(cling)

/datum/action/changeling/darkness_adaptation/proc/enable_ability(mob/living/carbon/human/cling) //Enable the adaptation
	animate(cling, alpha = 65,time = 3 SECONDS)
	cling.visible_message(span_warning("Кожа [cling] внезапно становится полупрозрачной!"), \
					span_notice("Теперь мы стали гораздо более скрытными и лучше видим в темноте."))
	animate(cling, color = COLOR_DARK, time = 3 SECONDS) // Darkens their overall appearance
	var/datum/antagonist/changeling/changeling_data = cling.mind?.has_antag_datum(/datum/antagonist/changeling)
	changeling_data?.chem_recharge_slowdown -= recharge_slowdown //Slows down chem regeneration
	var/obj/item/organ/internal/eyes/eyes = cling.get_organ_by_type(/obj/item/organ/internal/eyes)
	if(!istype(eyes))
		return
	eyes.lighting_cutoff = LIGHTING_CUTOFF_MEDIUM // Adds barely usable, kinda shit night vision
	eyes.flash_protect = max(eyes.flash_protect += -1, FLASH_PROTECTION_HYPER_SENSITIVE) // Reduces flash protection by one level
	cling.update_sight() // Update the display

/datum/action/changeling/darkness_adaptation/proc/disable_ability(mob/living/carbon/human/cling) //Restore the adaptation
	animate(cling, alpha = 255, time = 3 SECONDS)
	cling.visible_message(
		span_warning("[cling] появляется из воздуха!"),
		span_notice("Мы становимся внешне нормальными и теряем способность видеть в темноте."),
	)
	animate(cling, color = null, time = 3 SECONDS)
	var/datum/antagonist/changeling/changeling_data = cling.mind?.has_antag_datum(/datum/antagonist/changeling)
	changeling_data?.chem_recharge_slowdown += recharge_slowdown
	var/obj/item/organ/internal/eyes/eyes = cling.get_organ_by_type(/obj/item/organ/internal/eyes)
	if(!istype(eyes))
		return
	eyes.lighting_cutoff = LIGHTING_CUTOFF_VISIBLE
	eyes.flash_protect = max(eyes.flash_protect += 1, FLASH_PROTECTION_WELDER)
	cling.update_sight()

/// Signal proc to grant the correct level of flash sensitivity
/datum/action/changeling/darkness_adaptation/proc/eye_implanted(mob/living/source, obj/item/organ/gained, special)
	SIGNAL_HANDLER

	var/obj/item/organ/internal/eyes/eyes = gained
	if(!istype(eyes))
		return
	if(is_active)
		eyes.flash_protect = max(eyes.flash_protect += -1, FLASH_PROTECTION_HYPER_SENSITIVE)
	else
		eyes.flash_protect = max(eyes.flash_protect += 1, FLASH_PROTECTION_WELDER)

/// Signal proc to remove flash sensitivity when the eyes are removed
/datum/action/changeling/darkness_adaptation/proc/eye_removed(mob/living/source, obj/item/organ/removed, special)
	SIGNAL_HANDLER

	var/obj/item/organ/internal/eyes/eyes = removed
	if(!istype(eyes))
		return
	eyes.flash_protect = initial(eyes.flash_protect)
	// We don't need to bother about removing or adding night vision, fortunately, because they can't see anyways

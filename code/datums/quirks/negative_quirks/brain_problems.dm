	/* A couple of brain tumor stats for anyone curious / looking at this quirk for balancing:
	 * - It takes less 16 minute 40 seconds to die from brain death due to a brain tumor.
	 * - It takes 1 minutes 40 seconds to take 10% (20 organ damage) brain damage.
	 * - 5u mannitol will heal 12.5% (25 organ damage) brain damage
	 */
/datum/quirk/item_quirk/brainproblems
	name = "Brain Tumor"
	desc = "У вас в мозгу есть маленький друг, который медленно разрушает его. Лучше взять с собой немного маннитола!"
	icon = FA_ICON_BRAIN
	value = -12
	gain_text = span_danger("Вы ощущаете спокойствие.")
	lose_text = span_notice("Вы снова чувствуете себя изнеможденно.")
	medical_record_text = "У пациента опухоль в мозгу, которая медленно ведет его к смерти."
	hardcore_value = 12
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	mail_goodies = list(/obj/item/storage/pill_bottle/mannitol/braintumor)

/datum/quirk/item_quirk/brainproblems/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/mannitol/braintumor,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "Они помогут вам выжить, пока вы не получите запас лекарств. Не полагайтесь на них слишком сильно!",
	)

/datum/quirk/item_quirk/brainproblems/process(seconds_per_tick)
	if(quirk_holder.stat == DEAD)
		return

	if(HAS_TRAIT(quirk_holder, TRAIT_TUMOR_SUPPRESSED))
		return

	quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2 * seconds_per_tick)

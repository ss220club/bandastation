/datum/quirk/item_quirk/chronic_illness
	name = "Chronic Illness"
	desc = "У вас хроническое заболевание, которое требует постоянное медикаментозное лечение."
	icon = FA_ICON_DISEASE
	value = -12
	gain_text = span_danger("Сегодня вы чувствуете себя немного не в своей тарелке.")
	lose_text = span_notice("Сегодня вы чувствуете себя немного лучше.")
	medical_record_text = "Пациент страдает хроническим заболеванием, которое требует постоянное медикаментозное лечение."
	hardcore_value = 12
	mail_goodies = list(/obj/item/storage/pill_bottle/sansufentanyl)

/datum/quirk/item_quirk/chronic_illness/add(client/client_source)
	var/datum/disease/chronic_illness/hms = new /datum/disease/chronic_illness()
	quirk_holder.ForceContractDisease(hms)

/datum/quirk/item_quirk/chronic_illness/add_unique(client/client_source)
	give_item_to_holder(/obj/item/storage/pill_bottle/sansufentanyl, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK),flavour_text = "Вам назначили лекарства, которые помогут справиться с вашим заболеванием. Принимайте их регулярно, чтобы избежать осложнений.")
	give_item_to_holder(/obj/item/healthanalyzer/simple/disease, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK))

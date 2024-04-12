/datum/quirk/voracious
	name = "Voracious"
	desc = "Ничто не встает между вами и едой. Вы едите быстрее и можете налегать на нездоровую пищу! Быть толстым вам очень идет."
	icon = FA_ICON_DRUMSTICK_BITE
	value = 4
	mob_trait = TRAIT_VORACIOUS
	gain_text = span_notice("Вы чувствуете себя ЗДОРОВЫМ.")
	lose_text = span_danger("Вы больше не чувствуете себя ЗДОРОВЫМ.")
	medical_record_text = "Пациент ценит блюда и напитки выше среднего."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/dinner)

/datum/quirk/friendly
	name = "Friendly"
	desc = "Ты обнимаешь лучше всех, особенно когда ты в хорошем настроении."
	icon = FA_ICON_HANDS_HELPING
	value = 2
	mob_trait = TRAIT_FRIENDLY
	gain_text = span_notice("Вам хочется обнять кого-то.")
	lose_text = span_danger("Вы больше не чувствуете себя обязанным обнимать других.")
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_MOODLET_BASED
	medical_record_text = "Пациент демонстрирует низкий уровень запретов на физический контакт и хорошо развитые руки. Просьба другому врачу заняться этим случаем."
	mail_goodies = list(/obj/item/storage/box/hug)

/datum/quirk/pushover
	name = "Pushover"
	desc = "Ваш первобытный инстинкт заключается в том, чтобы всегда позволять людям толкать вас. Сопротивление из захвата потребует особых усилий.."
	icon = FA_ICON_HANDSHAKE
	value = -8
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = span_danger("Вы чувствуете себя податливо.")
	lose_text = span_notice("Вы чувствуете себя уверенно..")
	medical_record_text = "Пациент демонстрирует необычайно неуверенный характер и им легко манипулировать."
	hardcore_value = 4
	mail_goodies = list(/obj/item/clothing/gloves/cargo_gauntlet)

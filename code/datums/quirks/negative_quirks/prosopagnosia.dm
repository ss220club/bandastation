/datum/quirk/prosopagnosia
	name = "Prosopagnosia"
	desc = "У вас психическое расстройство, из-за которого вы вообще не можете распознавать лица."
	icon = FA_ICON_USER_SECRET
	value = -4
	mob_trait = TRAIT_PROSOPAGNOSIA
	medical_record_text = "Пациент страдает прозопагнозией и не может распознавать лица."
	hardcore_value = 5
	mail_goodies = list(/obj/item/skillchip/appraiser) // bad at recognizing faces but good at recognizing IDs

/datum/quirk/throwingarm
	name = "Throwing Arm"
	desc = "У вас очень сильные руки! Предметы, которые вы бросаете, всегда летят дальше, чем все остальные, и вы никогда не промахиваетесь при броске."
	icon = FA_ICON_BASEBALL
	value = 7
	mob_trait = TRAIT_THROWINGARM
	gain_text = span_notice("Ваши руки полны энергии!")
	lose_text = span_danger("У вас немного устали руки.")
	medical_record_text = "Пациент демонстрирует мастерство по бросанию мячиков."
	mail_goodies = list(/obj/item/toy/beach_ball/baseball, /obj/item/toy/basketball, /obj/item/toy/dodgeball)

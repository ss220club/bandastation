/datum/mutation/human/temperature_adaptation
	name = "Temperature Adaptation"
	desc = "Странная мутация, которая адаптирует иммунную систему организма к экстремальным температурам. Не защищает от вакуума."
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>Твоё тело окутывает тепло!</span>"
	instability = 25
	conflicts = list(/datum/mutation/human/pressure_adaptation)

/datum/mutation/human/temperature_adaptation/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut)
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/mob/effects/genetics.dmi', "fire", -MUTATIONS_LAYER))

/datum/mutation/human/temperature_adaptation/get_visual_indicator()
	return visual_indicators[type][1]

/datum/mutation/human/temperature_adaptation/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.add_traits(list(TRAIT_RESISTCOLD, TRAIT_RESISTHEAT), GENETIC_MUTATION)

/datum/mutation/human/temperature_adaptation/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.remove_traits(list(TRAIT_RESISTCOLD, TRAIT_RESISTHEAT), GENETIC_MUTATION)

/datum/mutation/human/pressure_adaptation
	name = "Pressure Adaptation"
	desc = "Странная мутация, которая адаптирует иммунную систему организма к низкому и высокому давлению. Не защищает от температуры и холодного космоса в том числе."
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>Твое тело немеет!</span>"
	instability = 25
	conflicts = list(/datum/mutation/human/temperature_adaptation)

/datum/mutation/human/pressure_adaptation/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut)
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/mob/effects/genetics.dmi', "pressure", -MUTATIONS_LAYER))

/datum/mutation/human/pressure_adaptation/get_visual_indicator()
	return visual_indicators[type][1]

/datum/mutation/human/pressure_adaptation/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.add_traits(list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE), GENETIC_MUTATION)

/datum/mutation/human/pressure_adaptation/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.remove_traits(list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE), GENETIC_MUTATION)

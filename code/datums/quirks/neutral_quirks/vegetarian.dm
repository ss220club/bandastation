/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "Вы считаете идею употребления мяса аморальной и физически отвратительной."
	icon = FA_ICON_CARROT
	value = 0
	gain_text = span_notice("Вы испытываете отвращение к идее есть мясо.")
	lose_text = span_notice("Вам кажется, что есть мясо не так уж и плохо.")
	medical_record_text = "Пациент соблюдает вегетарианскую диету."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/salad)

/datum/quirk/vegetarian/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes &= ~MEAT
	tongue.disliked_foodtypes |= MEAT

/datum/quirk/vegetarian/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)

/datum/quirk/numb
	name = "Numb"
	desc = "Вы совершенно не чувствуете боли."
	icon = FA_ICON_STAR_OF_LIFE
	value = -4
	gain_text = "Вы чувствуете, как ваше тело цепенеет."
	lose_text = "Вы чувствуете, как оцепенение постепенно проходит."
	medical_record_text = "У пациента наблюдается врожденная гипестезия, делающая его нечувствительным к болевым раздражителям."
	hardcore_value = 4

/datum/quirk/numb/add(client/client_source)
	quirk_holder.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/quirk/numb/remove(client/client_source)
	quirk_holder.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

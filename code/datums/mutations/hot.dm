/datum/mutation/human/geladikinesis/ash
	name = "Cindikinesis"
	desc = "Позволяет обладателю мутации сконцентрировать рядом находящееся тепло в кучу пепла. Вау. Очень интересно."
	text_gain_indication = span_notice("Твоя рука кажется тёплой.")
	locked = TRUE
	power_path = /datum/action/cooldown/spell/conjure_item/snow/ash

/datum/action/cooldown/spell/conjure_item/snow/ash
	name = "Create Ash"
	desc = "Concentrates pyrokinetic forces to create ash, useful for basically nothing."
	button_icon_state = "ash"

	item_type = /obj/effect/decal/cleanable/ash

/datum/mutation/human/cryokinesis/pyrokinesis
	name = "Pyrokinesis"
	desc = "Притягивает позитивную энергию  из окружения, чтобы повысить температуру вокруг субъекта."
	text_gain_indication = span_notice("Твоя рука кажется горячей!")
	locked = TRUE
	power_path = /datum/action/cooldown/spell/pointed/projectile/cryo/pyro

/datum/action/cooldown/spell/pointed/projectile/cryo/pyro
	name = "Pyrobeam"
	desc = "This power fires a heated bolt at a target."
	button_icon_state = "firebeam"
	base_icon_state = "firebeam"
	cooldown_time = 30 SECONDS

	active_msg = "You focus your pyrokinesis!"
	deactive_msg = "You cool down."
	projectile_type = /obj/projectile/temp/pyro

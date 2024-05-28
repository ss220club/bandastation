/datum/uplink_category/ammo
	name = "Боеприпасы"
	weight = 7

/datum/uplink_item/ammo
	category = /datum/uplink_category/ammo
	surplus = 40

/datum/uplink_item/ammo/toydarts
	name = "Box of Riot Darts"
	desc = "Коробка с 40-а дротиками \"Donksoft\", для перезарядки любого совместимого магазина для паралоновых дротиков. Не забудь поделиться!"
	item = /obj/item/ammo_box/foambox/riot
	cost = 2
	surplus = 0
	illegal_tech = FALSE
	purchasable_from = ~UPLINK_NUKE_OPS

/datum/uplink_item/ammo/pistol
	name = "9mm Handgun Magazine"
	desc = "Дополнительный 8-ми зарядный магазин с патронами 9мм, совместим с пистолетом Макарова."
	item = /obj/item/ammo_box/magazine/m9mm
	cost = 1
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	illegal_tech = FALSE

/datum/uplink_item/ammo/pistolap
	name = "9mm Armour Piercing Magazine"
	desc = "Дополнительный 8-ми зарядный магазин с патронами 9мм, совместим с пистолетом Макарова. \
			Эти пули менее эффективны для ранения цели, но лучше пробивают защитную экипировку."
	item = /obj/item/ammo_box/magazine/m9mm/ap
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/pistolhp
	name = "9mm Hollow Point Magazine"
	desc = "Дополнительный 8-ми зарядный магазин с патронами 9мм, совместим с пистолетом Макарова. \
			Эти пули наносят больше повреждений, но неэффективны при пробитии брони."
	item = /obj/item/ammo_box/magazine/m9mm/hp
	cost = 3
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/pistolfire
	name = "9mm Incendiary Magazine"
	desc = "Дополнительный 8-ми зарядный магазин с патронами 9мм, совместим с пистолетом Макарова. \
			Заряжен зажигательными патронами, которые наносят незначительный урон, но поджигают цель."
	item = /obj/item/ammo_box/magazine/m9mm/fire
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/revolver
	name = ".357 Speed Loader"
	desc = "Быстрозарядный магазин, который содержит 7 дополнительных патрон .357 Магнума; подходит к револьверу Синдиката. \
			Для тех, кому действительно нужны смертоносные вещи."
	item = /obj/item/ammo_box/a357
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS | UPLINK_SPY) //nukies get their own version
	illegal_tech = FALSE

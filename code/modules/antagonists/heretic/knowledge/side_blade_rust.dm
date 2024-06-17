// Sidepaths for knowledge between Rust and Blade.
/datum/heretic_knowledge/armor
	name = "Armorer's Ritual"
	desc = "Позволяет трансмутировать стол и противогаз для создания Мистической брони. \
		Мистическая броня обеспечивает отличную защиту, а также действует как фокус, когда на него накинут капюшон."
	gain_text = "Ржавые холмы приветствовали Кузнеца в своей щедрости. И Кузнец \
		ответил им щедростью на щедрость."
	next_knowledge = list(
		/datum/heretic_knowledge/rust_regen,
		/datum/heretic_knowledge/blade_dance,
	)
	required_atoms = list(
		/obj/structure/table = 1,
		/obj/item/clothing/mask/gas = 1,
	)
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch)
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/crucible
	name = "Mawed Crucible"
	desc = "Позволяет трансмутировать переносной ватер танк и стол для создания Голодного горнила. \
		Голодное горнило может варить мощные боевые и полезные зелья, но между их употреблениями его нужно кормить частями тела и органами."
	gain_text = "Это чистая агония. Мне не удалось вызвать образ Аристократа, \
		но благодаря вниманию Жреца я наткнулся на другой рецепт..."
	next_knowledge = list(
		/datum/heretic_knowledge/duel_stance,
		/datum/heretic_knowledge/spell/area_conversion,
	)
	required_atoms = list(
		/obj/structure/reagent_dispensers/watertank = 1,
		/obj/structure/table = 1,
	)
	result_atoms = list(/obj/structure/destructible/eldritch_crucible)
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/rifle
	name = "Lionhunter's Rifle"
	desc = "Позволяет трансмутировать любое баллистическое оружие, например, трубное ружье, с помощью шкуры \
		любого животного, доски дерева и камеры в винтовку Lionhunter. \
		Lionhunter - это дальнобойное баллистическое оружие с тремя выстрелами. \
		При стрельбе с близкого расстояния или по неодушевленным предметам эти выстрелы \
		действуют как обычные, хотя и слабые высококалиберные боеприпасы. Вы можете направить винтовку на далеких противников,\
		в результате чего выстрел нанесет значительно больший урон и нацелится на них."
	gain_text = "В антикварном магазине я встретил старика, который владел очень необычным оружием. \
		В то время я не мог его приобрести, но они показали мне, как они делали его много лет назад."
	next_knowledge = list(
		/datum/heretic_knowledge/duel_stance,
		/datum/heretic_knowledge/spell/area_conversion,
		/datum/heretic_knowledge/rifle_ammo,
	)
	required_atoms = list(
		/obj/item/gun/ballistic = 1,
		/obj/item/stack/sheet/animalhide = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/camera = 1,
	)
	result_atoms = list(/obj/item/gun/ballistic/rifle/lionhunter)
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/rifle_ammo
	name = "Lionhunter Rifle Ammunition (free)"
	desc = "Позволяет трансмутировать 3 баллистические гильзы (использованные или неиспользованные) любого калибра, \
		включая дробь, со шкурой любого животного, чтобы создать дополнительную обойму боеприпасов для винтовки Lionhunter."
	gain_text = "К оружию прилагались три грубых железных шара, предназначенных для использования в качестве боеприпасов. \
		Они были очень эффективны для простого железа, но быстро расходовались. Вскоре они у меня закончились. \
		Никакие запасные боеприпасы не помогали. Винтовка была своеобразна в том, чего она хотела."
	required_atoms = list(
		/obj/item/stack/sheet/animalhide = 1,
		/obj/item/ammo_casing = 3,
	)
	result_atoms = list(/obj/item/ammo_box/strilka310/lionhunter)
	cost = 0
	route = PATH_SIDE
	/// A list of calibers that the ritual will deny. Only ballistic calibers are allowed.
	var/static/list/caliber_blacklist = list(
		CALIBER_LASER,
		CALIBER_ENERGY,
		CALIBER_FOAM,
		CALIBER_ARROW,
		CALIBER_HARPOON,
		CALIBER_HOOK,
	)

/datum/heretic_knowledge/rifle_ammo/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	for(var/obj/item/ammo_casing/casing in atoms)
		if(!(casing.caliber in caliber_blacklist))
			continue

		// Remove any casings in the caliber_blacklist list from atoms
		atoms -= casing

	// We removed any invalid casings from the atoms list,
	// return to allow the ritual to fill out selected atoms with the new list
	return TRUE

/datum/heretic_knowledge/spell/rust_charge
	name = "Rust Charge"
	desc = "Рывок, который должен начаться на ржавом тайле, уничтожающий все ржавые объекты по пути. Наносит большой урон остальным и создает ржавчину вокруг вас во время рывка."
	gain_text = "Холмы сверкали, и по мере приближения мой разум начал метаться. Я быстро вернул свою решимость и устремился вперед, ведь последний этап будет самым коварным."
	next_knowledge = list(
		/datum/heretic_knowledge/spell/furious_steel,
		/datum/heretic_knowledge/spell/entropic_plume,
	)
	spell_to_add = /datum/action/cooldown/mob_cooldown/charge/rust
	cost = 1
	route = PATH_SIDE

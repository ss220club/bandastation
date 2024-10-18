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
	research_tree_icon_path = 'icons/obj/clothing/suits/armor.dmi'
	research_tree_icon_state = "eldritch_armor"
	research_tree_icon_frame = 12
	depth = 4

/datum/heretic_knowledge/crucible
	name = "Mawed Crucible"
	desc = "Позволяет трансмутировать переносной бак с водой и стол для создания Голодного горнила. \
		Голодное горнило позволяет варить мощные боевые и воспомогательные зелья, но взамен требует части тела и органы."
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
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "crucible"
	depth = 8

/datum/heretic_knowledge/rifle
	name = "Lionhunter's Rifle"
	desc = "Allows you to transmute a piece of wood, with hide \
		from any animal,and a camera to create the Lionhunter's rifle. \
		The Lionhunter's Rifle is a long ranged ballistic weapon with three shots. \
		These shots function as normal, albeit weak high-caliber munitions when fired from \
		close range or at inanimate objects. You can aim the rifle at distant foes, \
		causing the shot to mark your victim with your grasp and teleport you directly to them."
	gain_text = "I met an old man in an antique shop who wielded a very unusual weapon. \
		I could not purchase it at the time, but they showed me how they made it ages ago."
	next_knowledge = list(
		/datum/heretic_knowledge/duel_stance,
		/datum/heretic_knowledge/spell/area_conversion,
		/datum/heretic_knowledge/rifle_ammo,
	)
	required_atoms = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/stack/sheet/animalhide = 1,
		/obj/item/camera = 1,
	)
	result_atoms = list(/obj/item/gun/ballistic/rifle/lionhunter)
	cost = 1
	route = PATH_SIDE
	depth = 8
	research_tree_icon_path = 'icons/obj/weapons/guns/ballistic.dmi'
	research_tree_icon_state = "goldrevolver"

/datum/heretic_knowledge/rifle_ammo
	name = "Lionhunter Rifle Ammunition"
	desc = "Allows you to transmute 3 ballistic ammo casings (used or unused) of any caliber, \
		including shotgun shells to create an extra clip of ammunition for the Lionhunter Rifle."
	gain_text = "The weapon came with three rough iron balls, intended to be used as ammunition. \
		They were very effective, for simple iron, but used up quickly. I soon ran out. \
		No replacement munitions worked in their stead. It was peculiar in what it wanted."
	required_atoms = list(
		/obj/item/ammo_casing = 3,
	)
	result_atoms = list(/obj/item/ammo_box/strilka310/lionhunter)
	cost = 0
	route = PATH_SIDE
	research_tree_icon_path = 'icons/obj/weapons/guns/ammo.dmi'
	research_tree_icon_state = "310_strip"
	depth = 8
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
	depth = 10

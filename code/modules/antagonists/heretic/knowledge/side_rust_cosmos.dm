// Sidepaths for knowledge between Rust and Cosmos.

/datum/heretic_knowledge/essence
	name = "Priest's Ritual"
	desc = "Позволяет трансмутировать емкость с водой и осколок стекла в Колбу с мистической эссенцией. \
		Мистическую воду можно употреблять для мощного исцеления или давать язычникам для смертельного отравления."
	gain_text = "Это старый рецепт. Сова шепнула мне его. \
		Созданная Жрецом - Жидкость, которая есть, и которой нет."
	next_knowledge = list(
		/datum/heretic_knowledge/rust_regen,
		/datum/heretic_knowledge/spell/cosmic_runes,
		)
	required_atoms = list(
		/obj/structure/reagent_dispensers/watertank = 1,
		/obj/item/shard = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/beaker/eldritch)
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/entropy_pulse
	name = "Pulse of Entropy"
	desc = "Позволяет трансмутировать 10 железа и мусорный предмет, чтобы заполнить ржавчиной окружение вокруг руны."
	gain_text = "Реальность начинает нашептывать мне, чтобы дать ей энтропийный конец."
	required_atoms = list(
		/obj/item/stack/sheet/iron = 10,
		/obj/item/trash = 1,
	)
	cost = 0
	route = PATH_SIDE
	var/rusting_range = 8

/datum/heretic_knowledge/entropy_pulse/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	for(var/turf/nearby_turf in view(rusting_range, loc))
		if(get_dist(nearby_turf, loc) <= 1) //tiles on rune should always be rusted
			nearby_turf.rust_heretic_act()
		//we exclude closed turf to avoid exposing cultist bases
		if(prob(10) || isclosedturf(nearby_turf))
			continue
		nearby_turf.rust_heretic_act()
	return TRUE

/datum/heretic_knowledge/curse/corrosion
	name = "Curse of Corrosion"
	desc = "Позволяет трансмутировать кусачки, лужу рвоты и сердце, чтобы наложить проклятие болезни на члена экипажа. \
		При проклятии жертву будет постоянно рвать, а ее органы будут получать постоянный урон. Вы можете дополнительно снабдить предмет \
		к которому прикоснулась жертва или который покрыт кровью жертвы, чтобы придать увеличить длительность проклятия."
	gain_text = "Тело человечества временно. Их слабости невозможно остановить, как поддающееся ржавчине железо. Покажите им всем."
	next_knowledge = list(
		/datum/heretic_knowledge/spell/area_conversion,
		/datum/heretic_knowledge/spell/star_blast,
	)
	required_atoms = list(
		/obj/item/wirecutters = 1,
		/obj/effect/decal/cleanable/vomit = 1,
		/obj/item/organ/internal/heart = 1,
	)
	duration = 0.5 MINUTES
	duration_modifier = 4
	curse_color = "#c1ffc9"
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/curse/corrosion/curse(mob/living/carbon/human/chosen_mob, boosted = FALSE)
	to_chat(chosen_mob, span_danger("Вы чувствуете себя очень плохо..."))
	chosen_mob.apply_status_effect(/datum/status_effect/corrosion_curse)
	return ..()

/datum/heretic_knowledge/curse/corrosion/uncurse(mob/living/carbon/human/chosen_mob, boosted = FALSE)
	if(QDELETED(chosen_mob))
		return

	chosen_mob.remove_status_effect(/datum/status_effect/corrosion_curse)
	to_chat(chosen_mob, span_green("Вы начинаете чувствовать себя лучше."))
	return ..()

/datum/heretic_knowledge/summon/rusty
	name = "Rusted Ritual"
	desc = "Allows you to transmute a pool of vomit, some cable coil, and 5 sheets of titanium into a Rust Walker. \
		Rust Walkers excel at spreading rust and are moderately strong in combat."
	gain_text = "I combined my knowledge of creation with my desire for corruption. The Marshal knew my name, and the Rusted Hills echoed out."
	next_knowledge = list(
		/datum/heretic_knowledge/spell/area_conversion,
		/datum/heretic_knowledge/spell/star_blast,
	)
	required_atoms = list(
		/obj/effect/decal/cleanable/vomit = 1,
		/obj/item/stack/sheet/mineral/titanium = 5,
		/obj/item/stack/cable_coil = 15,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/rust_walker
	cost = 1
	route = PATH_SIDE
	poll_ignore_define = POLL_IGNORE_RUST_SPIRIT

/datum/heretic_knowledge/summon/rusty/cleanup_atoms(list/selected_atoms)
	var/obj/item/bodypart/head/ritual_head = locate() in selected_atoms
	if(!ritual_head)
		CRASH("[type] required a head bodypart, yet did not have one in selected_atoms when it reached cleanup_atoms.")

	// Spill out any brains or stuff before we delete it.
	ritual_head.drop_organs()
	return ..()

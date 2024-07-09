/**
 * # The path of VOID.
 * Spell names are in this language: PALI
 * Both are related: Pali-Buddhism-Nothingness-Void
 *
 * Goes as follows:
 *
 * Glimmer of Winter
 * Grasp of Void
 * Aristocrat's Way
 * > Sidepaths:
 *   Void Cloak
 *   Shattered Ritual
 *
 * Mark of Void
 * Ritual of Knowledge
 * Cone of Cold
 * Void Phase
 * > Sidepaths:
 *   Carving Knife
 *   Blood Siphon
 *
 * Seeking blade
 * Void Pull
 * > Sidepaths:
 *   Cleave
 *   Maid in the Mirror
 *
 * Waltz at the End of Time
 */
/datum/heretic_knowledge/limited_amount/starting/base_void
	name = "Glimmer of Winter"
	desc = "Открывает перед вами Путь пустоты. \
		Позволяет трансмутировать нож при отрицательных температурах в Пустотный клинок. \
		дновременно можно иметь только два."
	gain_text = "Я чувствую мерцание в воздухе, воздух вокруг меня становится холоднее. \
		Я начинаю осознавать пустоту существования. Что-то наблюдает за мной."
	next_knowledge = list(/datum/heretic_knowledge/void_grasp)
	required_atoms = list(/obj/item/knife = 1)
	result_atoms = list(/obj/item/melee/sickly_blade/void)
	route = PATH_VOID
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "void_blade"

/datum/heretic_knowledge/limited_amount/starting/base_void/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "ритуал провален, неподходящая локация!")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "ритуал провален, не достаточно холодно!")
		return FALSE

	return ..()

/datum/heretic_knowledge/void_grasp
	name = "Grasp of Void"
	desc = "Ваша Хватка Мансуса на время заглушает и охлаждает жертву."
	gain_text = "Я увидел холодного наблюдателя, который наблюдает за мной. Во мне поселился холод. \
		Он молчит. Это еще не конец таинства."
	next_knowledge = list(/datum/heretic_knowledge/cold_snap)
	cost = 1
	route = PATH_VOID
	depth = 3
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "grasp_void"

/datum/heretic_knowledge/void_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/void_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/void_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER

	if(!iscarbon(target))
		return

	var/mob/living/carbon/carbon_target = target
	carbon_target.adjust_silence(10 SECONDS)
	carbon_target.apply_status_effect(/datum/status_effect/void_chill)

/datum/heretic_knowledge/cold_snap
	name = "Aristocrat's Way"
	desc = "Дает иммунитет к низким температурам и устраняет потребность в дыхании. \
		Вы все еще можете получить повреждения из-за отсутствия давления."
	gain_text = "Я нашел нить холодного дыхания. Она привела меня в странное святилище, сплошь состоящее из кристаллов. \
		Полупрозрачное и белое изображение дворянина стояло передо мной."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/void_mark,
		/datum/heretic_knowledge/void_cloak,
		/datum/heretic_knowledge/limited_amount/risen_corpse,
	)
	cost = 1
	route = PATH_VOID
	research_tree_icon_path = 'icons/effects/effects.dmi'
	research_tree_icon_state = "the_freezer"
	depth = 4

/datum/heretic_knowledge/cold_snap/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	user.add_traits(list(TRAIT_NOBREATH, TRAIT_RESISTCOLD), type)

/datum/heretic_knowledge/cold_snap/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	user.remove_traits(list(TRAIT_RESISTCOLD, TRAIT_NOBREATH), type)

/datum/heretic_knowledge/mark/void_mark
	name = "Mark of Void"
	desc = "Ваша Хватка Мансуса теперь накладывает Метку пустоты. Метка срабатывает при атаке Пустотным клинком. \
		При срабатывании он заставляет жертву замолчать и быстро понижает температуру ее тела и окружающего воздуха."
	gain_text = "Порыв ветра? Мерцание в воздухе? Присутствие переполняет, \
		мои чувства начали предавать меня. Мой разум - мой собственный враг."
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/void)
	route = PATH_VOID
	mark_type = /datum/status_effect/eldritch/void

/datum/heretic_knowledge/knowledge_ritual/void
	next_knowledge = list(/datum/heretic_knowledge/spell/void_cone)
	route = PATH_VOID

/datum/heretic_knowledge/spell/void_cone
	name = "Void Blast"
	desc = "Дарует вам Void Blast - заклинание, которое выстреливает перед вами конусом замораживающего взрыва, \
		замораживая землю и всех находящихся в ней жертв."
	gain_text = "Каждая дверь, которую я открываю, сковывает мое тело. Я боюсь того, что находится за ними. Кто-то ждет меня, \
		и мои ноги начинают волочиться. Это... снег?"
	next_knowledge = list(/datum/heretic_knowledge/spell/void_phase)
	spell_to_add = /datum/action/cooldown/spell/cone/staggered/cone_of_cold/void
	cost = 1
	route = PATH_VOID
	depth = 7

/datum/heretic_knowledge/spell/void_phase
	name = "Void Phase"
	desc = "Дарует вам Void Phase, заклинание телепортации дальнего действия. \
		Дополнительно наносит урон язычникам вокруг вашей первоначальной и целевой цели."
	gain_text = "Сущность называет себя Аристократом. Он легко проходит сквозь воздух, \
		оставляя за собой резкий холодный ветер. Он исчезает, а я остаюсь в метели."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/void,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/blood_siphon,
		/datum/heretic_knowledge/rune_carver,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/void_phase
	cost = 1
	route = PATH_VOID
	depth = 8
	research_tree_icon_frame = 7

/datum/heretic_knowledge/blade_upgrade/void
	name = "Seeking Blade"
	desc = "Теперь вы можете атаковать отмеченные цели на расстоянии Пустотным клинком, телепортируясь прямо к ним."
	gain_text = "Мимолетные воспоминания, мимолетные ноги. Я отмечаю свой путь застывшей кровью на снегу. Покрытый и забытый."
	next_knowledge = list(/datum/heretic_knowledge/spell/void_pull)
	route = PATH_VOID
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_void"

/datum/heretic_knowledge/blade_upgrade/void/do_ranged_effects(mob/living/user, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(!target.has_status_effect(/datum/status_effect/eldritch))
		return

	var/dir = angle2dir(dir2angle(get_dir(user, target)) + 180)
	user.forceMove(get_step(target, dir))

	INVOKE_ASYNC(src, PROC_REF(follow_up_attack), user, target, blade)

/datum/heretic_knowledge/blade_upgrade/void/proc/follow_up_attack(mob/living/user, mob/living/target, obj/item/melee/sickly_blade/blade)
	blade.melee_attack_chain(user, target)

/datum/heretic_knowledge/spell/void_pull
	name = "Void Pull"
	desc = "Наделяет вас заклинанием Void Pull, которое притягивает всех ближайших язычников к вам, ненадолго оглушая их."
	gain_text = "Все мимолетно, но разве что-то остается? Я близок к завершению начатого. \
		Аристократ снова предстает передо мной. Он говорит мне, что я опоздал. Его притяжение огромно, я не могу повернуть назад."
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/void_final,
		/datum/heretic_knowledge/spell/cleave,
		/datum/heretic_knowledge/summon/maid_in_mirror,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/void_pull
	cost = 1
	route = PATH_VOID
	depth = 10
	research_tree_icon_frame = 6

/datum/heretic_knowledge/ultimate/void_final
	name = "Waltz at the End of Time"
	desc = "Ритуал вознесения Пути пустоты. \
		Принесите 3 трупа к руне трансмутации при отрицательных температурах, чтобы завершить риAdditionally, you will become immune to the effects of space.туал. \
		После завершения вызывает сильный шторм пустотного снега, \
		который обрушивается на станцию, замораживая и повреждая язычников. Те, кто находится поблизости, замолчат и замерзнут еще быстрее. \
		Кроме того, у вас появится иммунитет к воздействию космоса."
	gain_text = "Мир погружается во тьму. Я стою в пустом мире, с неба падают мелкие хлопья льда. \
		Аристократ стоит передо мной, призывая. Мы будем играть вальс под шепот умирающей реальности, \
		пока мир разрушается на наших глазах. Пустота вернет все в ничто, УЗРИТЕ МОЕ ВОЗНЕСЕНИЕ!"
	route = PATH_VOID
	ascension_achievement = /datum/award/achievement/misc/void_ascension
	///soundloop for the void theme
	var/datum/looping_sound/void_loop/sound_loop
	///Reference to the ongoing voidstrom that surrounds the heretic
	var/datum/weather/void_storm/storm

/datum/heretic_knowledge/ultimate/void_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "ритуал провален, неподходящая локация!")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "ритуал провален, не достаточно холодно!")
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/void_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce(
		text = "[generate_heretic_text()] Дворянин пустоты [user.real_name] прибыл, танцуя Вальс, уничтожающий миры! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = 'sound/ambience/antag/heretic/ascend_void.ogg',
		color_override = "blue",
	)
	ADD_TRAIT(user, TRAIT_RESISTLOWPRESSURE, MAGIC_TRAIT)

	// Let's get this show on the road!
	sound_loop = new(user, TRUE, TRUE)
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/heretic_knowledge/ultimate/void_final/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	on_death() // Losing is pretty much dying. I think
	RegisterSignals(user, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Any non-heretics nearby the heretic ([source])
 * are constantly silenced and battered by the storm.
 *
 * Also starts storms in any area that doesn't have one.
 */
/datum/heretic_knowledge/ultimate/void_final/proc/on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	for(var/mob/living/carbon/close_carbon in view(5, source))
		if(IS_HERETIC_OR_MONSTER(close_carbon))
			continue
		close_carbon.adjust_silence_up_to(2 SECONDS, 20 SECONDS)

	// Telegraph the storm in every area on the station.
	var/list/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	if(!storm)
		storm = new /datum/weather/void_storm(station_levels)
		storm.telegraph()

	// When the heretic enters a new area, intensify the storm in the new area,
	// and lessen the intensity in the former area.
	var/area/source_area = get_area(source)
	if(!storm.impacted_areas[source_area])
		storm.former_impacted_areas |= storm.impacted_areas
		storm.impacted_areas = list(source_area)
		storm.update_areas()

/**
 * Signal proc for [COMSIG_LIVING_DEATH].
 *
 * Stop the storm when the heretic passes away.
 */
/datum/heretic_knowledge/ultimate/void_final/proc/on_death(datum/source)
	SIGNAL_HANDLER

	if(sound_loop)
		sound_loop.stop()
	if(storm)
		storm.end()
		QDEL_NULL(storm)

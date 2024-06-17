/**
 * # The path of Moon.
 *
 * Goes as follows:
 *
 * Moonlight Troupe
 * Grasp of Lunacy
 * Smile of the moon
 * > Sidepaths:
 *   Mind Gate
 *   Ashen Eyes
 *
 * Mark of Moon
 * Ritual of Knowledge
 * Lunar Parade
 * Moonlight Amulet
 * > Sidepaths:
 *   Curse of Paralasys
 *   Unfathomable Curio
 * 	 Unsealed Arts
 *
 * Moonlight blade
 * Ringleaders Rise
 * > Sidepaths:
 *   Ashen Ritual
 *
 * Last Act
 */
/datum/heretic_knowledge/limited_amount/starting/base_moon
	name = "Moonlight Troupe"
	desc = "Открывает перед вами Путь луны. \
		Позволяет трансмутировать 2 листа железа и нож в Лунный клинок. \
		Одновременно можно иметь только два."
	gain_text = "Под лунным светом смех отдается эхом."
	next_knowledge = list(/datum/heretic_knowledge/moon_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/iron = 2,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/moon)
	route = PATH_MOON

/datum/heretic_knowledge/base_moon/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	add_traits(user ,TRAIT_EMPATH, REF(src))

/datum/heretic_knowledge/moon_grasp
	name = "Grasp of Lunacy"
	desc = "Ваша Хватка Мансуса заставит жертву галлюцинировать, что все вокруг - лунная масса, \
		и на короткое время скроет вашу личность."
	gain_text = "Труппа на стороне луны показала мне правду, и я принял её."
	next_knowledge = list(/datum/heretic_knowledge/spell/moon_smile)
	cost = 1
	route = PATH_MOON

/datum/heretic_knowledge/moon_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/moon_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/moon_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER
	source.apply_status_effect(/datum/status_effect/moon_grasp_hide)

	if(!iscarbon(target))
		return
	var/mob/living/carbon/carbon_target = target
	to_chat(carbon_target, span_danger("Сверху доносится смех, отдающийся эхом."))
	carbon_target.cause_hallucination(/datum/hallucination/delusion/preset/moon, "delusion/preset/moon hallucination caused by mansus grasp")
	carbon_target.mob_mood.set_sanity(carbon_target.mob_mood.sanity-30)

/datum/heretic_knowledge/spell/moon_smile
	name = "Smile of the moon"
	desc = "Дает вам заклинание Smile of the moon, позволяющее на расстоянии заглушить, ослепить, оглушить и сбить с ног цель \
		на время, зависящее от ее рассудка."
	gain_text = "Луна улыбается всем нам, и те, кто видит ее правдивую сторону, могут приносить её радость."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/moon_mark,
		/datum/heretic_knowledge/medallion,
		/datum/heretic_knowledge/spell/mind_gate,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/moon_smile
	cost = 1
	route = PATH_MOON

/datum/heretic_knowledge/mark/moon_mark
	name = "Mark of Moon"
	desc = "Ваша Хватка Мансуса теперь накладывает Метку луны, которая накладывает пацифизм на цель, пока ее не атакуют. \
		Метка может быть активирована вашим Лунным клинком, оставляя жертву в замешательстве."
	gain_text = "Труппа на луне могла танцевать весь день \
		и в этом танце луна улыбалась нам \
		но когда наступала ночь, ее улыбка тусклела, так как была вынуждена смотреть на землю."
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/moon)
	route = PATH_MOON
	mark_type = /datum/status_effect/eldritch/moon

/datum/heretic_knowledge/knowledge_ritual/moon
	next_knowledge = list(/datum/heretic_knowledge/spell/moon_parade)
	route = PATH_MOON

/datum/heretic_knowledge/spell/moon_parade
	name = "Lunar Parade"
	desc = "Дает вам заклинание Lunar Parade, которое через короткую задержку посылает вперед карнавал. \
		Те, в кого попал карнавал, вынуждены присоединиться к параду и страдать от галлюцинаций."
	gain_text = "Музыка, как отражение души, побуждала их, и они, словно мотыльки на пламя, следовали за ней."
	next_knowledge = list(/datum/heretic_knowledge/moon_amulet)
	spell_to_add = /datum/action/cooldown/spell/pointed/projectile/moon_parade
	cost = 1
	route = PATH_MOON


/datum/heretic_knowledge/moon_amulet
	name = "Moonlight Amulet"
	desc = "Позволяет трансмутировать 2 листа стекла, сердце и галстук, чтобы создать Moonlight Amulet. \
			Если предмет использован на том, у кого слабый рассудок, они становятся берсерком, нападая на всех подряд; \
			если рассудок не достаточно низок, то уменьшается их настроение."
	gain_text = "Во главе парада стоял он, луна сгустилась в единную массу, отражение души."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/moon,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/unfathomable_curio,
		/datum/heretic_knowledge/curse/paralysis,
		/datum/heretic_knowledge/painting,
	)
	required_atoms = list(
		/obj/item/organ/internal/heart = 1,
		/obj/item/stack/sheet/glass = 2,
		/obj/item/clothing/neck/tie = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/heretic_focus/moon_amulet)
	cost = 1
	route = PATH_MOON

/datum/heretic_knowledge/blade_upgrade/moon
	name = "Moonlight Blade"
	desc = "Ваш клинок теперь наносит урон мозгу и рассудку, а также вызывает случайные галлюцинации."
	gain_text = "Его остроумие было острым, как клинок, оно прорезало ложь, чтобы принести нам радость."
	next_knowledge = list(/datum/heretic_knowledge/spell/moon_ringleader)
	route = PATH_MOON

/datum/heretic_knowledge/blade_upgrade/moon/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target)
		return

	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 100)
	target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/body), \
			"upgraded path of moon blades", \
		)
	target.emote(pick("giggle", "laugh"))
	target.mob_mood.set_sanity(target.mob_mood.sanity - 10)

/datum/heretic_knowledge/spell/moon_ringleader
	name = "Ringleaders Rise"
	desc = "Дает вам Ringleaders Rise, заклинание по области, которое наносит больше урона мозгу в зависимости от отсутствующего рассудка у целей, \
			также вызывает им галлюцинации, больше тем, у кого мало рассудка. \
			Если их рассудок достаточно слабый, они обезумеют и потеряют половину рассудка."
	gain_text = "Взял его за руку, мы поднялись, и те, кто видел правду, поднялись вместе с нами. \
		Шпрехшталмейстер указал вверх, и тусклый свет правды осветил нас еще больше."
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/moon_final,
		/datum/heretic_knowledge/summon/ashy,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/moon_ringleader
	cost = 1
	route = PATH_MOON

/datum/heretic_knowledge/ultimate/moon_final
	name = "The Last Act"
	desc = "Ритуал вознесения Пути луны. \
		Принесите 3 трупа с более чем 50 урона мозгу на руну трансмутации, чтобы завершить ритуал \
		При завершении, вы становитесь предвестником безумия и получаете ауру пассивного снижения рассудка, \
		увеличения замешательства, и, если их рассудок достаточно низкий, урона мозгу и ослепления. \
		Одна пятая экипажа превратится в аколитов и будет следовать вашим приказам, также они получат Moonlight Amulet"
	gain_text = "Мы нырнули вниз, к толпе, его душа отделилась в поисках более великой авантюры, \
		туда, откуда Шпрехшталмейстер начал парад, и я продолжу его до самой кончины солнца \
		УЗРИТЕ МОЕ ВОЗНЕСЕНИЕ, ЛУНА УЛЫБНЕТСЯ РАЗ И НАВСЕГДА!"
	route = PATH_MOON

/datum/heretic_knowledge/ultimate/moon_final/is_valid_sacrifice(mob/living/sacrifice)

	var/brain_damage = sacrifice.get_organ_loss(ORGAN_SLOT_BRAIN)
	// Checks if our target has enough brain damage
	if(brain_damage < 50)
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/moon_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/datum/antagonist/heretic/heretic_datum = IS_HERETIC(user)
	priority_announce(
		text = "[generate_heretic_text()] Смейтесь, ибо Шпрехшталмейстер [user.real_name] вознесся! \
				Правда наконец поглотит ложь! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = 'sound/ambience/antag/heretic/ascend_moon.ogg',
		color_override = "pink",
	)

	user.client?.give_award(/datum/award/achievement/misc/moon_ascension, user)
	ADD_TRAIT(user, TRAIT_MADNESS_IMMUNE, REF(src))
	heretic_datum.add_team_hud(user, /datum/antagonist/lunatic)

	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	// Roughly 1/5th of the station will rise up as lunatics to the heretic
	for (var/mob/living/carbon/human/crewmate as anything in GLOB.human_list)
		// How many lunatics we have
		var/amount_of_lunatics = 0
		// Where the crewmate is, used to check their z-level
		var/turf/crewmate_turf = get_turf(crewmate)
		var/crewmate_z = crewmate_turf?.z
		if(isnull(crewmate.mind))
			continue
		if(crewmate.stat != CONSCIOUS)
			continue
		if(!is_station_level(crewmate_z))
			continue
		// Heretics, lunatics and monsters shouldn't become lunatics because they either have a master or have a mansus grasp
		if(IS_HERETIC_OR_MONSTER(crewmate))
			to_chat(crewmate, span_boldwarning("Вознесение [user] влияет на слабовольных. Их разумы будут разрушены." ))
			continue
		// Mindshielded and anti-magic folks are immune against this effect because this is a magical mind effect
		if(HAS_TRAIT(crewmate, TRAIT_MINDSHIELD) || crewmate.can_block_magic(MAGIC_RESISTANCE))
			to_chat(crewmate, span_boldwarning("Вы чувствуете, что защитились от чего-то." ))
			continue
		if(amount_of_lunatics > length(GLOB.human_list) * 0.2)
			to_chat(crewmate, span_boldwarning("Вы чувствуете неспокойство, как будто на мгновение что-то смотрело на вас." ))
			continue
		var/datum/antagonist/lunatic/lunatic = crewmate.mind.add_antag_datum(/datum/antagonist/lunatic)
		lunatic.set_master(user.mind, user)
		var/obj/item/clothing/neck/heretic_focus/moon_amulet/amulet = new(crewmate_turf)
		var/static/list/slots = list(
			"neck" = ITEM_SLOT_NECK,
			"hands" = ITEM_SLOT_HANDS,
			"backpack" = ITEM_SLOT_BACKPACK,
			"right pocket" = ITEM_SLOT_RPOCKET,
			"left pocket" = ITEM_SLOT_RPOCKET,
		)
		crewmate.equip_in_one_of_slots(amulet, slots, qdel_on_fail = FALSE)
		crewmate.emote("laugh")
		amount_of_lunatics += 1

/datum/heretic_knowledge/ultimate/moon_final/proc/on_life(mob/living/source, seconds_per_tick, times_fired)
	var/obj/effect/moon_effect = /obj/effect/temp_visual/moon_ringleader
	SIGNAL_HANDLER

	visible_hallucination_pulse(
		center = get_turf(source),
		radius = 7,
		hallucination_duration = 60 SECONDS
	)

	for(var/mob/living/carbon/carbon_view in view(5, source))
		var/carbon_sanity = carbon_view.mob_mood.sanity
		if(carbon_view.stat != CONSCIOUS)
			continue
		if(IS_HERETIC_OR_MONSTER(carbon_view))
			continue
		new moon_effect(get_turf(carbon_view))
		carbon_view.adjust_confusion(2 SECONDS)
		carbon_view.mob_mood.set_sanity(carbon_sanity - 5)
		if(carbon_sanity < 30)
			if(SPT_PROB(20, seconds_per_tick))
				to_chat(carbon_view, span_warning("вы чувствуете, как ваш разум разрушается!"))
			carbon_view.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
		if(carbon_sanity < 10)
			if(SPT_PROB(20, seconds_per_tick))
				to_chat(carbon_view, span_warning("оно эхом отдается в вас!"))
			visible_hallucination_pulse(
				center = get_turf(carbon_view),
				radius = 7,
				hallucination_duration = 50 SECONDS
			)
			carbon_view.adjust_temp_blindness(5 SECONDS)

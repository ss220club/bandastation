/**
 * # The path of Ash.
 *
 * Goes as follows:
 *
 * Nightwatcher's Secret
 * Grasp of Ash
 * Ashen Passage
 * > Sidepaths:
 *   Scorching Shark
 *   Ashen Eyes
 *
 * Mark of Ash
 * Ritual of Knowledge
 * Fire Blast
 * Mask of Madness
 * > Sidepaths:
 *   Space Phase
 *   Curse of Paralysis
 *
 * Fiery Blade
 * Nightwatcher's Rebirth
 * > Sidepaths:
 *   Ashen Ritual
 *   Eldritch Coin
 *
 * Ashlord's Rite
 */
/datum/heretic_knowledge/limited_amount/starting/base_ash
	name = "Nightwatcher's Secret"
	desc = "Открывает перед вами путь пепла. \
		Позволяет трансмутировать спичку и нож в пепельный клинок. \
		Одновременно можно иметь только два."
	gain_text = "Городская стража знает своих дозорных. Если вы спросите их ночью, они могут рассказать вам о пепельном фонаре."
	next_knowledge = list(/datum/heretic_knowledge/ashen_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/match = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/ash)
	route = PATH_ASH

/datum/heretic_knowledge/ashen_grasp
	name = "Grasp of Ash"
	desc = "Ваша Хватка Мансуса обожжет глаза жертвы, нанося глазам урон и затуманивания их зрение."
	gain_text = "Первым из них был Ночной дозорный, с его измены все и началось. \
		Их фонарь, истлевший до пепла, их дозор, отсутствовавший."
	next_knowledge = list(/datum/heretic_knowledge/spell/ash_passage)
	cost = 1
	route = PATH_ASH

/datum/heretic_knowledge/ashen_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/ashen_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/ashen_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER

	if(target.is_blind())
		return

	if(!target.get_organ_slot(ORGAN_SLOT_EYES))
		return

	to_chat(target, span_danger("Яркий зеленый свет ужасно жжет глаза!"))
	target.adjustOrganLoss(ORGAN_SLOT_EYES, 15)
	target.set_eye_blur_if_lower(20 SECONDS)

/datum/heretic_knowledge/spell/ash_passage
	name = "Ashen Passage"
	desc = "Дает вам Ashen Passage, заклинание, позволяющее исчезать и перемещаться на короткое расстояние, игнорируя стены"
	gain_text = "Он знал, как ходить между мирами."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/ash_mark,
		/datum/heretic_knowledge/summon/fire_shark,
		/datum/heretic_knowledge/medallion,
	)
	spell_to_add = /datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash
	cost = 1
	route = PATH_ASH

/datum/heretic_knowledge/mark/ash_mark
	name = "Mark of Ash"
	desc = "Ваша Хватка Мансуса теперь накладывает Метку пепла. Метка срабатывает при атаке вашим Пепельным клинком. \
		При срабатывании жертва получает дополнительный урон стаминой и ожогами, а метка передается всем находящимся поблизости язычникам. \
		Наносимый урон уменьшается с каждой передачей. \
		Активация метки также значительно уменьшает перезарядку Хватки Мансуса."
	gain_text = "Он был очень конкретным человеком, всегда бдительным в ночное время. \
		Но, несмотря на свои обязанности, он регулярно проходил через Мансе с высоко поднятым горящим фонарем. \
		Он ярко сиял во тьме, пока пламя не начинало угасать."
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/ash)
	route = PATH_ASH
	mark_type = /datum/status_effect/eldritch/ash

/datum/heretic_knowledge/mark/ash_mark/trigger_mark(mob/living/source, mob/living/target)
	. = ..()
	if(!.)
		return

	// Also refunds 75% of charge!
	var/datum/action/cooldown/spell/touch/mansus_grasp/grasp = locate() in source.actions
	if(grasp)
		grasp.next_use_time -= round(grasp.cooldown_time*0.75)
		grasp.build_all_button_icons()

/datum/heretic_knowledge/knowledge_ritual/ash
	next_knowledge = list(/datum/heretic_knowledge/spell/fire_blast)
	route = PATH_ASH

/datum/heretic_knowledge/spell/fire_blast
	name = "Volcano Blast"
	desc = "Дает вам Volcano Blast - заклинание, которое после короткой зарядки выстреливает лучом энергии \
		в ближайшего врага, поджигая и обжигая его. Если они не потушат себя, \
		луч продолжит движение к другой цели."
	gain_text = "Ни один огонь не был достаточно горячим, чтобы разжечь их. Ни один огонь не был достаточно ярким, чтобы спасти их. Ни один огонь не вечен."
	next_knowledge = list(/datum/heretic_knowledge/mad_mask)
	spell_to_add = /datum/action/cooldown/spell/charged/beam/fire_blast
	cost = 1
	route = PATH_ASH


/datum/heretic_knowledge/mad_mask
	name = "Mask of Madness"
	desc = "Позволяет трансмутировать любую маску, четыре свечи, станбатон и печень, чтобы создать Маску безумия. \
		Маска вселяет страх в язычников, которые становятся ее свидетелями, вызывая у них потерю стамины, галлюцинации и безумие. \
		Его также можно насильно надеть на язычника, чтобы он не смог его снять..."
	gain_text = "Ночной дозорный был потерян. Так считал Дозор. И все же он ходил по миру, незамеченный массами."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/organ/internal/liver = 1,
		/obj/item/melee/baton/security = 1,  // Technically means a cattleprod is valid
		/obj/item/clothing/mask = 1,
		/obj/item/flashlight/flare/candle = 4,
	)
	result_atoms = list(/obj/item/clothing/mask/madness_mask)
	cost = 1
	route = PATH_ASH

/datum/heretic_knowledge/blade_upgrade/ash
	name = "Fiery Blade"
	desc = "Ваш клинок теперь поджигает врагов при атаке."
	gain_text = "Он вернулся, с клинком в руке, он размахивал и размахивал, когда пепел падал с неба. \
		Его город, люди, за которыми он поклялся наблюдать... и он наблюдал, пока все они сгорали дотла."
	next_knowledge = list(/datum/heretic_knowledge/spell/flame_birth)
	route = PATH_ASH

/datum/heretic_knowledge/blade_upgrade/ash/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target)
		return

	target.adjust_fire_stacks(1)
	target.ignite_mob()

/datum/heretic_knowledge/spell/flame_birth
	name = "Nightwatcher's Rebirth"
	desc = "Дарует вам Nightwatcher's Rebirth, заклинание, которое потушит вас \
		и обжигает всех ближайших язычников, которые в данный момент горят, исцеляя вас за каждую пораженную цель. \
		Если цель находится в критическом состоянии, она мгновенно умрёт."
	gain_text = "Огонь был неизбежным, и все же жизнь оставалась в его обугленном теле. \
		Ночной дозорный был конкретным человеком, всегда бдительным."
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/ash_final,
		/datum/heretic_knowledge/summon/ashy,
		/datum/heretic_knowledge/eldritch_coin,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/fiery_rebirth
	cost = 1
	route = PATH_ASH

/datum/heretic_knowledge/ultimate/ash_final
	name = "Ashlord's Rite"
	desc = "Ритуал вознесения Пути пепла. \
		Принесите 3 горящих трупа или хаска к руне трансмутации, чтобы завершить ритуал. \
		После завершения вы становитесь предвестником пламени и получаете две способности. \
		Cascade, который вызывает массивное, растущее огненное кольцо вокруг вас, \
		и Oath of Flame, заставляя вас пассивно создавать кольцо пламени, когда вы идете. \
		Некоторые известные заклинания пепла также будут усилены. \
		tУ вас также появится иммунитет к огню, космосу и подобным опасностям окружающей среды."
	gain_text = "Дозор мертв, и Ночной дозорный сгорел вместе с ним. И все же его огонь горит вечно, \
		ибо он принес человечеству обряд! Его взгляд продолжается, и теперь я един с пламенем, \
		УЗРИТЕ МОЕ ВОЗНЕСЕНИЕ, ПЕПЕЛЬНЫЙ ФОНАРЬ ВОСПЛАМЕНИТСЯ ВНОВЬ!"
	route = PATH_ASH
	/// A static list of all traits we apply on ascension.
	var/static/list/traits_to_apply = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_NOFIRE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)

/datum/heretic_knowledge/ultimate/ash_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return

	if(sacrifice.on_fire)
		return TRUE
	if(HAS_TRAIT_FROM(sacrifice, TRAIT_HUSK, BURN))
		return TRUE
	return FALSE

/datum/heretic_knowledge/ultimate/ash_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce(
		text = "[generate_heretic_text()] Бойтесь пламени, ибо Пепельный лорд, [user.real_name], вознесся! Пламя поглотит всех! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = 'sound/ambience/antag/heretic/ascend_ash.ogg',
		color_override = "pink",
	)

	var/datum/action/cooldown/spell/fire_sworn/circle_spell = new(user.mind)
	circle_spell.Grant(user)

	var/datum/action/cooldown/spell/fire_cascade/big/screen_wide_fire_spell = new(user.mind)
	screen_wide_fire_spell.Grant(user)

	var/datum/action/cooldown/spell/charged/beam/fire_blast/existing_beam_spell = locate() in user.actions
	if(existing_beam_spell)
		existing_beam_spell.max_beam_bounces *= 2 // Double beams
		existing_beam_spell.beam_duration *= 0.66 // Faster beams
		existing_beam_spell.cooldown_time *= 0.66 // Lower cooldown

	var/datum/action/cooldown/spell/aoe/fiery_rebirth/fiery_rebirth = locate() in user.actions
	fiery_rebirth?.cooldown_time *= 0.16

	user.client?.give_award(/datum/award/achievement/misc/ash_ascension, user)
	if(length(traits_to_apply))
		user.add_traits(traits_to_apply, MAGIC_TRAIT)

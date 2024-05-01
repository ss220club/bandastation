/**
 * # The path of Lock.
 *
 * Goes as follows:
 *
 * A Steward's Secret
 * Grasp of Lock
 * Key Keeper’s Burden
 * > Sidepaths:
 *   Mindgate
 * Concierge's Rite
 * Mark Of Lock
 * Ritual of Knowledge
 * Burglar's Finesse
 * > Sidepaths:
 *   Opening Blast
 *   Unfathomable Curio
 * 	 Unsealed arts
 *
 * Opening Blade
 * Caretaker’s Last Refuge
 * > Sidepaths:
 * 	 Apetra Vulnera
 *
 * Unlock the Labyrinth
 */
/datum/heretic_knowledge/limited_amount/starting/base_knock
	name = "A Steward's Secret"
	desc = "Открывает перед вами Путь замка. \
		Позволяет трансмутировать нож и монтировку в Ключ-клинок. \
		Одновременно можно иметь только два, а также он действует как быстрая монтировка. \
		К тому же, они помещаются в пояса для инструментов."
	gain_text = "Запертный лабиринт ведет к свободе. Но только пойманные Управляющие знают верный путь."
	next_knowledge = list(/datum/heretic_knowledge/lock_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/crowbar = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/lock)
	limit = 2
	route = PATH_LOCK

/datum/heretic_knowledge/lock_grasp
	name = "Grasp of Lock"
	desc = "Ваша Хватка Мансуса позволяет получить доступ ко всему! ПКМ на шлюзу или шкафу отопрет их. \
		ДНК замки мехов будут очищены, а пилот извлечен. Также работает на консолях. \
		Издает характерный звук стучка при использовании."
	gain_text = "Ничто не останется закрытым от моего прикосновения."
	next_knowledge = list(/datum/heretic_knowledge/key_ring)
	cost = 1
	route = PATH_LOCK

/datum/heretic_knowledge/lock_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/lock_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/lock_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER
	var/obj/item/clothing/under/suit = target.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(istype(suit) && suit.adjusted == NORMAL_STYLE)
		suit.toggle_jumpsuit_adjust()
		suit.update_appearance()

/datum/heretic_knowledge/lock_grasp/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)
	SIGNAL_HANDLER

	if(ismecha(target))
		var/obj/vehicle/sealed/mecha/mecha = target
		mecha.dna_lock = null
		for(var/mob/living/occupant as anything in mecha.occupants)
			if(isAI(occupant))
				continue
			mecha.mob_exit(occupant, randomstep = TRUE)
	else if(istype(target,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/door = target
		door.unbolt()
	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/computer = target
		computer.authenticated = TRUE
		computer.balloon_alert(source, "unlocked")

	var/turf/target_turf = get_turf(target)
	SEND_SIGNAL(target_turf, COMSIG_ATOM_MAGICALLY_UNLOCKED, src, source)
	playsound(target, 'sound/magic/hereticknock.ogg', 100, TRUE, -1)

	return COMPONENT_USE_HAND

/datum/heretic_knowledge/key_ring
	name = "Key Keeper’s Burden"
	desc = "Позволяет трансмутировать кошелек, железный прут и ИД-карта, чтобы создать Мистическую карту. \
		Ударьте ею по двум шлюзам, чтобы создать спаренный портал, который будет телепортировать вас между ними, а не-еретиков случайно. \
		С помощью Ctrl-Click по карте, вы можете инвертировать поведение созданных порталов. \
		Каждая такая карта может иметь только одну пару порталов. \
		Также, она выглядит и работает как обычная ИД-карта. \
		Атаки по карте обычными ИД-картами поглощает их и получает их доступ. При использовании в руке, она может изменить свой внешний вид на любую поглощенную. \
		Оригинальная ИД-карта, использованная в ритуале, также поглощается."
	gain_text = "Хранитель усмехнулся. \"Эти пластиковые прямоугольники - насмешка над ключами, и я проклинаю каждую дверь, которая их требует.\""
	required_atoms = list(
		/obj/item/storage/wallet = 1,
		/obj/item/stack/rods = 1,
		/obj/item/card/id = 1,
	)
	result_atoms = list(/obj/item/card/id/advanced/heretic)
	next_knowledge = list(
		/datum/heretic_knowledge/mark/lock_mark,
		/datum/heretic_knowledge/spell/mind_gate,
	)
	cost = 1
	route = PATH_LOCK

/datum/heretic_knowledge/mark/lock_mark
	name = "Mark of Lock"
	desc = "Ваша Хватка Мансуса теперь накладывает Метку замка. \
		Активация метки закроет доступ ко всем проходам на время действие метки. \
		У них не будет доступа к чему либо, даже публичные шлюзы будут отклонять их."
	gain_text = "Привратница была коррумпированным Управляющим. Она мешала своим собратьям ради собственного извращенного развлечения."
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/lock)
	route = PATH_LOCK
	mark_type = /datum/status_effect/eldritch/lock

/datum/heretic_knowledge/knowledge_ritual/lock
	next_knowledge = list(/datum/heretic_knowledge/limited_amount/concierge_rite)
	route = PATH_LOCK

/datum/heretic_knowledge/limited_amount/concierge_rite // item that creates 3 max at a time heretic only barriers, probably should limit to 1 only, holy people can also pass
	name = "Concierge's Rite"
	desc = "Позволяет трансмутировать белый карандаш, деревянную доску и мультитул, чтобы создать Справочник лабиринта. \
		Оно может материализовать на расстоянии баррикаду, через которую могут пройти только вы и люди с сопротивлением против магии. 3 использования."
	gain_text = "Консьерж записал мое имя в Справочник. \"Добро пожаловать в ваш новый дом, коллега Управляющий.\""
	required_atoms = list(
		/obj/item/toy/crayon/white = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/multitool = 1,
	)
	result_atoms = list(/obj/item/heretic_labyrinth_handbook)
	next_knowledge = list(/datum/heretic_knowledge/spell/burglar_finesse)
	cost = 1
	route = PATH_LOCK

/datum/heretic_knowledge/spell/burglar_finesse
	name = "Burglar's Finesse"
	desc = "Дарует вам заклинание, Burglar's Finesse, которое \
		кладет случайный предмет из сумки жертвы в вашу руку."
	gain_text = "Общение с духами Взломщиками не одобряется, но Управляющий всегда хочет узнавать о новых дверях."
	next_knowledge = list(
		/datum/heretic_knowledge/spell/opening_blast,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/blade_upgrade/flesh/lock,
		/datum/heretic_knowledge/unfathomable_curio,
		/datum/heretic_knowledge/painting,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/burglar_finesse
	cost = 1
	route = PATH_LOCK

/datum/heretic_knowledge/blade_upgrade/flesh/lock //basically a chance-based weeping avulsion version of the former
	name = "Opening Blade"
	desc = "Ваш клинок теперь может накладывать сильное кровотечение при атаке."
	gain_text = "Пилигрим-Хирург не был Управляющим. Тем не менее, его клинки и швы оказались достойны их ключей."
	next_knowledge = list(/datum/heretic_knowledge/spell/caretaker_refuge)
	route = PATH_LOCK
	wound_type = /datum/wound/slash/flesh/critical
	var/chance = 35

/datum/heretic_knowledge/blade_upgrade/flesh/lock/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(prob(chance))
		return ..()

/datum/heretic_knowledge/spell/caretaker_refuge
	name = "Caretaker’s Last Refuge"
	desc = "Заклинание, позволяющее становиться прозрачным и безтелесным. Невозможно использовать рядом с живыми разумными существами. \
		Пока вы находитесь в убежище, вы не можете использовать руки и заклинания, и вы имеете иммунитет к замедлению. \
		Вы неуязвимы, но также не можете ничему вредить. При попадании анти-магией, эффект прерывается."
	gain_text = "Страж и Гончая охотились за мной из ревности. Но я раскрыл свою форму, став лишь неприкосаемой дымкой."
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/lock_final,
		/datum/heretic_knowledge/spell/apetra_vulnera,
	)
	route = PATH_LOCK
	spell_to_add = /datum/action/cooldown/spell/caretaker
	cost = 1

/datum/heretic_knowledge/ultimate/lock_final
	name = "Unlock the Labyrinth"
	desc = "Ритуал вознесения Пути замка. \
		Принесите 3 трупа без органов в их торсе к руне трансмутации, чтобы завершить ритуал. \
		При завершении, вы сможете превращаться в усиленных мистических существ, \
		а ваши ключ-клинки становятся еще смертоноснее. \
		Также, вы откроете разрыв к сердцу Лабиринта; \
		разрыв в реальности, который будет находиться на месте ритуала. \
		Мистические существа будут беспрерывно выходить из разлома, \
		и они будут подчиненны вам."
	gain_text = "Управляющие направляли меня, и я направил их. \
		Мои враги были Замками, а мои клинки - Ключами! \
		Лабиринт теперь не будет Заперт, свобода будет нашей! УЗРИТЕ НАС!"
	required_atoms = list(/mob/living/carbon/human = 3)
	route = PATH_LOCK

/datum/heretic_knowledge/ultimate/lock_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(LAZYLEN(body.get_organs_for_zone(BODY_ZONE_CHEST)))
			to_chat(user, span_hierophant_warning("[body] имеет органы внутри их торса."))
			continue

		selected_atoms += body

	if(!LAZYLEN(selected_atoms))
		loc.balloon_alert(user, "ритуал провален, недостаточно подходящих тел!")
		return FALSE
	return TRUE

/datum/heretic_knowledge/ultimate/lock_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce(
		text = "Пространственная аномалия Дельта-класса обнар[generate_heretic_text()] Реальность разрушена, разорвана. Врата открыты, двери открыты, [user.real_name] вознесся! Бойтесь нашествия! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = 'sound/ambience/antag/heretic/ascend_knock.ogg',
		color_override = "pink",
	)
	user.client?.give_award(/datum/award/achievement/misc/lock_ascension, user)

	// buffs
	var/datum/action/cooldown/spell/shapeshift/eldritch/ascension/transform_spell = new(user.mind)
	transform_spell.Grant(user)

	user.client?.give_award(/datum/award/achievement/misc/lock_ascension, user)
	var/datum/antagonist/heretic/heretic_datum = IS_HERETIC(user)
	var/datum/heretic_knowledge/blade_upgrade/flesh/lock/blade_upgrade = heretic_datum.get_knowledge(/datum/heretic_knowledge/blade_upgrade/flesh/lock)
	blade_upgrade.chance += 30
	new /obj/structure/lock_tear(loc, user.mind)

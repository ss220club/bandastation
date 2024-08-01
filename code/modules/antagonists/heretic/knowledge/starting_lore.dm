// Heretic starting knowledge.

/// Global list of all heretic knowledge that have route = PATH_START. List of PATHS.
GLOBAL_LIST_INIT(heretic_start_knowledge, initialize_starting_knowledge())

/**
 * Returns a list of all heretic knowledge TYPEPATHS
 * that have route set to PATH_START.
 */
/proc/initialize_starting_knowledge()
	. = list()
	for(var/datum/heretic_knowledge/knowledge as anything in subtypesof(/datum/heretic_knowledge))
		if(initial(knowledge.route) == PATH_START)
			. += knowledge

/*
 * The base heretic knowledge. Grants the Mansus Grasp spell.
 */
/datum/heretic_knowledge/spell/basic
	name = "Break of Dawn"
	desc = "Начните свое путешествие в Мансус. \
		Дарует вам Хватку Мансуса, мощное и улучшаемое обездвиживающее заклинание, \
		которое может быть применено независимо от наличия фокусировки."
	spell_to_add = /datum/action/cooldown/spell/touch/mansus_grasp
	cost = 0
	route = PATH_START

/datum/heretic_knowledge/spell/basic/New()
	. = ..()
	next_knowledge = subtypesof(/datum/heretic_knowledge/limited_amount/starting)

/**
 * The Living Heart heretic knowledge.
 *
 * Gives the heretic a living heart.
 * Also includes a ritual to turn their heart into a living heart.
 */
/datum/heretic_knowledge/living_heart
	name = "The Living Heart"
	desc = "Дарует вам Живое сердце, позволяющее отслеживать жертвенные цели. \
		Если вы потеряете сердце, вы можете трансмутировать мак и лужу крови, \
		чтобы пробудить свое сердце в Живое сердце. Если ваше сердце кибернетическое, \
		то для трансмутации вам дополнительно потребуется пригодное для использования органическое сердце."
	required_atoms = list(
		/obj/effect/decal/cleanable/blood = 1,
		/obj/item/food/grown/poppy = 1,
	)
	cost = 0
	priority = MAX_KNOWLEDGE_PRIORITY - 1 // Knowing how to remake your heart is important
	route = PATH_START
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "living_heart"
	research_tree_icon_frame = 1
	/// The typepath of the organ type required for our heart.
	var/required_organ_type = /obj/item/organ/internal/heart

/datum/heretic_knowledge/living_heart/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	var/obj/item/organ/where_to_put_our_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// Our heart slot is not valid to put a heart
	if(!is_valid_heart(where_to_put_our_heart))
		where_to_put_our_heart = null

	// If a heretic is made from a species without a heart, we need to find a backup.
	if(!where_to_put_our_heart)
		var/static/list/backup_organs = list(
			ORGAN_SLOT_LUNGS = /obj/item/organ/internal/lungs,
			ORGAN_SLOT_LIVER = /obj/item/organ/internal/liver,
			ORGAN_SLOT_STOMACH = /obj/item/organ/internal/stomach,
		)

		for(var/backup_slot in backup_organs)
			var/obj/item/organ/look_for_backup = user.get_organ_slot(backup_slot)
			// This backup slot is not a valid slot to put a heart
			if(!is_valid_heart(look_for_backup))
				continue

			// We found a replacement place to put our heart
			where_to_put_our_heart = look_for_backup
			our_heretic.living_heart_organ_slot = backup_slot
			required_organ_type = backup_organs[backup_slot]
			to_chat(user, span_boldnotice("Поскольку у вашего вида нет сердца, ваше Живое сердце находится в вашем [look_for_backup.name]."))
			break

	if(where_to_put_our_heart)
		where_to_put_our_heart.AddComponent(/datum/component/living_heart)
		desc = "Дарует вам Живое сердце, привязанное к вашему [where_to_put_our_heart.name], \
			позволяя отслеживать жертвенные цели. \
			Если вы потеряете свое [where_to_put_our_heart.name], вы можете трансмутировать мак и лужу крови, \
			чтобы пробудить ваше [where_to_put_our_heart.name] в Живое сердце. \
			Если ваше [where_to_put_our_heart.name] кибернетическое, \
			вам дополнительно потребуется пригодное для использования органическое [where_to_put_our_heart.name] при трансмутации."

	else
		to_chat(user, span_boldnotice("У вас нет сердца или каких-либо органов грудной клетки, если на то пошло. Вы не получили Живое сердце из-за этого."))

/datum/heretic_knowledge/living_heart/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	var/obj/item/organ/our_living_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	if(our_living_heart)
		qdel(our_living_heart.GetComponent(/datum/component/living_heart))

// Don't bother letting them invoke this ritual if they have a Living Heart already in their chest
/datum/heretic_knowledge/living_heart/can_be_invoked(datum/antagonist/heretic/invoker)
	if(invoker.has_living_heart() == HERETIC_HAS_LIVING_HEART)
		return FALSE
	return TRUE

/datum/heretic_knowledge/living_heart/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = IS_HERETIC(user)
	var/obj/item/organ/our_living_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// Obviously you need a heart in your chest to do a ritual on your... heart
	if(!our_living_heart)
		loc.balloon_alert(user, "ритуал провален, у вас нет [our_heretic.living_heart_organ_slot]!") // "you have no heart!"
		return FALSE
	// For sanity's sake, check if they've got a heart -
	// even though it's not invokable if you already have one,
	// they may have gained one unexpectantly in between now and then
	if(HAS_TRAIT(our_living_heart, TRAIT_LIVING_HEART))
		loc.balloon_alert(user, "ритуал провален, у вас уже есть Живое сердце!")
		return FALSE

	// By this point they are making a new heart
	// If their current heart is organic / not synthetic, we can continue the ritual as normal
	if(is_valid_heart(our_living_heart))
		return TRUE

	// If their current heart is not organic / is synthetic, they need an organic replacement
	// ...But if our organ-to-be-replaced is unremovable, we're screwed
	if(our_living_heart.organ_flags & ORGAN_UNREMOVABLE)
		loc.balloon_alert(user, "ритуал провален, [our_heretic.living_heart_organ_slot] неубираем!") // "heart unremovable!"
		return FALSE

	// Otherwise, seek out a replacement in our atoms
	for(var/obj/item/organ/nearby_organ in atoms)
		if(!istype(nearby_organ, required_organ_type))
			continue
		if(!is_valid_heart(nearby_organ))
			continue

		selected_atoms += nearby_organ
		return TRUE

	loc.balloon_alert(user, "ритуал провален, нужен заменяемый [our_heretic.living_heart_organ_slot]!") // "need a replacement heart!"
	return FALSE

/datum/heretic_knowledge/living_heart/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = IS_HERETIC(user)
	var/obj/item/organ/our_new_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)

	// Our heart is robotic or synthetic - we need to replace it, and we fortunately should have one by here
	if(!is_valid_heart(our_new_heart))
		var/obj/item/organ/our_replacement_heart = locate(required_organ_type) in selected_atoms
		if(our_replacement_heart)
			// Throw our current heart out of our chest, violently
			user.visible_message(span_boldwarning("[our_new_heart.name] [user] внезапно вырывается из груди!"))
			INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, emote), "scream")
			user.apply_damage(20, BRUTE, BODY_ZONE_CHEST)
			// And put our organic heart in its place
			our_replacement_heart.Insert(user, TRUE, TRUE)
			our_new_heart.throw_at(get_edge_target_turf(user, pick(GLOB.alldirs)), 2, 2)
			our_new_heart = our_replacement_heart
		else
			CRASH("[type] required a replacement organic heart in on_finished_recipe, but did not find one.")

	if(!our_new_heart)
		CRASH("[type] somehow made it to on_finished_recipe without a heart. What?")

	// Snowflakey, but if the user used a heart that wasn't beating
	// they'll immediately collapse into a heart attack. Funny but not ideal.
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.set_heartattack(FALSE)

	// Don't delete our shiny new heart
	selected_atoms -= our_new_heart
	// Make it the living heart
	our_new_heart.AddComponent(/datum/component/living_heart)
	to_chat(user, span_warning("Вы чувствуете, как ваше [our_new_heart.name] начинает пульсировать все быстрее и быстрее по мере того, как оно пробуждается!"))
	playsound(user, 'sound/magic/demon_consume.ogg', 50, TRUE)
	return TRUE

/// Checks if the passed heart is a valid heart to become a living heart
/datum/heretic_knowledge/living_heart/proc/is_valid_heart(obj/item/organ/new_heart)
	if(!new_heart)
		return FALSE
	if(!new_heart.useable)
		return FALSE
	if(new_heart.organ_flags & (ORGAN_ROBOTIC|ORGAN_FAILING))
		return FALSE

	return TRUE

/**
 * Allows the heretic to craft a spell focus.
 * They require a focus to cast advanced spells.
 */
/datum/heretic_knowledge/amber_focus
	name = "Amber Focus"
	desc = "Позволяет трансмутировать лист стекла и пару глаз, чтобы создать Янтарную фокусировку. \
		Для того чтобы произносить более сложные заклинания, необходимо носить фокусировку."
	required_atoms = list(
		/obj/item/organ/internal/eyes = 1,
		/obj/item/stack/sheet/glass = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/heretic_focus)
	cost = 0
	priority = MAX_KNOWLEDGE_PRIORITY - 2 // Not as important as making a heart or sacrificing, but important enough.
	route = PATH_START
	research_tree_icon_path = 'icons/obj/clothing/neck.dmi'
	research_tree_icon_state = "eldritch_necklace"

/datum/heretic_knowledge/spell/cloak_of_shadows
	name = "Cloak of Shadow"
	desc = "Дарует вам заклинание Cloak of Shadow. Это заклинание полностью скрывает вашу личность в фиолетовой дымке \
		на три минуты, помогая вам сохранять секретность. Для наложения заклинания требуется фокусировка."
	spell_to_add = /datum/action/cooldown/spell/shadow_cloak
	cost = 0
	route = PATH_START

/**
 * Codex Cicatrixi is available at the start:
 * This allows heretics to choose if they want to rush all the influences and take them stealthily, or
 * Construct a codex and take what's left with more points.
 * Another downside to having the book is strip searches, which means that it's not just a free nab, at least until you get exposed - and when you do, you'll probably need the faster drawing speed.
 * Overall, it's a tradeoff between speed and stealth or power.
 */
/datum/heretic_knowledge/codex_cicatrix
	name = "Codex Cicatrix"
	desc = "Позволяет трансмутировать книгу, любую уникальную ручку (что угодно, кроме обычных), любое тело (животного или человека) и шкуру или кожу, чтобы создать Codex Cicatrix. \
		Codex Cicatrix можно использовать при истощении влияний для получения дополнительных знаний, но при этом возрастает риск быть замеченным. \
		Его также можно использовать для того, чтобы легче рисовать и удалять руны трансмутации, и использоваться в качестве фокусировки"
	gain_text = "Оккультизм оставляет фрагменты знаний и силы везде и всюду. Codex Cicatrix - один из таких примеров. \
		В кожаном переплете и на старых страницах открывается путь к Мансусу."
	required_atoms = list(
		/obj/item/book = 1,
		/obj/item/pen = 1,
		list(/mob/living, /obj/item/stack/sheet/leather, /obj/item/stack/sheet/animalhide) = 1,
	)
	banned_atom_types = list(/obj/item/pen)
	result_atoms = list(/obj/item/codex_cicatrix)
	cost = 1
	route = PATH_START
	priority = MAX_KNOWLEDGE_PRIORITY - 3 // Least priority out of the starting knowledges, as it's an optional boon.
	var/static/list/non_mob_bindings = typecacheof(list(/obj/item/stack/sheet/leather, /obj/item/stack/sheet/animalhide))
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "book"

/datum/heretic_knowledge/codex_cicatrix/parse_required_item(atom/item_path, number_of_things)
	if(item_path == /obj/item/pen)
		return "unique type of pen"
	return ..()

/datum/heretic_knowledge/codex_cicatrix/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/thingy in atoms)
		if(is_type_in_typecache(thingy, non_mob_bindings))
			selected_atoms += thingy
			return TRUE
		else if(isliving(thingy))
			var/mob/living/body = thingy
			if(body.stat != DEAD)
				continue
			selected_atoms += body
			return TRUE
	return FALSE

/datum/heretic_knowledge/codex_cicatrix/cleanup_atoms(list/selected_atoms)
	var/mob/living/body = locate() in selected_atoms
	if(!body)
		return
	// A golem or an android doesn't have skin!
	var/exterior_text = "skin"
	// If carbon, it's the limb. If not, it's the body.
	var/ripped_thing = body

	// We will check if it's a carbon's body.
	// If it is, we will damage a random bodypart, and check that bodypart for its body type, to select between 'skin' or 'exterior'.
	if(iscarbon(body))
		var/mob/living/carbon/carbody = body
		var/obj/item/bodypart/bodypart = pick(carbody.bodyparts)
		ripped_thing = bodypart
		bodypart.receive_damage(25, sharpness = SHARP_EDGED)
		if(!(bodypart.bodytype & BODYTYPE_ORGANIC))
			exterior_text = "exterior"
	else
		// If it is not a carbon mob, we will just check biotypes and damage it directly.
		if(body.mob_biotypes & (MOB_MINERAL|MOB_ROBOTIC))
			exterior_text = "exterior"
			body.apply_damage(25, BRUTE)

	// Procure book for flavor text. This is why we call parent at the end.
	var/obj/item/book/le_book = locate() in selected_atoms
	if(!le_book)
		stack_trace("Somehow, no book in codex cicatrix selected atoms! [english_list(selected_atoms)]")
	playsound(body, 'sound/items/poster_ripped.ogg', 100, TRUE)
	body.do_jitter_animation()
	body.visible_message(span_danger("An awful ripping sound is heard as [ripped_thing]'s [exterior_text] is ripped straight out, wrapping around [le_book || "the book"], turning into an eldritch shade of blue!"))
	return ..()

/datum/heretic_knowledge/feast_of_owls
	name = "Feast of Owls"
	desc = "Allows you to undergo a ritual that gives you 5 knowledge points but locks you out of ascension. This can only be done once and cannot be reverted."
	gain_text = "Under the soft glow of unreason there is a beast that stalks the night. I shall bring it forth and let it enter my presence. It will feast upon my amibitions and leave knowledge in its wake."
	route = PATH_START
	required_atoms = list()
	research_tree_icon_path = 'icons/mob/actions/actions_animal.dmi'
	research_tree_icon_state = "god_transmit"

/datum/heretic_knowledge/feast_of_owls/can_be_invoked(datum/antagonist/heretic/invoker)
	return !invoker.feast_of_owls

/datum/heretic_knowledge/feast_of_owls/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	//amount of research points granted
	var/reward = 5
	var/alert = tgui_alert(user,"Do you really want to forsake your ascension? This action cannot be reverted.", "Feast of Owls", list("Yes I'm sure", "No"), 30 SECONDS)
	if( alert != "Yes I'm sure")
		return FALSE
	user.set_temp_blindness(reward SECONDS)
	user.AdjustParalyzed(reward SECONDS)
	user.playsound_local(get_turf(user), 'sound/ambience/antag/heretic/heretic_gain_intense.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	var/datum/antagonist/heretic/heretic_datum = IS_HERETIC(user)
	for(var/i in 1 to reward)
		user.emote("scream")
		playsound(loc, 'sound/items/eatfood.ogg', 100, TRUE)
		heretic_datum.knowledge_points++
		to_chat(user, span_danger("You feel something invisible tearing away at your very essence!"))
		user.do_jitter_animation()
		sleep(1 SECONDS)
	heretic_datum.feast_of_owls = TRUE
	to_chat(user, span_danger(span_big("Your ambition is ravaged, but something powerful remains in its wake...")))
	var/drain_message = pick(strings(HERETIC_INFLUENCE_FILE, "drain_message"))
	to_chat(user, span_hypnophrase(span_big("[drain_message]")))

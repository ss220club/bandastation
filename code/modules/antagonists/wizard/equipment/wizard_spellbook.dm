/obj/item/spellbook
	name = "spell book"
	desc = "Необычный том, светящийся силой."
	icon = 'icons/obj/service/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY

	/// The number of book charges we have to buy spells
	var/uses = 10
	/// The bonus that you get from going semi-random.
	var/semi_random_bonus = 2
	/// The bonus that you get from going full random.
	var/full_random_bonus = 5
	/// Determines if this spellbook can refund anything.
	var/refunds_allowed = TRUE
	/// The mind that first used the book. Automatically assigned when a wizard spawns.
	var/datum/mind/owner
	/// A list to all spellbook entries within
	var/list/entries = list()

/obj/item/spellbook/Initialize(mapload)
	. = ..()
	prepare_spells()
	RegisterSignal(src, COMSIG_ITEM_MAGICALLY_CHARGED, PROC_REF(on_magic_charge))

/obj/item/spellbook/Destroy(force)
	owner = null
	entries.Cut()
	return ..()

/**
 * Signal proc for [COMSIG_ITEM_MAGICALLY_CHARGED]
 *
 * Has no effect on charge, but gives a funny message to people who think they're clever.
 */
/obj/item/spellbook/proc/on_magic_charge(datum/source, datum/action/cooldown/spell/spell, mob/living/caster)
	SIGNAL_HANDLER

	to_chat(caster, span_warning("На обложке появляются красные светящиеся буквы..."))
	to_chat(caster, span_red(pick(
		"ХОРОШАЯ ПОПЫТКА, НО НЕТ!",
		"УМНО, НО НЕДОСТАТОЧНО УМНО!",
		"ИЗ-ЗА ТАКОГО ВОПИЮЩЕГО ШУЛЕРСТВА МЫ И ПРИНЯЛИ ВАШЕ ЗАЯВЛЕНИЕ!",
		"МИЛО! ОЧЕНЬ МИЛО!",
		"ТЫ ЖЕ НЕ ДУМАЛ, ЧТО ЭТО БУДЕТ ТАК ПРОСТО, ПРАВДА?",
	)))

	return COMPONENT_ITEM_BURNT_OUT

/obj/item/spellbook/examine(mob/user)
	. = ..()
	if(owner)
		. += "На передней обложке есть небольшая подпись: \"[owner]\"."
	else
		. += "Похоже, что у нее нет автора."

/obj/item/spellbook/attack_self(mob/user)
	if(!owner)
		if(!user.mind)
			return
		to_chat(user, span_notice("Вы привязываете [src.name] к себе."))
		owner = user.mind
		return

	if(user.mind != owner)
		if(user.mind?.special_role == ROLE_WIZARD_APPRENTICE)
			to_chat(user, span_warning("Если бы вас поймают за подглядыванием в книгу заклинаний вашего учителя, то, скорее всего, вас отчислять из Академии волшебников. Лучше не стоит."))
		else
			to_chat(user, span_warning("Вы не признаетесь владельцем [src.name], и она не собирается открываться!"))
		return

	return ..()

/obj/item/spellbook/attackby(obj/item/O, mob/user, params)
	// This can be generalized in the future, but for now it stays
	if(istype(O, /obj/item/antag_spawner/contract))
		var/datum/spellbook_entry/item/contract/contract_entry = locate() in entries
		if(!istype(contract_entry))
			to_chat(user, span_warning("Похоже, что [src.name] не хочет возвращать очки за [O.name]."))
			return
		if(!contract_entry.can_refund(user, src))
			to_chat(user, span_warning("Вы не можете вернуть очки за [src.name]."))
			return
		var/obj/item/antag_spawner/contract/contract = O
		if(contract.used)
			to_chat(user, span_warning("Контракт был использован, вы не можете вернуть себе очки!"))
			return

		to_chat(user, span_notice("Вы возвращаете контракт в книгу заклинаний, возвращая себе очки."))
		uses += contract_entry.cost
		contract_entry.times--
		qdel(O)

	else if(istype(O, /obj/item/antag_spawner/slaughter_demon/laughter))
		var/datum/spellbook_entry/item/hugbottle/demon_entry = locate() in entries
		if(!istype(demon_entry))
			to_chat(user, span_warning("Похоже, что [src.name] не хочет возвращать очки за [O.name]."))
			return
		if(!demon_entry.can_refund(user, src))
			to_chat(user, span_warning("Вы не можете вернуть очки за [O.name]."))
			return

		to_chat(user, span_notice("Если подумать, может быть, вызов демона - не такая уж и смешная идея. Вы возвращаете свои очки."))
		uses += demon_entry.cost
		demon_entry.times--
		qdel(O)

	else if(istype(O, /obj/item/antag_spawner/slaughter_demon))
		var/datum/spellbook_entry/item/bloodbottle/demon_entry = locate() in entries
		if(!istype(demon_entry))
			to_chat(user, span_warning("Похоже, что [src.name] не хочет возвращать очки за [O.name]."))
			return
		if(!demon_entry.can_refund(user, src))
			to_chat(user, span_warning("Вы не можете вернуть очки за [O.name]."))
			return

		to_chat(user, span_notice("Если подумать, возможно, вызов демона - плохая идея. Вы возвращаете свои очки."))
		uses += demon_entry.cost
		demon_entry.times--
		qdel(O)

	return ..()

/// Instantiates our list of spellbook entries.
/obj/item/spellbook/proc/prepare_spells()
	var/entry_types = subtypesof(/datum/spellbook_entry)
	for(var/type in entry_types)
		var/datum/spellbook_entry/possible_entry = new type()
		if(!possible_entry.can_be_purchased())
			qdel(possible_entry)
			continue

		possible_entry.set_spell_info() //loads up things for the entry that require checking spell instance.
		entries |= possible_entry

/obj/item/spellbook/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Spellbook")
		ui.open()

/obj/item/spellbook/ui_data(mob/user)
	var/list/data = list()
	data["owner"] = owner
	data["points"] = uses
	return data

//This is a MASSIVE amount of data, please be careful if you remove it from static.
/obj/item/spellbook/ui_static_data(mob/user)
	var/list/data = list()
	// Collect all info from each intry.
	var/list/entry_data = list()
	for(var/datum/spellbook_entry/entry as anything in entries)
		var/list/individual_entry_data = list()
		individual_entry_data["name"] = entry.name
		individual_entry_data["desc"] = entry.desc
		individual_entry_data["ref"] = REF(entry)
		individual_entry_data["requires_wizard_garb"] = entry.requires_wizard_garb
		individual_entry_data["cost"] = entry.cost
		individual_entry_data["times"] = entry.times
		individual_entry_data["cooldown"] = entry.cooldown
		individual_entry_data["cat"] = entry.category
		individual_entry_data["refundable"] = entry.refundable
		individual_entry_data["buyword"] = entry.buy_word
		entry_data += list(individual_entry_data)

	data["entries"] = entry_data
	data["semi_random_bonus"] = initial(uses) + semi_random_bonus
	data["full_random_bonus"] = initial(uses) + full_random_bonus
	return data

/obj/item/spellbook/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/wizard = usr
	if(!istype(wizard))
		to_chat(wizard, span_warning("Книга, похоже, не слушает низшие формы жизни."))
		return FALSE

	// Actions that are always available
	switch(action)
		if("purchase")
			var/datum/spellbook_entry/entry = locate(params["spellref"]) in entries
			return purchase_entry(entry, wizard)

		if("refund")
			var/datum/spellbook_entry/entry = locate(params["spellref"]) in entries
			if(!istype(entry))
				CRASH("[type] had an invalid ref to a spell passed in refund.")
			if(!entry.can_refund(wizard, src))
				return FALSE
			var/result = entry.refund_spell(wizard, src)
			if(result <= 0)
				return FALSE

			entry.times = 0
			uses += result
			return TRUE

	if(uses < initial(uses))
		to_chat(wizard, span_warning("Для этого вам нужны все очки заклинаний!"))
		return FALSE

	// Actions that are only available if you have full spell points
	switch(action)
		if("semirandomize")
			semirandomize(wizard, semi_random_bonus)
			return TRUE

		if("randomize")
			randomize(wizard, full_random_bonus)
			return TRUE

		if("purchase_loadout")
			wizard_loadout(wizard, params["id"])
			return TRUE

/// Attempts to purchased the passed entry [to_buy] for [user].
/obj/item/spellbook/proc/purchase_entry(datum/spellbook_entry/to_buy, mob/living/carbon/human/user)
	if(!istype(to_buy))
		CRASH("Spellbook attempted to buy an invalid entry. Got: [to_buy ? "[to_buy] ([to_buy.type])" : "null"]")
	if(!to_buy.can_buy(user, src))
		return FALSE
	if(!to_buy.buy_spell(user, src))
		return FALSE

	to_buy.times++
	uses -= to_buy.cost
	return TRUE

/// Purchases a wizard loadout [loadout] for [wizard].
/obj/item/spellbook/proc/wizard_loadout(mob/living/carbon/human/wizard, loadout)
	var/list/wanted_spells
	switch(loadout)
		if(WIZARD_LOADOUT_CLASSIC) //(Fireball>2, MM>2, Smite>2, Jauntx2>4) = 10
			wanted_spells = list(
				/datum/spellbook_entry/fireball = 1,
				/datum/spellbook_entry/magicm = 1,
				/datum/spellbook_entry/disintegrate = 1,
				/datum/spellbook_entry/jaunt = 2,
			)
		if(WIZARD_LOADOUT_MJOLNIR) //(Mjolnir>2, Summon Itemx1>1, Mutate>2, Force Wall>1, Blink>2, tesla>2) = 10
			wanted_spells = list(
				/datum/spellbook_entry/item/mjolnir = 1,
				/datum/spellbook_entry/summonitem = 1,
				/datum/spellbook_entry/mutate = 1,
				/datum/spellbook_entry/forcewall = 1,
				/datum/spellbook_entry/blink = 1,
				/datum/spellbook_entry/teslablast = 1,
			)
		if(WIZARD_LOADOUT_WIZARMY) //(Soulstones>2, Staff of Change>2, A Necromantic Stone>2, Teleport>2, Ethereal Jaunt>2) = 10
			wanted_spells = list(
				/datum/spellbook_entry/item/soulstones = 1,
				/datum/spellbook_entry/item/staffchange = 1,
				/datum/spellbook_entry/item/necrostone = 1,
				/datum/spellbook_entry/teleport = 1,
				/datum/spellbook_entry/jaunt = 1,
			)
		if(WIZARD_LOADOUT_SOULTAP) //(Soul Tap>1, Smite>2, Flesh to Stone>2, Mindswap>2, Knock>1, Teleport>2) = 10
			wanted_spells = list(
				/datum/spellbook_entry/tap = 1,
				/datum/spellbook_entry/disintegrate = 1,
				/datum/spellbook_entry/fleshtostone = 1,
				/datum/spellbook_entry/mindswap = 1,
				/datum/spellbook_entry/knock = 1,
				/datum/spellbook_entry/teleport = 1,
			)

	if(!length(wanted_spells))
		stack_trace("Wizard Loadout \"[loadout]\" did not find a loadout that existed.")
		return

	for(var/entry in wanted_spells)
		if(!ispath(entry, /datum/spellbook_entry))
			stack_trace("Wizard Loadout \"[loadout]\" had an non-spellbook_entry type in its wanted spells list. ([entry])")
			continue

		var/datum/spellbook_entry/to_buy = locate(entry) in entries
		if(!istype(to_buy))
			stack_trace("Wizard Loadout \"[loadout]\" had an invalid entry in its wanted spells list. ([entry])")
			continue

		for(var/i in 1 to wanted_spells[entry])
			if(!purchase_entry(to_buy, wizard))
				stack_trace("Wizard Loadout \"[loadout]\" was unable to buy a spell for [wizard]. ([entry])")
				message_admins("Wizard [wizard] purchased Loadout \"[loadout]\" but was unable to purchase one of the entries ([to_buy]) for some reason.")
				break

	refunds_allowed = FALSE

	if(uses > 0)
		stack_trace("Wizard Loadout \"[loadout]\" does not use 10 wizard spell slots (used: [initial(uses) - uses]). Stop scamming players out.")

/// Purchases a semi-random wizard loadout for [wizard]
/// If passed a number [bonus_to_give], the wizard is given additional uses on their spellbook, used in randomization.
/obj/item/spellbook/proc/semirandomize(mob/living/carbon/human/wizard, bonus_to_give = 0)
	var/list/needed_cats = list("Наступление", "Мобильность")
	var/list/shuffled_entries = shuffle(entries)
	for(var/i in 1 to 2)
		for(var/datum/spellbook_entry/entry as anything in shuffled_entries)
			if(!(entry.category in needed_cats))
				continue
			if(!purchase_entry(entry, wizard))
				continue
			needed_cats -= entry.category //so the next loop doesn't find another offense spell
			break

	refunds_allowed = FALSE
	//we have given two specific category spells to the wizard. the rest are completely random!
	randomize(wizard, bonus_to_give = bonus_to_give)

/// Purchases a fully random wizard loadout for [wizard], with a point bonus [bonus_to_give].
/// If passed a number [bonus_to_give], the wizard is given additional uses on their spellbook, used in randomization.
/obj/item/spellbook/proc/randomize(mob/living/carbon/human/wizard, bonus_to_give = 0)
	var/list/entries_copy = entries.Copy()
	uses += bonus_to_give
	while(uses > 0 && length(entries_copy))
		var/datum/spellbook_entry/entry = pick(entries_copy)
		if(!purchase_entry(entry, wizard))
			continue
		entries_copy -= entry

	refunds_allowed = FALSE

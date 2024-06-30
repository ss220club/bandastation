///Tracking reasons
/datum/antagonist/heretic_monster
	name = "\improper Eldritch Horror"
	roundend_category = "Heretics"
	antagpanel_category = ANTAG_GROUP_HORRORS
	antag_moodlet = /datum/mood_event/heretics
	job_rank = ROLE_HERETIC
	antag_hud_name = "heretic_beast"
	suicide_cry = "МОЙ ХОЗЯИН УЛЫБАЕТСЯ МНЕ!!"
	show_in_antagpanel = FALSE
	stinger_sound = 'sound/ambience/antag/heretic/heretic_gain.ogg'
	/// Our master (a heretic)'s mind.
	var/datum/mind/master

/datum/antagonist/heretic_monster/on_removal()
	if(!silent)
		if(master?.current)
			to_chat(master.current, span_warning("Сущность [owner], вашего слуги, исчезает из твоего сознания."))
		if(owner.current)
			to_chat(owner.current, span_deconversion_message("Ваш разум начинает заполняться туманом - ваш хозяин [master ? "больше не [master]":"отсутствует"], вы свободны!"))
			owner.current.visible_message(span_deconversion_message("[owner.current] выглядит свободным от оков Мансура!"), ignored_mobs = owner.current)

	master = null
	return ..()

/*
 * Set our [master] var to a new mind.
 */
/datum/antagonist/heretic_monster/proc/set_owner(datum/mind/master)
	src.master = master

	var/datum/objective/master_obj = new()
	master_obj.owner = owner
	master_obj.explanation_text = "Помогайте своему хозяину."
	master_obj.completed = TRUE

	objectives += master_obj
	owner.announce_objectives()
	to_chat(owner, span_boldnotice("You are a [ishuman(owner.current) ? "shambling corpse returned":"horrible creation brought"] to this plane through the Gates of the Mansus."))
	to_chat(owner, span_notice("Your master is [master]. Assist them to all ends."))

	if(istype(owner.current, /mob/living/basic/construct/harvester/heretic))
		var/mob/living/basic/construct/harvester/heretic/shitcode = owner.current
		shitcode.master = master

/datum/traitor_objective_category/sleeper_protocol
	name = "Sleeper Protocol"
	objectives = list(
		/datum/traitor_objective/sleeper_protocol = 1,
		/datum/traitor_objective/sleeper_protocol/everybody = 1,
	)

/datum/traitor_objective/sleeper_protocol
	name = "Выполните процедуру внедрения спящего агента над одним из членов экипажа."
	description = "Используйте кнопку ниже, чтобы материализовать в руке хирургический диск, с помощью которого вы сможете сделать члена экипажа спящим агентом Синдиката. Если диск будет уничтожен, цель будет провалена. Это сработает только на живых и разумных членах экипажа."

	progression_minimum = 0 MINUTES

	progression_reward = list(8 MINUTES, 15 MINUTES)
	telecrystal_reward = 1

	var/list/limited_to = list(
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_MEDICAL_DOCTOR,
		JOB_PARAMEDIC,
		JOB_ROBOTICIST,
	)

	var/obj/item/disk/surgery/sleeper_protocol/disk

	var/mob/living/current_registered_mob

	var/inverted_limitation = FALSE

/datum/traitor_objective/sleeper_protocol/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(!disk)
		buttons += add_ui_button("", "Нажмите, чтобы материализовать процедуру внедрения спящего агента", "save", "summon_disk")
	return buttons

/datum/traitor_objective/sleeper_protocol/ui_perform_action(mob/living/user, action)
	switch(action)
		if("summon_disk")
			if(disk)
				return
			disk = new(user.drop_location())
			user.put_in_hands(disk)
			AddComponent(/datum/component/traitor_objective_register, disk, \
				fail_signals = list(COMSIG_QDELETING))

/datum/traitor_objective/sleeper_protocol/proc/on_surgery_success(datum/source, datum/surgery_step/step, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	SIGNAL_HANDLER
	if(istype(step, /datum/surgery_step/brainwash/sleeper_agent))
		succeed_objective()

/datum/traitor_objective/sleeper_protocol/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	var/datum/job/job = generating_for.assigned_role
	if(!(job.title in limited_to) && !inverted_limitation)
		return FALSE
	if((job.title in limited_to) && inverted_limitation)
		return FALSE
	if(length(possible_duplicates) > 0)
		return FALSE
	return TRUE

/datum/traitor_objective/sleeper_protocol/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	AddComponent(/datum/component/traitor_objective_mind_tracker, generating_for, \
		signals = list(COMSIG_MOB_SURGERY_STEP_SUCCESS = PROC_REF(on_surgery_success)))
	return TRUE

/datum/traitor_objective/sleeper_protocol/ungenerate_objective()
	disk = null
/obj/item/disk/surgery/sleeper_protocol
	name = "Suspicious Surgery Disk"
	desc = "На диске содержатся инструкции о том, как превратить кого-либо в спящего агента Синдиката."
	surgeries = list(/datum/surgery/advanced/brainwashing_sleeper)

/datum/surgery/advanced/brainwashing_sleeper
	name = "Sleeper Agent Surgery"
	desc = "Хирургическая процедура, которая имплантирует протокол сна в мозг пациента, что делает его абсолютным приоритетом. Его можно очистить с помощью импланта защиты разума."
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/brainwash/sleeper_agent,
		/datum/surgery_step/close,
	)

/datum/surgery/advanced/brainwashing_sleeper/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return FALSE
	var/obj/item/organ/internal/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE
	return TRUE

/datum/surgery_step/brainwash/sleeper_agent
	time = 25 SECONDS
	var/static/list/possible_objectives = list(
		"Ты любишь Синдикат.",
		"Недоверяй Nanotrasen.",
		"Капитан - ящер.",
		"Nanotrasen не существует.",
		"Они подложили что-то в твою еду, чтобы ты забыл.",
		"Ты единственный реальный член экипажа на этой станции.",
		"На станции было бы намного лучше, если бы больше людей кричало, кто-то должен с этим что-то сделать.",
		"Люди, ответственные здесь, имеют только злые намерения в отношении команды.",
		"Помочь экипажу? Что они вообще для тебя сделали?",
		"Ваша сумка кажется легче? Могу поспорить, что те ребята из службы безопасности что-то оттуда украли. Иди и верни это!",
		"Командование некомпетентно, кто-то, обладающий РЕАЛЬНОЙ властью, должен взять на себя управление здесь.",
		"Киборги и искусственный интеллект преследуют вас. Что они планируют?",
	)

/datum/surgery_step/brainwash/sleeper_agent/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	objective = pick(possible_objectives)
	display_results(
		user,
		target,
		span_notice("Вы начинаете промывать мозги [target]..."),
		span_notice("[user] начинает исправлять мозги [target]."),
		span_notice("[user] начинает делать операцию на мозге [target]."),
	)
	display_pain(target, "Голова раскалывается от невообразимой боли!") // Same message as other brain surgeries

/datum/surgery_step/brainwash/sleeper_agent/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(target.stat == DEAD)
		to_chat(user, span_warning("Они должны быть живы, чтобы провести эту операцию!"))
		return FALSE
	. = ..()
	if(!.)
		return
	target.gain_trauma(new /datum/brain_trauma/mild/phobia/conspiracies(), TRAUMA_RESILIENCE_LOBOTOMY)

/datum/traitor_objective/sleeper_protocol/everybody //Much harder for non-med and non-robo
	progression_minimum = 30 MINUTES
	progression_reward = list(8 MINUTES, 15 MINUTES)
	telecrystal_reward = 1

	inverted_limitation = TRUE

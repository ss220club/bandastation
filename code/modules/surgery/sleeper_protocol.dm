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

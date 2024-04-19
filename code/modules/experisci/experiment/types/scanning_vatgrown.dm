/datum/experiment/scanning/random/cytology
	name = "Эксперемент по скану цитологии"
	description = "Базовый эксперимент для сканирования атомов, выращенных в чашке петри."
	exp_tag = "Скан цитологии"
	total_requirement = 1
	possible_types = list(/mob/living/basic/cockroach)
	traits = EXPERIMENT_TRAIT_DESTRUCTIVE

/datum/experiment/scanning/random/cytology/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	return ..() && HAS_TRAIT(target, TRAIT_VATGROWN)

/datum/experiment/scanning/random/cytology/serialize_progress_stage(atom/target, list/seen_instances)
	return EXPERIMENT_PROG_INT("Скан образцов [initial(target.name)], выращенных в лаборатории", \
		traits & EXPERIMENT_TRAIT_DESTRUCTIVE ? scanned[target] : seen_instances.len, required_atoms[target])

GLOBAL_LIST_INIT(electrolyzer_reactions, electrolyzer_reactions_list())

/*
 * Global proc to build the electrolyzer reactions list
 */
/proc/electrolyzer_reactions_list()
	var/list/built_reaction_list = list()
	for(var/reaction_path in subtypesof(/datum/electrolyzer_reaction))
		var/datum/electrolyzer_reaction/reaction = new reaction_path()

		built_reaction_list[reaction.id] = reaction

	return built_reaction_list

/datum/electrolyzer_reaction
	var/list/requirements
	var/name = "reaction"
	var/id = "r"
	var/desc = ""
	var/list/factor

/datum/electrolyzer_reaction/proc/react(turf/location, datum/gas_mixture/air_mixture, working_power)
	return

/datum/electrolyzer_reaction/proc/reaction_check(datum/gas_mixture/air_mixture)
	var/temp = air_mixture.temperature
	var/list/cached_gases = air_mixture.gases
	if((requirements["MIN_TEMP"] && temp < requirements["MIN_TEMP"]) || (requirements["MAX_TEMP"] && temp > requirements["MAX_TEMP"]))
		return FALSE
	for(var/id in requirements)
		if (id == "MIN_TEMP" || id == "MAX_TEMP")
			continue
		if(!cached_gases[id] || cached_gases[id][MOLES] < requirements[id])
			return FALSE
	return TRUE

/datum/electrolyzer_reaction/h2o_conversion
	name = "Электролиз H2O"
	id = "h2o_conversion"
	desc = "Превращение H2О в O2 и H2"
	requirements = list(
		/datum/gas/water_vapor = MINIMUM_MOLE_COUNT
	)
	factor = list(
		/datum/gas/water_vapor = "2 моль H2O будет затрачено в ходе реакции",
		/datum/gas/oxygen = "1 моль O2 будет образовано в ходе реакции",
		/datum/gas/hydrogen = "2 моль H2 будет образовано в ходе реакции",
		"Местонахождение" = "Может произойти только в месте с активным электролизером.",
	)

/datum/electrolyzer_reaction/h2o_conversion/react(turf/location, datum/gas_mixture/air_mixture, working_power)

	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/water_vapor, /datum/gas/oxygen, /datum/gas/hydrogen)
	var/proportion = min(air_mixture.gases[/datum/gas/water_vapor][MOLES] * INVERSE(2), (2.5 * (working_power ** 2)))
	air_mixture.gases[/datum/gas/water_vapor][MOLES] -= proportion * 2
	air_mixture.gases[/datum/gas/oxygen][MOLES] += proportion
	air_mixture.gases[/datum/gas/hydrogen][MOLES] += proportion * 2
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

/datum/electrolyzer_reaction/nob_conversion
	name = "Электролиз гипер-ноблиума"
	id = "nob_conversion"
	desc = "Превращение гипер-ноблиума в анти-ноблиум"
	requirements = list(
		/datum/gas/hypernoblium = MINIMUM_MOLE_COUNT,
		"MAX_TEMP" = 150
	)
	factor = list(
		/datum/gas/hypernoblium = "1 моль гипер-ноблиума будет затрачено в ходе реакции",
		/datum/gas/antinoblium = "0.5 моль анти-ноблиума будет образовано в ходе реакции",
		"Температура" = "Может произойти только при температуре ниже 150 Кельвинов.",
		"Местонахождение" = "Может произойти только в месте с активным электролизером.",
	)

/datum/electrolyzer_reaction/nob_conversion/react(turf/location, datum/gas_mixture/air_mixture, working_power)

	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/hypernoblium, /datum/gas/antinoblium)
	var/proportion = min(air_mixture.gases[/datum/gas/hypernoblium][MOLES], (1.5 * (working_power ** 2)))
	air_mixture.gases[/datum/gas/hypernoblium][MOLES] -= proportion
	air_mixture.gases[/datum/gas/antinoblium][MOLES] += proportion * 0.5
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

/datum/electrolyzer_reaction/halon_generation
	name = "Образование Галона"
	id = "halon_generation"
	desc = "Производство галона путём электролиза BZ."
	requirements = list(
		/datum/gas/bz = MINIMUM_MOLE_COUNT,
	)
	factor = list(
		/datum/gas/bz = "Расходуется во время реакции.",
		/datum/gas/oxygen = "На один моль потребленного BZ образуется 0,2 моль кислорода.",
		/datum/gas/halon = "На каждый моль потребленного BZ образуется 2 моль галона.",
		"Энергия" = "91.2321 кДж тепловой энергии выделяется на моль потребленного BZ.",
		"Температура" = "Эффективность реакции пропорциональна температуре.",
		"Местонахождение" = "Может произойти только в месте с активным электролизером.",
	)

/datum/electrolyzer_reaction/halon_generation/react(turf/location, datum/gas_mixture/air_mixture, working_power)
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/bz, /datum/gas/oxygen, /datum/gas/halon)
	var/reaction_efficency = min(air_mixture.gases[/datum/gas/bz][MOLES] * (1 - NUM_E ** (-0.5 * air_mixture.temperature * working_power / FIRE_MINIMUM_TEMPERATURE_TO_EXIST)), air_mixture.gases[/datum/gas/bz][MOLES])
	air_mixture.gases[/datum/gas/bz][MOLES] -= reaction_efficency
	air_mixture.gases[/datum/gas/oxygen][MOLES] += reaction_efficency * 0.2
	air_mixture.gases[/datum/gas/halon][MOLES] += reaction_efficency * 2
	var/energy_used = reaction_efficency * HALON_FORMATION_ENERGY
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(((air_mixture.temperature * old_heat_capacity + energy_used) / new_heat_capacity), TCMB)

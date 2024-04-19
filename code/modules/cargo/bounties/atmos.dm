/datum/bounty/item/atmospherics
	name = "Gas Parent"
	description = "Shit's broken if you see this."
	reward = CARGO_CRATE_VALUE * 15
	wanted_types = list(/obj/item/tank = TRUE)
	/// How many moles are needed to fufill the bounty?
	var/moles_required = 20
	/// Typepath of the gas datum required to fufill the bounty
	var/gas_type

/datum/bounty/item/atmospherics/applies_to(obj/applied_obj)
	if(!..())
		return FALSE
	var/obj/item/tank/applied_tank = applied_obj
	var/datum/gas_mixture/our_mix = applied_tank.return_air()
	if(!our_mix.gases[gas_type])
		return FALSE
	return our_mix.gases[gas_type][MOLES] >= moles_required

/datum/bounty/item/atmospherics/pluox_tank
	name = "Полный баллон плюоския"
	description = "РнД на ЦентКоме изучает сверхкомпактные баллоны. Отправьте нам полный баллон плюоксия и вам будет отправлена компенсация. (20 молей)"
	gas_type = /datum/gas/pluoxium

/datum/bounty/item/atmospherics/nitrium_tank
	name = "Полный баллон нитрия"
	description = "Нечеловеческий персонал станции 88 вызвался волонтёрами в тестировании препаратов, повышающих работоспособность. Отправьте им полный баллон нитрия, чтобы они смогли начать. (20 молей)"
	gas_type = /datum/gas/nitrium

/datum/bounty/item/atmospherics/freon_tank
	name = "Полный баллон фреона"
	description = "Суперматтерия на станции 33 начала процесс расслоения. Доставьте баллон фреона, чтобы помочь им остановить это! (20 молей)"
	gas_type = /datum/gas/freon

/datum/bounty/item/atmospherics/tritium_tank
	name = "Полный баллон трития"
	description = "Станция 49 ищет кикстарт для их исследовательской программы. Отправьте им полный баллон трития. (20 молей)"
	gas_type = /datum/gas/tritium

/datum/bounty/item/atmospherics/hydrogen_tank
	name = "Полный баллон водорода"
	description = "Наш научный департамент работает над созданием более электроэффективных батареек, использующих водород в качестве катализатора. Отправьте нам полный баллон водорода. (20 молей)"
	gas_type = /datum/gas/hydrogen

/datum/bounty/item/atmospherics/zauker_tank
	name = "Полный баллон заукера"
	description = "Основная планета \[REDACTED] была выбрана в качестве тестового полигона для нового оружия, что использует газ заукер. Отправьте полный баллон заукера. (20 молей)"
	reward = CARGO_CRATE_VALUE * 20
	gas_type = /datum/gas/zauker

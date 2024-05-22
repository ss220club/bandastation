/datum/uplink_category/contractor
	name = "Контрактник"
	weight = 10

/datum/uplink_item/bundles_tc/contract_kit
	name = "Contract Kit"
	desc = "Синдикат предложил вм стать контрактником, выполняя заказы на похищение за телекристаллы \
		и денежное вознаграждение. После покупки вы получите собственный контрактный аплинк встроенный в \
		планшет. Кроме того, вам также будет предоставлено стандартное снаряжения контрактника, чтобы помочь с вашей миссией - \
		планшет, специализированный космический костюм, комбинезон и маску хамелеон, карта агента, \
		специализированная дубинка контрактника и три случайных недорогих предмета. \
		Может включать недоступные предметы."
	item = /obj/item/storage/box/syndicate/contract_kit
	category = /datum/uplink_category/contractor
	cost = 20
	purchasable_from = UPLINK_INFILTRATORS

/datum/uplink_item/bundles_tc/contract_kit/purchase(mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	. = ..()
	for(var/uplink_items in subtypesof(/datum/uplink_item/contractor))
		var/datum/uplink_item/uplink_item = new uplink_items
		uplink_handler.extra_purchasable += uplink_item

/datum/uplink_item/contractor
	restricted = TRUE
	category = /datum/uplink_category/contractor
	purchasable_from = NONE //they will be added to extra_purchasable

//prevents buying contractor stuff before you make an account.
/datum/uplink_item/contractor/can_be_bought(datum/uplink_handler/uplink_handler)
	if(!uplink_handler.contractor_hub)
		return FALSE
	return ..()

/datum/uplink_item/contractor/reroll
	name = "Contract Reroll"
	desc = "Запросите смену текущего списка контрактов. Сгенерирует новую цель, \
		оплату и место сдачи текущих активных контрактов."
	item = ABSTRACT_UPLINK_ITEM
	limited_stock = 2
	cost = 0

/datum/uplink_item/contractor/reroll/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	//We're not regenerating already completed/aborted/extracting contracts, but we don't want to repeat their targets.
	var/list/new_target_list = list()
	for(var/datum/syndicate_contract/contract_check in uplink_handler.contractor_hub.assigned_contracts)
		if (contract_check.status != CONTRACT_STATUS_ACTIVE && contract_check.status != CONTRACT_STATUS_INACTIVE)
			if (contract_check.contract.target)
				new_target_list.Add(contract_check.contract.target)
			continue

	//Reroll contracts without duplicates
	for(var/datum/syndicate_contract/rerolling_contract in uplink_handler.contractor_hub.assigned_contracts)
		if (rerolling_contract.status != CONTRACT_STATUS_ACTIVE && rerolling_contract.status != CONTRACT_STATUS_INACTIVE)
			continue

		rerolling_contract.generate(new_target_list)
		new_target_list.Add(rerolling_contract.contract.target)

	//Set our target list with the new set we've generated.
	uplink_handler.contractor_hub.assigned_targets = new_target_list
	return source //for log icon

/datum/uplink_item/contractor/pinpointer
	name = "Contractor Pinpointer"
	desc = "Пинпойнтер, который позволяет найти цель без активных датчиков костюма. \
		Из-за использования уязвимости он не может \
		определить точное местоположение в отличие от традиционных моделей. \
		Становится навсегда привязанным к пользователю, который впервые активировал его."
	item = /obj/item/pinpointer/crew/contractor
	limited_stock = 2
	cost = 1

/datum/uplink_item/contractor/extraction_kit
	name = "Fulton Extraction Kit"
	desc = "Для доставки вашей цели через труднодоступные места станции к точке сдачи. \
		Разместите где-нибудь в безопасном месте маяк и свяжите его с ранцом. \
		Активация данного ранца отправит вашу цель к маяку - \
		убедитесь, что она не сбежит!"
	item = /obj/item/storage/box/contractor/fulton_extraction
	limited_stock = 1
	cost = 1

/datum/uplink_item/contractor/partner
	name = "Contractor Reinforcement"
	desc = "Оперативник прибудет к вам в качестве подкрепления, чтобы помочь в выполнении ваших целей, \
		Он получает оплату отдельно и не будет претендовать на ваш доход."
	item = /obj/item/antag_spawner/loadout/contractor
	limited_stock = 1
	cost = 2

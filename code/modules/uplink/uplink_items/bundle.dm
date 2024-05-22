//All bundles and telecrystals
/datum/uplink_category/bundle
	name = "Наборы"
	weight = 10

/datum/uplink_item/bundles_tc
	category = /datum/uplink_category/bundle
	surplus = 0
	cant_discount = TRUE
	purchasable_from = parent_type::purchasable_from & ~UPLINK_SPY

/datum/uplink_item/bundles_tc/random
	name = "Random Item"
	desc = "Выбор этого пункта покупает случайный предмет. Полезно, если у вас есть лишние TC или если вы не определились со стратегией."
	item = ABSTRACT_UPLINK_ITEM
	cost = 0
	cost_override_string = "Varies"

/datum/uplink_item/bundles_tc/random/purchase(mob/user, datum/uplink_handler/handler, atom/movable/source)
	var/list/possible_items = list()
	for(var/datum/uplink_item/item_path as anything in SStraitor.uplink_items_by_type)
		var/datum/uplink_item/uplink_item = SStraitor.uplink_items_by_type[item_path]
		if(src == uplink_item || !uplink_item.item)
			continue
		if(!handler.can_purchase_item(user, uplink_item))
			continue
		possible_items += uplink_item

	if(possible_items.len)
		var/datum/uplink_item/uplink_item = pick(possible_items)
		log_uplink("[key_name(user)] purchased a random uplink item from [handler.owner]'s uplink with [handler.telecrystals] telecrystals remaining")
		SSblackbox.record_feedback("tally", "traitor_random_uplink_items_gotten", 1, initial(uplink_item.name))
		handler.purchase_item(user, uplink_item)

/datum/uplink_item/bundles_tc/telecrystal
	name = "1 Raw Telecrystal"
	desc = "Телекристалл в его редком и чистейшем виде; Может быть использован на активном аплинке для увеличения количества телекристаллов."
	item = /obj/item/stack/telecrystal
	cost = 1
	// Don't add telecrystals to the purchase_log since
	// it's just used to buy more items (including itself!)
	purchase_log_vis = FALSE

/datum/uplink_item/bundles_tc/telecrystal/five
	name = "5 Raw Telecrystals"
	desc = "Пять телекристаллов в их сыром и чистом виде; могут быть использованы на активном аплинке для увеличения количества телекристаллов."
	item = /obj/item/stack/telecrystal/five
	cost = 5

/datum/uplink_item/bundles_tc/telecrystal/twenty
	name = "20 Raw Telecrystals"
	desc = "Двадцать телекристаллов в их сыром и чистом виде; могут быть использованы на активном аплинке для увеличения количества телекристаллов."
	item = /obj/item/stack/telecrystal/twenty
	cost = 20

/datum/uplink_item/bundles_tc/bundle_a
	name = "Syndi-kit Tactical"
	desc = "Набор Синдиката, также известный как Синди-набор, это специализированная группа предметов, которая прибывает в обычной коробке. \
			Эти предметы стоят более 25 телекристаллов, но вы не знаете специализацию предметов, \
			которую вы получите. Может содержать снятые с производства и/или экзотические предметы. \
			Синдикат предоставляет только один Синди-набор на агента."
	item = /obj/item/storage/box/syndicate/bundle_a
	cost = 20
	stock_key = UPLINK_SHARED_STOCK_KITS
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS | UPLINK_SPY)

/datum/uplink_item/bundles_tc/bundle_b
	name = "Syndi-kit Special"
	desc = "Набор Синдиката, также известный как Синди-набор, это специализированная группа предметов, которая прибывает в обычной коробке. \
			В особом Синди-наборе, вы получите предметы известных агентов Синдиката в прошлом. \
			Эти предметы стоят более 25 телекристаллов, синдикат любит хорошее возвращение. \
			Синдикат предоставляет только один Синди-набор на агента."
	item = /obj/item/storage/box/syndicate/bundle_b
	cost = 20
	stock_key = UPLINK_SHARED_STOCK_KITS
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS | UPLINK_SPY)

/datum/uplink_item/bundles_tc/surplus
	name = "Syndicate Surplus Crate"
	desc = "Пыльный ящик Синдиката с дальних полок склада, доставляется к вам путем капсулы снабжения. \
			Если слухи правдивы, то содержимое ящика зависит от вашей репутации. Начинайте её зарабатывать. \
			Содержимое ящика отсортировано и всегда стоит 30 TC. Синдикат предоставляет только один лишний предмет на агента."
	item = /obj/structure/closet/crate // will be replaced in purchase()
	cost = 20
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS | UPLINK_SPY)
	stock_key = UPLINK_SHARED_STOCK_SURPLUS
	/// Value of items inside the crate in TC
	var/crate_tc_value = 30
	/// crate that will be used for the surplus crate
	var/crate_type = /obj/structure/closet/crate

/// generates items that can go inside crates, edit this proc to change what items could go inside your specialized crate
/datum/uplink_item/bundles_tc/surplus/proc/generate_possible_items(mob/user, datum/uplink_handler/handler)
	var/list/possible_items = list()
	for(var/datum/uplink_item/item_path as anything in SStraitor.uplink_items_by_type)
		var/datum/uplink_item/uplink_item = SStraitor.uplink_items_by_type[item_path]
		if(src == uplink_item || !uplink_item.item)
			continue
		if(!handler.check_if_restricted(uplink_item))
			continue
		if(!uplink_item.surplus)
			continue
		if(handler.not_enough_reputation(uplink_item))
			continue
		possible_items += uplink_item
	return possible_items

/// picks items from the list given to proc and generates a valid uplink item that is less or equal to the amount of TC it can spend
/datum/uplink_item/bundles_tc/surplus/proc/pick_possible_item(list/possible_items, tc_budget)
	var/datum/uplink_item/uplink_item = pick(possible_items)
	if(prob(100 - uplink_item.surplus))
		return null
	if(tc_budget < uplink_item.cost)
		return null
	return uplink_item

/// fills the crate that will be given to the traitor, edit this to change the crate and how the item is filled
/datum/uplink_item/bundles_tc/surplus/proc/fill_crate(obj/structure/closet/crate/surplus_crate, list/possible_items)
	var/tc_budget = crate_tc_value
	while(tc_budget)
		var/datum/uplink_item/uplink_item = pick_possible_item(possible_items, tc_budget)
		if(!uplink_item)
			continue
		tc_budget -= uplink_item.cost
		new uplink_item.item(surplus_crate)

/// overwrites item spawning proc for surplus items to spawn an appropriate crate via a podspawn
/datum/uplink_item/bundles_tc/surplus/spawn_item(spawn_path, mob/user, datum/uplink_handler/handler, atom/movable/source)
	var/obj/structure/closet/crate/surplus_crate = new crate_type()
	if(!istype(surplus_crate))
		CRASH("crate_type is not a crate")
	var/list/possible_items = generate_possible_items(user, handler)

	fill_crate(surplus_crate, possible_items)

	podspawn(list(
		"target" = get_turf(user),
		"style" = STYLE_SYNDICATE,
		"spawn" = surplus_crate,
	))
	return source //For log icon

/datum/uplink_item/bundles_tc/surplus/united
	name = "United Surplus Crate"
	desc = "Блестящий и большой ящик, который доставляется к вам путем капсулы снабжения. Оснащён продвинутым механизмом замка с протоколом защиты от взлома. \
			Рекомендуется открывать его при наличии другого агента купившего ключ от ящика. Объединяйтесь и сражайтесь. \
			По слухам содержит ценный ассортимент предметов зависящих от вашей репутации, но никогда не знаешь точно. Содержимое ящика отсортировано и всегда стоит 80 TC. \
			Синдикат предоставляет только один лишний предмет на агента."
	cost = 20
	item = /obj/structure/closet/crate/secure/syndicrate
	stock_key = UPLINK_SHARED_STOCK_SURPLUS
	crate_tc_value = 80
	crate_type = /obj/structure/closet/crate/secure/syndicrate

/// edited version of fill crate for super surplus to ensure it can only be unlocked with the syndicrate key
/datum/uplink_item/bundles_tc/surplus/united/fill_crate(obj/structure/closet/crate/secure/syndicrate/surplus_crate, list/possible_items)
	if(!istype(surplus_crate))
		return
	var/tc_budget = crate_tc_value
	while(tc_budget)
		var/datum/uplink_item/uplink_item = pick_possible_item(possible_items, tc_budget)
		if(!uplink_item)
			continue
		tc_budget -= uplink_item.cost
		surplus_crate.unlock_contents += uplink_item.item

/datum/uplink_item/bundles_tc/surplus_key
	name = "United Surplus Crate Key"
	desc = "Это неприметное устройство на самом деле является ключом открывающим United Surplus Crate. Может быть использован один раз. \
			Изначально был разработан для повышения сотрудничества, но агенты быстро обнаружили, что могут открыть ящик самостоятельно.  \
			Синдикат предоставляет только один лишний предмет на агента."
	cost = 20
	item = /obj/item/syndicrate_key
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS | UPLINK_SPY)
	stock_key = UPLINK_SHARED_STOCK_SURPLUS

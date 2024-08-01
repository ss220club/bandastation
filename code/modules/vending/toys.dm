/obj/machinery/vending/donksofttoyvendor
	name = "\improper Donksoft Toy Vendor"
	desc = "Ages 8 and up approved vendor that dispenses toys."
	icon_state = "nt-donk"
	panel_type = "panel18"
	product_slogans = "Получите свои крутые игрушки уже сегодня!;Легализируйте охоту уже сегодня!;Качественное игрушечное оружие по низким ценам!;Отдайте их ГП за полный доступ!;Отдайте их ХоСу, чтобы вас отправили в перму!"
	product_ads = "Почувствуй себя робастом с нашими игрушками!;Вернитесь в детство уже сегодня!;Игрушечное оружие не убивает, но вы можете попробовать!;Кому нужна ответственность, когда есть игрушечное оружие?;Сделайте своё следующее убийство ВЕСЕЛЫМ!"
	vend_reply = "Возвращайтесь за добавкой!"
	light_mask = "donksoft-light-mask"
	circuit = /obj/item/circuitboard/machine/vending/donksofttoyvendor
	products = list(
		/obj/item/gun/ballistic/automatic/toy/unrestricted = 10,
		/obj/item/gun/ballistic/automatic/pistol/toy = 10,
		/obj/item/gun/ballistic/shotgun/toy/unrestricted = 10,
		/obj/item/toy/sword = 10,
		/obj/item/ammo_box/foambox = 20,
		/obj/item/toy/foamblade = 10,
		/obj/item/toy/balloon/syndicate = 10,
		/obj/item/clothing/suit/syndicatefake = 5,
		/obj/item/clothing/head/syndicatefake = 5,
	)
	contraband = list(
		/obj/item/gun/ballistic/shotgun/toy/crossbow = 10,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted = 10,
		/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted = 10,
		/obj/item/toy/katana = 10,
		/obj/item/dualsaber/toy = 5,
	)
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/donksoft
	machine_name = "Donksoft Toy Vendor"
	icon_state = "refill_donksoft"

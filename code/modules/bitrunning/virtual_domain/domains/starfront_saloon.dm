/datum/lazy_template/virtual_domain/starfront_saloon
	name = "Салун \"Звездный фронт\""
	cost = BITRUNNER_COST_MEDIUM
	desc = "Видимо, ты забрел не на ту улицу, партнер. Надеемся, что ты умеешь стрелять."
	difficulty = BITRUNNER_DIFFICULTY_HIGH
	help_text = "Одна из комнат имеет нужный нам ящик. Найдите его и выбирайтесь."
	is_modular = TRUE
	key = "starfront_saloon"
	map_name = "starfront_saloon"
	mob_modules = list(
		/datum/modular_mob_segment/syndicate_team,
		/datum/modular_mob_segment/syndicate_elite,
	)
	reward_points = BITRUNNER_REWARD_HIGH

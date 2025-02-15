/datum/species/tajaran
	name = "\improper Таяран"
	plural_form = "Таяры"
	id = SPECIES_TAJARAN
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_CATLIKE_GRACE,
		TRAIT_HATED_BY_DOGS,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	species_language_holder = /datum/language_holder/tajaran
	digitigrade_customization = DIGITIGRADE_FORCED

	mutantbrain = /obj/item/organ/brain/tajaran
	mutantheart = /obj/item/organ/heart/tajaran
	mutantlungs = /obj/item/organ/lungs/tajaran
	mutanteyes = /obj/item/organ/eyes/tajaran
	mutantears = /obj/item/organ/ears/tajaran
	mutanttongue = /obj/item/organ/tongue/tajaran
	mutantliver = /obj/item/organ/liver/tajaran
	mutantstomach = /obj/item/organ/stomach/tajaran
	mutant_organs = list(
		/obj/item/organ/tail/tajaran = "Long tail",
	)

	body_markings = list(/datum/bodypart_overlay/simple/body_marking/tajaran = "None")
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/tajaran,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/tajaran,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/tajaran,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/tajaran,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/tajaran,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/tajaran,
	)

	coldmod = 0.7
	heatmod = 1.3
	payday_modifier = 0.9
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT + 15
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT - 30

/datum/species/tajaran/prepare_human_for_preview(mob/living/carbon/human/tajaran)
	tajaran.set_hairstyle("None", update = TRUE)
	tajaran.dna.features["tajaran_facial_hair"] = "None"
	tajaran.dna.features["mcolor"] = "#e5b380"
	tajaran.dna.features["tajaran_head_markings"] = "Muzzle and Inner ears"
	tajaran.update_body(is_creating = TRUE)

/datum/species/tajaran/randomize_features()
	var/list/features = ..()
	features["tajaran_body_markings"] = prob(50) ? pick(SSaccessories.tajaran_body_markings_list) : "None"
	features["tajaran_head_markings"] = prob(50) ? pick(SSaccessories.tajaran_head_markings_list) : "None"
	features["tajaran_tail_markings"] = prob(50) ? pick(SSaccessories.tajaran_tail_markings_list) : "None"
	features["tajaran_facial_hair"] = prob(50) ? pick(SSaccessories.tajaran_facial_hair_list) : "None"

	var/furcolor = "#[random_color()]"
	features["furcolor_tajaran_first"] = furcolor
	features["furcolor_tajaran_second"] = furcolor
	features["furcolor_tajaran_third"] = furcolor
	features["furcolor_tajaran_fourth"] = furcolor
	return features

/datum/species/tajaran/get_physical_attributes()
	return "Таяран — разновидность преимущественно плотоядных антропоморфных гуманоидов. \
	Существует заметный половой диморфизм между женскими и мужскими особями в пользу мужских и, в зависимости от подрасы, рост взрослых таяран, за исключением подрасы Жан-Хазан. \
	В ходе взросления не выходит за пределы от 135 до 170 см, а вес варьируется в передах от 30 до 65 кг.  \
	Длинный хвост, составляющий 4/5 от роста, выполняет функцию балансира при передвижениях. \
	Тело почти полностью покрыто густой шерстью, некоторые особи имеют заметную гриву вдоль затылка и височных областей головы."

/datum/species/tajaran/get_species_description()
	return "Вид гуманоидных всеядных млекопитающих, имеющих внешнее сходство с земными кошачьими. Таяры происходят с Адомая, планеты с разнообразным климатом, \
	одной из пары землеподобных планет (вторая, более крупная, именуется Илук), вращающихся на орбите парных звёзд С’рандарр и Месса в секторе HD 4391."

/datum/species/tajaran/get_species_lore()
	return list(
		"Сотни лет таяры находились в рабстве у другой расы технологически развитых пришельцев, называемых таярами «Рабовладельцами», \
		которые жестоко эксплуатировали коренное население, заставляя его добывать для них ресурсы на многочисленных шахтах богатого полезными ископаемыми Адомая. \
		Принудительное служение «Рабовладельцам» подавило культурное и технологическое развитие таяр, что привело их к стагнации. \
		Ввиду отсутствия сохранившихся записей на момент первого контакта, точные даты событий не удалось установить, однако, изучив устные предания народа таяр, \
		учёным историкам удалось выяснить, что примерно в начале XXII века по земному летоисчислению «Рабовладельцы» создали контролирующий орган власти под названием «Совет Алхимиков», который существует и по сей день.",

		"Желание таяр свободы, подстегиваемое природным любопытством о получении новых знаний, а также осознание того факта, \
		что именно сейчас лучший момент для начала восстания из-за прибывших космических сил унатхов, устроивших шумиху в космическом пространстве планеты в 2485 году, \
		привело к восстанию в экваториальных регионах Адомая с целью обретения независимости. «Рабовладельцы», ввиду самоуверенности местных администраций и развитой за годы спокойной жизни бюрократии, \
		оказались к этому не готовы, в ряде регионов восстания неожиданно достигли успеха, что привело к ещё большему количеству восстаний. В 2486 году раса таяран попыталась связаться с прибывшим флотом унатхов и запросили поддержки в наземном сопротивлении для укрепления своих позиций, эта попытка увенчалась успехом.",

		"Силы унатхов помогали таярам в борьбе с Советом Алхимиков на планете с 2486 года. И если первую просьбу о помощи повстанцы таяран передали «на удачу», \
		просто обнаружив неизвестные сигналы в космосе у планеты, то совместные наземные операции были невозможны без понимания друг друга обеими расами. \
		Корабельные ИИ унатхов кое-как справлялись с дешифровкой сообщений от таяран и передачей обратно сообщений от унатхов, \
		но даже мощностей всех ИИ не хватило бы для координации наземных операций. Получив подтверждение о том, что сухопутная поддержка будет оказана — самые гибкие умы с обеих сторон принялись разрабатывать специфичный, унитарный язык. \
		В дальнейшем Сик’Унати как язык эволюционировал в Синта’Тайр, став основным способом общения между таярами и унатхами, преподавание этого языка до сих пор ведётся у обеих рас.",

		"Освободившись от гнета захватчиков, но потеряв подавляющее большинство образованных членов общества, таяры, \
		были неспособны организовать своё общество из-за столетий пребывания в рабстве и почти полностью остановились в освоении технологий, которые остались им в наследство после «Рабовладельцев», \
		к которым у них ранее не было доступа. После некоторого замешательства, дом Хадии выступил с предложением возглавить таяр. \
		Все прочие представители расы, ввиду отсутствия руководства, приняли предложение повсеместно. Вместе с домом Сэндай, дом Хадии восстановил «Совет Алхимиков» в новом виде для развития науки всего народа таяр, а не только правящей верхушки, они, к сожалению, \
		не уделили столько же внимания технологиям, сколько уделили культуре, поэтому, на момент первого контакта с людьми, \
		эта цивилизация только начала попытки создать первые двигатели для космических кораблей. Как единственная на тот момент правящая ячейка, \
		дом Хадии выступил как принимающая сторона для императрицы с целью заключения союза в 2493 году. Первый контакт с Человеко-Скреллианским Альянсом В 2511 году малый экспедиционный флот проекта «Новые Горизонты» \
		(на 61 % профинансированный корпорацией Nanotrasen) с его флагманами ИКН «Хокинг» и МИК «Академик Старобинский» во главе, призванный объединить усилия по освоению галактики и, благодаря этому, \
		снизить напряженность в отношениях между крупнейшими политическими структурами обитаемого космоса, сблизился с Адомаем и Илук. Первый контакт с людьми прошел не очень гладко — таяры, недавно добившиеся свободы, \
		еще слишком хорошо помнили своих угнетателей и отнеслись к новым пришельцам достаточно настороженно, однако не встретив агрессивных действий от представителей человечества, согласились на переговоры, \
		которые продлились почти 4 года, после чего было заключено соглашение о вступлении таяр в галактическое сообщество на равных правах с остальными его участниками. В 2515 году таяры были внесены в реестр младших рас галактического сообщества, а корпорация Nanotrasen победила в тендере на подъём технологического уровня Адомая.",
	)

/datum/species/tajaran/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "assistive-listening-systems",
			SPECIES_PERK_NAME = "Чувствительный слух",
			SPECIES_PERK_DESC = "[plural_form] лучше слышат, но более чувствительны к громким звукам, например, светошумовым гранатам.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "eye",
			SPECIES_PERK_NAME = "Ночное зрение",
			SPECIES_PERK_DESC = "[plural_form] немного лучше видят в темноте, однако их глаза более чувствительны к ярким вспышкам.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "dog",
			SPECIES_PERK_NAME = "Нелюбимы собаками",
			SPECIES_PERK_DESC = "Собаки, по какой-то причине, проявляют повышенный интерес в сторону таяр.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
			SPECIES_PERK_NAME = "Таярская грация",
			SPECIES_PERK_DESC = "[plural_form] обладают схожими с кошачьими инстинктами, позволяющими им приземляться вертикально на ноги.  \
				Вместо того чтобы быть сбитым с ног при падении, вы получаете лишь короткое замедление. \
				Однако однако никто не гарантирует безопасность подобных действий, и падение может нанести дополнительный урон.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "grin-tongue",
			SPECIES_PERK_NAME = "Внимательный уход",
			SPECIES_PERK_DESC = "[plural_form] могут зализывать раны, чтобы уменьшить кровотечение.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire-alt",
			SPECIES_PERK_NAME = "Быстрый метаболизм",
			SPECIES_PERK_DESC = "[plural_form] быстрее тратят полезные вещества, потому чаще хотят есть.",
		),
	)

	return to_add

/datum/species/tajaran/create_pref_temperature_perks()
	return list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "temperature-low",
			SPECIES_PERK_NAME = "Термоустойчивость",
			SPECIES_PERK_DESC = "[plural_form] лучше переносят перепады температур.",))

/datum/species/tajaran/create_pref_liver_perks()
	return list(list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "wine-glass",
			SPECIES_PERK_NAME = "Чувствительность к алкоголю",
			SPECIES_PERK_DESC = "Таярская печень более восприимчива к алкоголю, чем печень человека, примерно на 150%."
		))

/datum/species/tajaran/create_pref_language_perk()
	return list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "comment",
			SPECIES_PERK_NAME = "Носитель языка",
			SPECIES_PERK_DESC = "[plural_form] получают возможность говорить на Сик'Таире.",
		))

/datum/species/tajaran/get_scream_sound(mob/living/carbon/human/tajaran)
	if(tajaran.physique == FEMALE)
		return 'modular_bandastation/emote_panel/audio/tajaran/tajaran_scream.ogg'
	return 'modular_bandastation/emote_panel/audio/tajaran/tajaran_scream.ogg'

/datum/species/tajaran/get_sigh_sound(mob/living/carbon/human/tajaran)
	if(tajaran.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/sigh/female_sigh1.ogg',
			'sound/mobs/humanoids/human/sigh/female_sigh2.ogg',
			'sound/mobs/humanoids/human/sigh/female_sigh3.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/sigh/male_sigh1.ogg',
		'sound/mobs/humanoids/human/sigh/male_sigh2.ogg',
		'sound/mobs/humanoids/human/sigh/male_sigh3.ogg',
	)

/datum/species/tajaran/get_cough_sound(mob/living/carbon/human/tajaran)
	if(tajaran.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cough/female_cough1.ogg',
			'sound/mobs/humanoids/human/cough/female_cough2.ogg',
			'sound/mobs/humanoids/human/cough/female_cough3.ogg',
			'sound/mobs/humanoids/human/cough/female_cough4.ogg',
			'sound/mobs/humanoids/human/cough/female_cough5.ogg',
			'sound/mobs/humanoids/human/cough/female_cough6.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cough/male_cough1.ogg',
		'sound/mobs/humanoids/human/cough/male_cough2.ogg',
		'sound/mobs/humanoids/human/cough/male_cough3.ogg',
		'sound/mobs/humanoids/human/cough/male_cough4.ogg',
		'sound/mobs/humanoids/human/cough/male_cough5.ogg',
		'sound/mobs/humanoids/human/cough/male_cough6.ogg',
	)

/datum/species/tajaran/get_cry_sound(mob/living/carbon/human/tajaran)
	if(tajaran.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cry/female_cry1.ogg',
			'sound/mobs/humanoids/human/cry/female_cry2.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cry/male_cry1.ogg',
		'sound/mobs/humanoids/human/cry/male_cry2.ogg',
		'sound/mobs/humanoids/human/cry/male_cry3.ogg',
	)

/datum/species/tajaran/get_sneeze_sound(mob/living/carbon/human/tajaran)
	if(tajaran.physique == FEMALE)
		return pick(
			'modular_bandastation/emote_panel/audio/tajaran/tajaran_sneeze_female1.ogg',
			'modular_bandastation/emote_panel/audio/tajaran/tajaran_sneeze_female2.ogg',
		)
	return 'modular_bandastation/emote_panel/audio/tajaran/tajaran_sneeze_male.ogg'

/datum/species/tajaran/get_laugh_sound(mob/living/carbon/human/tajaran)
	if(!ishuman(tajaran))
		return
	if(tajaran.physique == FEMALE)
		return 'sound/mobs/humanoids/human/laugh/womanlaugh.ogg'
	return pick(
		'sound/mobs/humanoids/human/laugh/manlaugh1.ogg',
		'sound/mobs/humanoids/human/laugh/manlaugh2.ogg',
	)

/datum/species/tajaran/add_body_markings(mob/living/carbon/human/tajaran) // OVERRIDE /datum/species/proc/add_body_markings
	for(var/markings_type in body_markings)
		var/datum/bodypart_overlay/simple/body_marking/markings = new markings_type()
		var/accessory_name = tajaran.dna.features[markings.dna_feature_key]
		var/datum/sprite_accessory/tajaran_body_markings/accessory = markings.get_accessory(accessory_name)

		if(isnull(accessory))
			return

		for(var/obj/item/bodypart/part as anything in markings.applies_to)
			var/obj/item/bodypart/people_part = tajaran.get_bodypart(initial(part.body_zone))

			if(!people_part || !istype(people_part, part))
				continue

			var/datum/bodypart_overlay/simple/body_marking/tajaran/overlay = new markings_type ()

			overlay.icon = accessory.icon
			overlay.icon_state = accessory.icon_state
			overlay.use_gender = accessory.gender_specific
			overlay.draw_color = accessory.color_src ? tajaran.dna.features["furcolor_tajaran_first"] : null

			if(istype(accessory, /datum/sprite_accessory/tajaran_body_markings) && accessory.colored_paws && (istype(people_part, /obj/item/bodypart/arm/left/tajaran) || istype(people_part, /obj/item/bodypart/arm/right/tajaran)))
				overlay.aux_color_paw = accessory.color_src ? tajaran.dna.features["furcolor_tajaran_first"] : null

			if((istype(people_part, /obj/item/bodypart/leg/left/digitigrade/tajaran) || istype(people_part, /obj/item/bodypart/leg/right/digitigrade/tajaran))) {
				overlay.icon_state = overlay.icon_state + "_digi"
			}
			people_part.add_bodypart_overlay(overlay)

/datum/species/tajaran/replace_body(mob/living/carbon/target, datum/species/new_species)
	var/list/final_bodypart_overrides = new_species.bodypart_overrides.Copy()
	if((new_species.digitigrade_customization == DIGITIGRADE_OPTIONAL && target.dna.features["legs"] == DIGITIGRADE_LEGS) || new_species.digitigrade_customization == DIGITIGRADE_FORCED)
		final_bodypart_overrides[BODY_ZONE_R_LEG] = /obj/item/bodypart/leg/right/digitigrade/tajaran
		final_bodypart_overrides[BODY_ZONE_L_LEG] = /obj/item/bodypart/leg/left/digitigrade/tajaran

	for(var/obj/item/bodypart/old_part as anything in target.bodyparts)
		if((old_part.change_exempt_flags & BP_BLOCK_CHANGE_SPECIES) || (old_part.bodypart_flags & BODYPART_IMPLANTED))
			continue

		var/path = final_bodypart_overrides?[old_part.body_zone]
		var/obj/item/bodypart/new_part
		if(path)
			new_part = new path()
			new_part.replace_limb(target, TRUE)
			new_part.update_limb(is_creating = TRUE)
			new_part.set_initial_damage(old_part.brute_dam, old_part.burn_dam)
		qdel(old_part)

/obj/item/bodypart/head/get_hair_and_lips_icon(dropped)
	. = ..()
	var/image_dir = NONE
	if(dropped)
		image_dir = SOUTH
	var/image/facial_hair_overlay
	var/datum/sprite_accessory/sprite_accessory
	var/mob/living/carbon/human/user = src.owner
	if(istype(user) && user.dna && (head_flags & HEAD_TAJARAN))
		sprite_accessory = SSaccessories.tajaran_head_markings_list[user.dna.features["tajaran_head_markings"]]
		if(sprite_accessory)
			facial_hair_overlay = image(sprite_accessory.icon, "m_tajaran_head_markings_[sprite_accessory.icon_state]_ADJ", -BODY_ADJ_LAYER, image_dir)
			facial_hair_overlay.color = user.dna.features["furcolor_tajaran_second"]
			. += facial_hair_overlay

		sprite_accessory = SSaccessories.tajaran_facial_hair_list[user.dna.features["tajaran_facial_hair"]]
		if(sprite_accessory)
			facial_hair_overlay = image(sprite_accessory.icon, "m_tajaran_facial_hair_[sprite_accessory.icon_state]_ADJ", -BODY_ADJ_LAYER, image_dir)
			facial_hair_overlay.color = user.dna.features["furcolor_tajaran_fourth"]
			. += facial_hair_overlay
	return .

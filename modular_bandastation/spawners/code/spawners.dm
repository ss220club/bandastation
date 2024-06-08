// Placeholder object, used for ispath checks. Has to be defined to prevent errors, but shouldn't ever be created.
/datum/nothing

/// ID skins spawners
/obj/effect/spawner/random/id_skins
	name = "Случайная наклейка на карту"
	icon = 'modular_bandastation/spawners/icons/spawners.dmi'
	icon_state = "ID_Random"
	loot = list(
		/obj/item/id_skin/colored = 10,
		/obj/item/id_skin/donut = 5,
		/obj/item/id_skin/business = 5,
		/obj/item/id_skin/ussp = 5,
		/obj/item/id_skin/colored/silver = 5,
		/obj/item/id_skin/silver = 5,
		/obj/item/id_skin/gold = 1,
		/obj/item/id_skin/lifetime = 1,
		/obj/item/id_skin/clown = 1,
		/obj/item/id_skin/neon = 1,
		/obj/item/id_skin/colored/neon = 1,
		/obj/item/id_skin/missing = 1,
		/obj/item/id_skin/ouija = 1,
		/obj/item/id_skin/paradise = 1,
		/obj/item/id_skin/rainbow = 1,
		/obj/item/id_skin/space = 1,
		/obj/item/id_skin/kitty = 1,
		/obj/item/id_skin/colored/kitty = 1,
		/obj/item/id_skin/cursedmiku = 1,
		/obj/item/id_skin/colored/snake = 1,
		/obj/item/id_skin/magic = 1,
		/obj/item/id_skin/terminal = 1,
		/obj/item/id_skin/jokerge = 1,
		/obj/item/id_skin/boykisser = 1
	)

/obj/effect/spawner/random/id_skins/no_chance
	loot = list(
		/datum/nothing = 80,
		/obj/item/id_skin/colored = 10,
		/obj/item/id_skin/donut = 5,
		/obj/item/id_skin/business = 5,
		/obj/item/id_skin/ussp = 5,
		/obj/item/id_skin/colored/silver = 5,
		/obj/item/id_skin/silver = 5,
		/obj/item/id_skin/gold = 1,
		/obj/item/id_skin/lifetime = 1,
		/obj/item/id_skin/clown = 1,
		/obj/item/id_skin/neon = 1,
		/obj/item/id_skin/colored/neon = 1,
		/obj/item/id_skin/missing = 1,
		/obj/item/id_skin/ouija = 1,
		/obj/item/id_skin/paradise = 1,
		/obj/item/id_skin/rainbow = 1,
		/obj/item/id_skin/space = 1,
		/obj/item/id_skin/kitty = 1,
		/obj/item/id_skin/colored/kitty = 1,
		/obj/item/id_skin/cursedmiku = 1,
		/obj/item/id_skin/colored/snake = 1,
		/obj/item/id_skin/magic = 1,
		/obj/item/id_skin/terminal = 1,
		/obj/item/id_skin/jokerge = 1,
		/obj/item/id_skin/boykisser = 1
	)

/// Food spawners
/obj/effect/spawner/random/food_or_drink/CCfood

/obj/effect/spawner/random/food_or_drink/CCfood/desert
	spawn_loot_count = 5
	loot = list(
		/obj/item/food/baguette = 10,
		/obj/item/food/pie/applepie = 10,
		/obj/item/food/breadslice/banana = 10,
		/obj/item/food/cakeslice/berry_vanilla_cake = 10,
		/obj/item/food/cakeslice/carrot = 10,
		/obj/item/food/croissant = 10,
		/obj/item/reagent_containers/cup/soda_cans/cola = 10,
	)

/obj/effect/spawner/random/food_or_drink/CCfood/meat
	spawn_loot_count = 5
	loot = list(
		/obj/item/food/lasagna = 10,
		/obj/item/food/burger/bigbite = 10,
		/obj/item/food/fishandchips = 10,
		/obj/item/food/burger/fish = 10,
		/obj/item/food/hotdog = 10,
		/obj/item/food/pie/meatpie = 10,
		/obj/item/reagent_containers/cup/soda_cans/cola = 10,
	)

/obj/effect/spawner/random/food_or_drink/CCfood/alcohol
	spawn_loot_count = 1
	loot = list(
		/obj/item/reagent_containers/cup/glass/bottle/whiskey = 10,
		/obj/item/reagent_containers/cup/soda_cans/tonic = 10,
		/obj/item/reagent_containers/cup/soda_cans/thirteenloko = 10,
		/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind = 10,
		/obj/item/reagent_containers/cup/soda_cans/lemon_lime = 10,
	)

/// Maint loot spawners
/obj/effect/spawner/random/maintenance
	icon = 'modular_bandastation/spawners/icons/spawners.dmi'

/obj/effect/spawner/random/maintenance/three
	icon_state = "trippleloot"

/obj/effect/spawner/random/maintenance/five
	name = "maintenance loot spawner (5 items)"
	icon_state = "moreloot"
	spawn_loot_count = 5

/// Random spawners
/obj/effect/spawner/random/mod
	icon = 'modular_bandastation/spawners/icons/spawners.dmi'
	icon_state = "mod"

/obj/effect/spawner/random/syndicate/loot
	icon = 'modular_bandastation/spawners/icons/spawners.dmi'
	icon_state = "common"

/obj/effect/spawner/random/syndicate/loot/level2
	icon_state = "rare"

/obj/effect/spawner/random/syndicate/loot/level3
	icon_state = "officer"

/obj/effect/spawner/random/syndicate/loot/level4
	icon_state = "armory"

/obj/effect/spawner/random/syndicate/loot/stetchkin
	icon_state = "stetchkin"

/obj/item/reagent_containers/pill/random_drugs
	icon = 'modular_bandastation/spawners/icons/spawners.dmi'
	icon_state = "pills"

/// Space battle spawners
/datum/outfit/corpse_spacebattle
	uniform = /obj/item/clothing/under/color/random
	id = /obj/item/card/id/away/old
	shoes = /obj/item/clothing/shoes/sneakers/black

/obj/effect/mob_spawn/corpse/spacebattle/assistant
	name = "Dead Civilian"
	mob_name = "Ship Personnel"
	outfit = /datum/outfit/corpse_spacebattle

/datum/outfit/corpse_spacebattle_sec
	id = /obj/item/card/id/away/old/sec
	uniform = /obj/item/clothing/under/rank/security
	belt = /obj/item/storage/belt/holster
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet
	gloves = /obj/item/clothing/gloves/fingerless
	back = /obj/item/storage/backpack/satchel/sec
	suit_store = /obj/item/gun/ballistic/automatic/pistol/beretta
	backpack_contents = list(
		/obj/item/ammo_box/magazine/beretta,
		/obj/item/ammo_box/beretta,
	)

/obj/effect/mob_spawn/corpse/spacebattle/security
	name = "Dead Officer"
	mob_name = "Ship Officer"
	outfit = /datum/outfit/corpse_spacebattle_sec

/datum/outfit/corpse_spacebattle_engi
	id = /obj/item/card/id/away/old/eng
	uniform = /obj/item/clothing/under/rank/engineering
	belt = /obj/item/storage/belt/utility/full
	suit = /obj/item/clothing/suit/hazardvest
	shoes = /obj/item/clothing/shoes/workboots
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/utility/hardhat/orange
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/yellow
	back = /obj/item/storage/backpack/duffelbag/engineering
	backpack_contents = list(
		/obj/item/storage/box/emergencytank = 1,
		/obj/item/clothing/head/utility/welding = 1,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/stock_parts/cell/high = 1,
	)
/obj/effect/mob_spawn/corpse/spacebattle/engineer
	name = "Dead Engineer"
	mob_name = "Engineer"
	outfit = /datum/outfit/corpse_spacebattle_engi

/datum/outfit/corpse_spacebattle_engi/space
	suit = /obj/item/clothing/suit/space/eva
	head = /obj/item/clothing/head/helmet/space/eva
	shoes = /obj/item/clothing/shoes/magboots

/obj/effect/mob_spawn/corpse/spacebattle/engineer/space
	outfit = /datum/outfit/corpse_spacebattle_engi/space

/datum/outfit/corpse_spacebattle_medic
	id_trim = /datum/id_trim/job/medical_doctor
	uniform = /obj/item/clothing/under/rank/medical
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/sneakers/white
	back = /obj/item/storage/backpack/satchel/med
	backpack_contents = list(
		/obj/item/storage/medkit/regular = 1,
		/obj/item/storage/pill_bottle/probital = 1,
	)

/obj/effect/mob_spawn/corpse/spacebattle/medic
	name = "Dead Medic"
	mob_name = "Medic"

/datum/outfit/corpse_spacebattle_bridgeofficer
	id = /obj/item/card/id/away/old/sec
	uniform = /obj/item/clothing/under/rank/captain
	belt = /obj/item/storage/belt/holster
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet/military
	gloves = /obj/item/clothing/gloves/fingerless
	back = /obj/item/storage/backpack/satchel/sec
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/aiuri = 1,
		/obj/item/reagent_containers/pill/patch/libital = 1,
		/obj/item/stock_parts/cell/high = 1,
		/obj/item/storage/box/breacherslug = 1,
	)

/obj/effect/mob_spawn/corpse/spacebattle/bridgeofficer
	name = "Bridge Officer"
	mob_name = "Bridge Officer"
	outfit = /datum/outfit/corpse_spacebattle_bridgeofficer

/datum/outfit/corpse_spacebattle_sci
	id = /obj/item/card/id/away/old/sci
	uniform = /obj/item/clothing/under/rank/rnd
	shoes = /obj/item/clothing/shoes/sneakers/black
	suit = /obj/item/clothing/suit/toggle/labcoat/science

/obj/effect/mob_spawn/corpse/spacebattle/scientist
	name = "Dead Scientist"
	mob_name = "Scientist"
	outfit = /datum/outfit/corpse_spacebattle_sci

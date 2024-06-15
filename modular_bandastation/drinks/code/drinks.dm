/datum/reagent/consumable/kvass
	name = "Квас"
	description = "Напиток, приготовленный путем брожения хлеба, ржи или ячменя, который обладает освежающим и слегка кисловатым вкусом."
	color = "#351300"
	nutriment_factor = 1
	taste_description = "приятную кислинку с легкой сладостью и хлебным послевкусием."

/datum/glass_style/drinking_glass/kvass
	required_drink_type = /datum/reagent/consumable/kvass
	name = "стакан кваса"
	desc = "В стакане кристально чистая жидкость насыщенного темно-коричневого цвета, которая кажется почти янтарной при определенном угле освещения."
	icon = 'modular_bandastation/drinks/icons/drinks.dmi'
	icon_state = "kvass"

/datum/export/large/reagent_dispenser/kvass
	unit_name = "kvasstank"
	export_types = list(/obj/structure/reagent_dispensers/kvasstank)

/obj/structure/reagent_dispensers/kvasstank
	name = "бочка кваса"
	desc = "Желтая бочка с напитком богов."
	icon = 'modular_bandastation/drinks/icons/chemical_tanks.dmi'
	icon_state = "kvass"
	reagent_id = /datum/reagent/consumable/kvass
	openable = TRUE

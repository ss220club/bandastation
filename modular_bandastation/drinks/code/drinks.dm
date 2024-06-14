/datum/reagent/consumable/kvass
	name = "Квас"
	description = "Напиток, приготовленный путем брожения хлеба, ржи или ячменя, который обладает освежающим и слегка кисловатым вкусом."
	color = "#351300"
	taste_description = "приятную кислинку с легкой сладостью и хлебным послевкусием."

/datum/glass_style/drinking_glass/kvass
	required_drink_type = /datum/reagent/consumable/kvass
	name = "Стакан кваса"
	desc = "Стакан с квасом."
	icon = 'modular_bandastation/drinks/icons/drinks.dmi'
	icon_state = "kvass"

/datum/reagent/consumable/kvass/on_mob_life(mob/living/carbon/affected_mob, delta_time, times_fired)
	affected_mob.adjustToxLoss(-0.5, FALSE, required_biotype = affected_biotype)
	affected_mob.adjustOrganLoss(ORGAN_SLOT_LIVER, -0.5 * REM * delta_time, required_organ_flag = ORGAN_ORGANIC)
	for(var/datum/reagent/toxin/R in affected_mob.reagents.reagent_list)
		affected_mob.reagents.remove_reagent(R.type, 2.5 * REM * delta_time)
	..()

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

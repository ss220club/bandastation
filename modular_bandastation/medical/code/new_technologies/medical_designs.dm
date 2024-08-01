/datum/techweb_node/surgery_tools
	id = "surgery_tools"
	display_name = "Advanced Surgery Tools"
	description = "Surgical instruments of dual purpose for quick operations."
	prereq_ids = list("surgery_exp")
	design_ids = list(
		"laserscalpel",
		"searingtool",
		"mechanicalpinches",
		"autocompressor"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/autopsy/xenomorph = TECHWEB_TIER_4_POINTS)

/datum/design/autocompressor
	name = "Autocompressor"
	desc = "A chest mounted device for automatic CPR in oxygen enviroment."
	id = "autocompressor"
	build_path = /obj/item/clothing/suit/autocompressor
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/diamond =SMALL_MATERIAL_AMOUNT * 1, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*1)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL


/datum/techweb_node/medbay_equip_adv
	id = "medbay_equip_adv"
	display_name = "Advanced Medbay Equipment"
	description = "State-of-the-art medical gear for keeping the crew in one piece — mostly."
	prereq_ids = list("cryostasis")
	design_ids = list(
		"chem_mass_spec",
		"healthanalyzer_advanced",
		"mod_health_analyzer",
		"crewpinpointer",
		"defibrillator_compact",
		"defibmount",
		"medicalbed_emergency",
		"fieldkit",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)

/datum/design/field_kit
	name = "Field Kit"
	id = "fieldkit"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*0.33)
	build_path = /obj/item/storage/field_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/chem_synthesis
	id = "chem_synthesis"
	display_name = "Chemical Synthesis"
	description = "Synthesizing complex chemicals from electricity and thin air... Don't ask how..."
	prereq_ids = list("medbay_equip")
	design_ids = list(
		"xlarge_beaker",
		"blood_pack",
		"chem_pack",
		"med_spray_bottle",
		"medigel",
		"medipen_refiller",
		"soda_dispenser",
		"beer_dispenser",
		"chem_dispenser",
		"portable_chem_mixer",
		"chem_heater",
		"w-recycler",
		"chembag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/design/chem_bag
	name = "Chemistry holding bag"
	id = "chembag"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/storage/chem_bag
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/surgery_adv
	id = "surgery_adv"
	display_name = "Advanced Surgery"
	description = "When simple medicine doesn't cut it."
	prereq_ids = list("surgery")
	design_ids = list(
		"harvester",
		"surgery_heal_brute_upgrade_femto",
		"surgery_heal_burn_upgrade_femto",
		"surgery_heal_combo",
		"surgery_lobotomy",
		"surgery_wing_reconstruction",
		"surgerytablev2",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	required_experiments = list(/datum/experiment/autopsy/human)

/datum/design/surgerytablev2
	name = "Advanced surgery table"
	id = "surgerytablev2"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*0.4, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.1)
	build_path = /obj/item/circuitboard/machine/surgerytablev2
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/alien_surgery
	id = "alien_surgery"
	display_name = "Alien Surgery"
	description = "Abductors did nothing wrong."
	prereq_ids = list("alientech", "surgery_tools")
	design_ids = list(
		"alien_cautery",
		"alien_drill",
		"alien_hemostat",
		"alien_retractor",
		"alien_saw",
		"alien_scalpel",
		"surgery_brainwashing",
		"surgery_heal_combo_upgrade_femto",
		"surgery_zombie",
		"surgerytablev3",
	)
	required_items_to_unlock = list(
		/obj/item/abductor,
		/obj/item/cautery/alien,
		/obj/item/circuitboard/machine/abductor,
		/obj/item/circular_saw/alien,
		/obj/item/crowbar/abductor,
		/obj/item/gun/energy/alien,
		/obj/item/gun/energy/shrink_ray,
		/obj/item/hemostat/alien,
		/obj/item/melee/baton/abductor,
		/obj/item/multitool/abductor,
		/obj/item/retractor/alien,
		/obj/item/scalpel/alien,
		/obj/item/screwdriver/abductor,
		/obj/item/surgicaldrill/alien,
		/obj/item/weldingtool/abductor,
		/obj/item/wirecutters/abductor,
		/obj/item/wrench/abductor,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/slime/hard = TECHWEB_TIER_5_POINTS)
	hidden = TRUE

/datum/design/surgerytablev3
	name = "Surgery table NERV"
	id = "surgerytablev3"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SMALL_MATERIAL_AMOUNT*0.4, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.1)
	build_path = /obj/item/circuitboard/machine/surgerytablev3
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

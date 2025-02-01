/datum/outfit/job/brigmed
	name = "Brig medic"

	jobtype = /datum/job/brigmed
	uniform = /obj/item/clothing/under/rank/brigmed
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/brigmed
	shoes = /obj/item/clothing/shoes/sneakers/white
	ears = /obj/item/radio/headset/headset_sec/alt/department/med
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	l_hand = /obj/item/storage/medkit/surgery
	implants = list(/obj/item/implant/mindshield)

	backpack = /obj/item/storage/backpack/brigmed
	satchel = /obj/item/storage/backpack/satchel/brigmed
	duffelbag = /obj/item/storage/backpack/duffelbag/brigmed
	messenger = /obj/item/storage/backpack/messenger/brigmed

	box = /obj/item/storage/box/survival/security
	belt = /obj/item/modular_computer/pda/security/brigmed
	skillchips = list(/obj/item/skillchip/entrails_reader)

/datum/outfit/plasmaman/brigmed
	name = "Brig Med Plasmaman"
	head = /obj/item/clothing/head/helmet/space/plasmaman/medical
	uniform = /obj/item/clothing/under/plasmaman/medical

/datum/outfit/job/brigmed/mod
	name = "Brig Medic (MODsuit)"
	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/medical
	suit = null
	head = null
	uniform = /obj/item/clothing/under/rank/brigmed
	mask = /obj/item/clothing/mask/breath/medical
	internals_slot = ITEM_SLOT_SUITSTORE

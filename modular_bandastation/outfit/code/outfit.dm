// MARK: CentCom //

// Old Fashion CentCom Commander
/datum/outfit/centcom/spec_ops/old
	name = "Old Fashion CentCom Commander"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/specops_officer
	uniform = /obj/item/clothing/under/rank/centcom/commander
	suit = /obj/item/clothing/suit/space/officer/browntrench
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/survival/centcom,
		/obj/item/ammo_box/magazine/internal/cylinder = 3,
		/obj/item/storage/fancy/cigarettes/cigars
	)
	belt = /obj/item/gun/ballistic/revolver/mateba
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/soo
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/space/beret/soo
	mask = /obj/item/cigarette/cigar/havana
	shoes = /obj/item/clothing/shoes/jackboots/centcom
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/reagent_containers/hypospray/combat/nanites

/obj/item/clothing/glasses/hud/security/sunglasses/soo
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS

/obj/item/clothing/glasses/hud/security/sunglasses/centcom_officer
	vision_flags = SEE_MOBS

//CentCom Subordinate Officer
/datum/outfit/centcom/centcom_intern
	name = "CentCom Subordinate Officer"

	id_trim = /datum/id_trim/centcom/intern

/datum/outfit/centcom/centcom_intern/unarmed
	name = "CentCom Subordinate Officer (Unarmed)"

/datum/outfit/centcom/centcom_intern/leader
	name = "CentCom Subordinate Commander"

	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/rifle/boltaction
	belt = /obj/item/melee/baton/security/loaded
	head = /obj/item/clothing/head/beret/cent_intern
	l_hand = /obj/item/megaphone

/datum/outfit/centcom/centcom_intern/leader/unarmed
	name = "CentCom Subordinate Commander (Unarmed)"

/datum/id_trim/centcom/intern
	access = list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING, ACCESS_WEAPONS)
	assignment = "CentCom Subordinate Officer"
	big_pointer = FALSE

/datum/id_trim/centcom/intern/head
	assignment = "CentCom Subordinate Commander"

//CentCom Navy Officer
/datum/outfit/centcom/commander
	name = "CentCom Navy Officer"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/commander
	uniform = /obj/item/clothing/under/rank/centcom/official
	suit = /obj/item/clothing/suit/armor/centcom_formal
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/survival/centcom,
		/obj/item/gun/energy/pulse/pistol/m1911,
		/obj/item/stamp/centcom,
	)
	belt = /obj/item/storage/belt/centcom_sabre
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/centcom_officer
	gloves = /obj/item/clothing/gloves/combat/centcom
	head = /obj/item/clothing/head/helmet/space/beret
	mask = /obj/item/cigarette/cigar/cohiba
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/reagent_containers/hypospray/combat/nanites

/obj/item/clothing/shoes/laceup/centcom
	clothing_traits = list(TRAIT_NO_SLIP_ALL)

/obj/item/clothing/shoes/jackboots/centcom
	clothing_traits = list(TRAIT_NO_SLIP_ALL)

//CentCom Field Officer
/datum/outfit/centcom/commander/field
	name = "CentCom Field Officer"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/commander
	uniform = /obj/item/clothing/under/rank/centcom/official
	suit = /obj/item/clothing/suit/armor/centcom_formal/field
	back = /obj/item/storage/backpack/satchel/leather
	belt = /obj/item/storage/belt/centcom_sabre
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/centcom_officer
	gloves = /obj/item/clothing/gloves/combat/centcom
	head = /obj/item/clothing/head/helmet/space/beret
	mask = /obj/item/cigarette/cigar/cohiba
	shoes = /obj/item/clothing/shoes/jackboots/centcom
	r_pocket = /obj/item/lighter

//CentCom Diplomat
/datum/outfit/centcom/diplomat
	name = "Nanotrasen Diplomat"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/diplomat
	uniform = /obj/item/clothing/under/rank/centcom/diplomat
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/survival/centcom,
		/obj/item/stack/spacecash/c10000,
		/obj/item/pen/fourcolor,
		/obj/item/stamp/centcom,
		/obj/item/stamp/denied,
		/obj/item/stamp/granted,
		/obj/item/folder/blue,
		/obj/item/folder/red,
		/obj/item/storage/lockbox/medal
	)
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/combat/centcom/diplomat
	head = /obj/item/clothing/head/beret/cent_diplomat
	mask = /obj/item/cigarette/cigar/cohiba
	shoes = /obj/item/clothing/shoes/laceup/centcom
	r_pocket = /obj/item/lighter
	l_hand = /obj/item/storage/briefcase

/datum/outfit/centcom/diplomat/post_equip(mob/living/carbon/human/H, visuals_only = FALSE)
	if(visuals_only)
		return

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	..()

/datum/id_trim/centcom/diplomat
	assignment = "Nanotrasen Diplomat"

/obj/structure/closet/secure_closet/brigmed
	name = "Brig medical locker"
	icon_state = "brigmed"
	icon = 'modular_bandastation/objects/icons/obj/storage/closet.dmi'
	req_access = list(ACCESS_BRIGMED)

/obj/structure/closet/secure_closet/brigmed/PopulateContents()
	new /obj/item/storage/medkit/advanced(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/radio/headset/headset_sec/alt/department/med(src)
	new /obj/item/sensor_device(src)
	new /obj/item/pinpointer/crew(src)
	new /obj/item/blood_filter(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/bag/garment/brigmed(src)
	new /obj/item/storage/backpack/brigmed(src)
	new /obj/item/storage/backpack/satchel/brigmed(src)
	new /obj/item/storage/backpack/duffelbag/brigmed(src)
	new /obj/item/storage/backpack/messenger/brigmed(src)

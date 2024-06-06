/obj/item/storage/bag/material_pouch
	name = "material pouch"
	desc = "Сумка для хранения листов материалов."
	icon = 'modular_bandastation/objects/icons/material_pouch.dmi'
	icon_state = "materialpouch"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT

/obj/item/storage/bag/material_pouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 2
	atom_storage.max_slots = 2
	atom_storage.set_holdable(/obj/item/stack/sheet/iron, /obj/item/stack/sheet/glass,\
	/obj/item/stack/sheet/rglass, /obj/item/stack/sheet/plasmaglass,\
	/obj/item/stack/sheet/plasmarglass, /obj/item/stack/sheet/plasteel,\
	/obj/item/stack/sheet/bluespace_crystal,/obj/item/stack/sheet/bronze,\
	/obj/item/stack/sheet/titaniumglass,/obj/item/stack/sheet/plastitaniumglass,\
	/obj/item/stack/sheet/mineral,/obj/item/stack/sheet/plastic)

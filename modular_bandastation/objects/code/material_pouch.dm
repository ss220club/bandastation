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
	atom_storage.max_total_storage = INFINITY
	atom_storage.max_slots = 2
	atom_storage.numerical_stacking = TRUE
	atom_storage.can_hold = typecacheof(list(/obj/item/rcd_ammo, /obj/item/stack/sheet))

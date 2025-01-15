// MARK: On-station statues
/obj/structure/statue/themis
	name = "Фемида"
	desc = "Статуя древнегреческой богини правосудия."
	icon = 'modular_bandastation/objects/icons/obj/structures/statuelarge.dmi'
	icon_state = "themis"
	layer = ABOVE_MOB_LAYER
	pixel_y = 7
	anchored = TRUE
	max_integrity = 1000
	impressiveness = 50
	abstract_type = /obj/structure/statue/themis

// Station statues
/obj/structure/statue/station_map
	anchored = TRUE
	impressiveness = 80
	max_integrity = 500

/obj/structure/statue/station_map/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seethrough, get_seethrough_map())

/obj/structure/statue/station_map/proc/get_seethrough_map()
	return

/obj/structure/statue/station_map/wrench_act(mob/living/user, obj/item/tool)
	return FALSE

/obj/structure/statue/station_map/Destroy()
	for(var/obj/structure/statue/station_map/self in orange(3, src))
		if(!QDELETED(self))
			qdel(self)
	return ..()

/obj/structure/statue/station_map/atom_deconstruct(disassembled = TRUE)
	for(var/obj/structure/statue/station_map/self in orange(3, src))
		if(!QDELETED(self))
			qdel(self)
	return ..()

// Cyberiad statue
/obj/structure/statue/station_map/cyberiad
	name = "статуя Кибериады"
	desc = "Гигантская модель научной станции «Кибериада». Судя по отличиям в конструкции, станцию несколько раз перестраивали."
	icon = 'modular_bandastation/objects/icons/obj/structures/cyberiad.dmi'

/obj/structure/statue/station_map/cyberiad/nw
	icon_state = "nw"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/statue/station_map/cyberiad/north
	icon_state = "north"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/statue/station_map/cyberiad/ne
	icon_state = "ne"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER

// Adds transparency when the player gets behind an object, or is near it
/obj/structure/statue/station_map/cyberiad/nw/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/cyberiad/north/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/cyberiad/ne/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/cyberiad/w
	icon_state = "west"

/obj/structure/statue/station_map/cyberiad/c
	icon_state = "center"

/obj/structure/statue/station_map/cyberiad/e
	icon_state = "east"

/obj/structure/statue/station_map/cyberiad/w/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/cyberiad/c/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/cyberiad/e/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/cyberiad/sw
	icon_state = "sw"

/obj/structure/statue/station_map/cyberiad/s
	icon_state = "south"

/obj/structure/statue/station_map/cyberiad/se
	icon_state = "se"

// Delta statue
/obj/structure/statue/station_map/delta
	name = "статуя Кербероса"
	desc = "Гигантская модель научной станции «Керберос». Судя по отличиям в конструкции, станцию несколько раз перестраивали."
	icon = 'modular_bandastation/objects/icons/obj/structures/delta.dmi'

/obj/structure/statue/station_map/delta/nw
	icon_state = "nw"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/statue/station_map/delta/north
	icon_state = "north"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/statue/station_map/delta/ne
	icon_state = "ne"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER

// Adds transparency when the player gets behind an object, or is near it
/obj/structure/statue/station_map/delta/nw/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/delta/north/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/delta/ne/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/delta/w
	icon_state = "west"

/obj/structure/statue/station_map/delta/c
	icon_state = "center"

/obj/structure/statue/station_map/delta/e
	icon_state = "east"

/obj/structure/statue/station_map/delta/w/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/delta/c/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/delta/e/get_seethrough_map()
	return SEE_THROUGH_MAP_STATION_STATUE

/obj/structure/statue/station_map/delta/sw
	icon_state = "sw"

/obj/structure/statue/station_map/delta/s
	icon_state = "south"

/obj/structure/statue/station_map/delta/se
	icon_state = "se"

// MARK: Off-station statues
/obj/structure/statue/mooniverse
	name = "Неизвестный агент"
	desc = "Информация на табличке под статуей исцарапана и нечитабельна... Поверх написано невнятное словосочетание из слов \"Moon\" и \"Universe\"."
	icon = 'modular_bandastation/objects/icons/obj/structures/statuelarge.dmi'
	icon_state = "mooniverse"
	pixel_y = 7
	anchored = TRUE
	max_integrity = 1000
	impressiveness = 100
	abstract_type = /obj/structure/statue/mooniverse

/obj/structure/statue/ell_good
	name = "Mr.Буум"
	desc = "Загадочный клоун с жёлтым оттенком кожи и выразительными зелёными глазами. Лучший двойной агент синдиката, получивший власть над множеством фасилити. \
			Его имя часто произносят неправильно из-за чего его заслуги по документам принадлежат сразу нескольким Буумам. \
			Так же знаменит тем, что убедил руководство НТ тратить время, силы и средства, на золотой унитаз."
	icon = 'modular_bandastation/objects/icons/obj/structures/statuelarge.dmi'
	icon_state = "ell_good"
	pixel_y = 7
	anchored = TRUE
	max_integrity = 1000
	impressiveness = 100
	abstract_type = /obj/structure/statue/ell_good

// Dummies
/**
 *	It is used as decorative element, or for shitspawn/events
 *	DO NOT use these icons for PvE NPCs! TGs NPCs made different.
 */
/obj/structure/statue/dummy
	name = "Unknown"
	desc = null
	icon = 'modular_bandastation/mobs/icons/dummies.dmi'
	icon_state = null
	pixel_y = 7
	anchored = TRUE
	max_integrity = 1000
	impressiveness = 0
	abstract_type = /obj/structure/statue/dummy

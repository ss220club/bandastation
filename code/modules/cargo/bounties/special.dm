/datum/bounty/item/alien_organs
	name = "Инопланетные органы"
	description = "Нанотрейзен заинтересовано в изучении биологии ксеноморфов. Отправьте набор органов для хорошей компенсации."
	reward = CARGO_CRATE_VALUE * 50
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/brain/alien = TRUE,
		/obj/item/organ/internal/alien = TRUE,
		/obj/item/organ/internal/body_egg/alien_embryo = TRUE,
		/obj/item/organ/internal/liver/alien = TRUE,
		/obj/item/organ/internal/tongue/alien = TRUE,
		/obj/item/organ/internal/eyes/alien = TRUE,
	)

/datum/bounty/item/syndicate_documents
	name = "Документы синдиката"
	description = "Информация о синдикате высоко ценится на ЦентКоме. Если вы найдёте документы синдиката, отправьте их. Вы может спасёте жизни."
	reward = CARGO_CRATE_VALUE * 30
	wanted_types = list(
		/obj/item/documents/syndicate = TRUE,
		/obj/item/documents/photocopy = TRUE,
	)

/datum/bounty/item/syndicate_documents/applies_to(obj/O)
	if(!..())
		return FALSE
	if(istype(O, /obj/item/documents/photocopy))
		var/obj/item/documents/photocopy/Copy = O
		return (Copy.copy_type && ispath(Copy.copy_type, /obj/item/documents/syndicate))
	return TRUE

/datum/bounty/item/adamantine
	name = "Адамантит"
	description = "Отдел аномальных материалов Нанотрейзен отчаянно нуждается в адамантие. Отправьте большую партию и мы сделаем так, что вы не пожалеете."
	reward = CARGO_CRATE_VALUE * 70
	required_count = 10
	wanted_types = list(/obj/item/stack/sheet/mineral/adamantine = TRUE)

/datum/bounty/item/trash
	name = "Мусор"
	description = "Недавно, у группы уборщиков кончился мусор для уборки и ЦентКом решил уволить их для уменьшения расходов. Отправьте поставку мусора, чтобы оставить их работать, и они вам дадут вам маленькую компенсацию."
	reward = CARGO_CRATE_VALUE * 2
	required_count = 10
	wanted_types = list(/obj/item/trash = TRUE)

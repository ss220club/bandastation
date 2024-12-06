/obj/item/clothing/neck/cloak/centcom
	name = "армированный офицерский плащ"
	desc = "Свободная накидка из дюраткани, укрепленной пластитановой нитью. Сочетает в себе два основных качества \
	офицерского убранства - пафос и защиту. Старые плащи этой линейки зачастую дарятся капитанам объектов Компании."
	icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/obj/clothing/cloaks/cloaks.dmi'
	worn_icon = 'modular_bandastation/aesthetics/clothing/centcom/icons/mob/clothing/cloaks/cloaks.dmi'
	icon_state = "centcom"
	armor_type = /datum/armor/armor_centcom_cloak
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | FREEZE_PROOF | UNACIDABLE | ACID_PROOF

/datum/armor/armor_centcom_cloak
	melee = 80
	bullet = 80
	laser = 80
	energy = 60
	wound = 30

/obj/item/clothing/neck/cloak/centcom/officer
	name = "деловой офицерский плащ"
	desc = "Свободная накидка из дюраткани, укрепленной пластитановой нитью. Сочетает в себе два основных качества \
	офицерского убранства - пафос и защиту. Эта шитая золотом линейка плащей подходит для официальных встреч."
	icon_state = "centcom_officer"

/obj/item/clothing/neck/cloak/centcom/official
	name = "наградной офицерский плащ"
	desc = "Свободная накидка из дюраткани, укрепленной пластитановой нитью. Лёгкое и изящное на первый взгляд, \
	это одеяние покрывает своего владельца надежной защитой. Подобные плащи не входят в какую-либо линейку и шьются исключительно на заказ под определенного офицера."
	icon_state = "centcom_official"

/obj/item/clothing/neck/cloak/centcom/admiral
	name = "роскошный офицерский плащ"
	desc = "Свободная накидка из дюраткани, укрепленной пластитановой нитью. Сочетает в себе два основных качества \
	офицерского убранства - пафос и защиту. Линейка этих дорогих плащей встречается у крайне состоятельных членов старшего офицерского состава."
	icon_state = "centcom_admiral"

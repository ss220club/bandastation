// Code for handling declents for bodyparts

/obj/item/bodypart
	var/list/ru_plaintext_zone = list()

/obj/item/bodypart/head/Initialize(mapload)
	. = ..()
	ru_plaintext_zone = ru_names_list("head", "голова", "головы", "голове", "голову", "головой", "голове", gender = FEMALE)

/obj/item/bodypart/chest/Initialize(mapload)
	. = ..()
	ru_plaintext_zone = ru_names_list("chest", "грудь", "груди", "груди", "грудь", "грудью", "груди", gender = FEMALE)

/obj/item/bodypart/arm/left/Initialize(mapload)
	. = ..()
	ru_plaintext_zone = ru_names_list("left arm", "левая рука", "левой руки", "левой руке", "левую руку", "левой рукой", "левой руке", gender = FEMALE)

/obj/item/bodypart/arm/right/Initialize(mapload)
	. = ..()
	ru_plaintext_zone = ru_names_list("right arm", "правая рука", "правой руки", "правой руке", "правую руку", "правой рукой", "правой руке", gender = FEMALE)

/obj/item/bodypart/leg/left/Initialize(mapload)
	. = ..()
	ru_plaintext_zone = ru_names_list("left leg", "левая нога", "левой ноги", "левой ноге", "левую ногу", "левой ногой", "левой ноге", gender = FEMALE)

/obj/item/bodypart/leg/right/Initialize(mapload)
	. = ..()
	ru_plaintext_zone = ru_names_list("right leg", "правая нога", "правой ноги", "правой ноге", "правую ногу", "правой ногой", "правой ноге", gender = FEMALE)

/proc/ru_parse_zone(zone, declent = NOMINATIVE)
	var/static/list/chest = ru_names_list("chest", "грудь", "груди", "груди", "грудь", "грудью", "груди", gender = FEMALE)
	var/static/list/head = ru_names_list("head", "голова", "головы", "голове", "голову", "головой", "голове", gender = FEMALE)
	var/static/list/right_hand = ru_names_list("right hand", "правое запястье", "правого запястья", "правому запястью", "правое запястье", "правым запястьем", "правом запястье", gender = FEMALE)
	var/static/list/left_hand = ru_names_list("left hand", "левое запястье", "левое запястье", "левой руке", "левую руку", "левой рукой", "левой руке", gender = FEMALE)
	var/static/list/left_arm = ru_names_list("left arm", "левая рука", "левой руки", "левой руке", "левую руку", "левой рукой", "левой руке", gender = FEMALE)
	var/static/list/right_arm = ru_names_list("right arm", "правая рука", "правой руки", "правой руке", "правую руку", "правой рукой", "правой руке", gender = FEMALE)
	var/static/list/left_leg = ru_names_list("left leg", "левая нога", "левой ноги", "левой ноге", "левую ногу", "левой ногой", "левой ноге", gender = FEMALE)
	var/static/list/right_leg = ru_names_list("right leg", "правая нога", "правой ноги", "правой ноге", "правую ногу", "правой ногой", "правой ноге", gender = FEMALE)
	var/static/list/left_foot = ru_names_list("left leg", "левая стопа", "левой стопы", "левой стопе", "левую стопу", "левой стопой", "левой стопе", gender = FEMALE)
	var/static/list/right_foot = ru_names_list("left leg", "правая стопа", "правой стопы", "правой стопе", "правую стопу", "правой стопой", "правой стопе", gender = FEMALE)
	var/static/list/groin = ru_names_list("groin", "паховая область", "паховой области", "паховой области", "паховую область", "паховой областью", "паховой области", gender = FEMALE)
	switch(zone)
		if(BODY_ZONE_CHEST)
			return chest[declent]
		if(BODY_ZONE_HEAD)
			return head[declent]
		if(BODY_ZONE_PRECISE_R_HAND)
			return right_hand[declent]
		if(BODY_ZONE_PRECISE_L_HAND)
			return left_hand[declent]
		if(BODY_ZONE_L_ARM)
			return left_arm[declent]
		if(BODY_ZONE_R_ARM)
			return right_arm[declent]
		if(BODY_ZONE_L_LEG)
			return left_leg[declent]
		if(BODY_ZONE_R_LEG)
			return right_leg[declent]
		if(BODY_ZONE_PRECISE_L_FOOT)
			return left_foot[declent]
		if(BODY_ZONE_PRECISE_R_FOOT)
			return right_foot[declent]
		if(BODY_ZONE_PRECISE_GROIN)
			return groin[declent]
		else
			return zone

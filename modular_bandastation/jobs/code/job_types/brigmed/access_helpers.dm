/obj/effect/mapping_helpers/airlock/access/all/security/brigmed/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIGMED
	return access_list

/obj/effect/mapping_helpers/airlock/access/any/security/brigmed/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIGMED
	return access_list

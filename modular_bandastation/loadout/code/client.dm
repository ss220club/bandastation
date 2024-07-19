/client
	var/donator_level = 0

/datum/preferences/load_savefile()
	. = ..()
	var/datum/db_query/query_get_donator_level = SSdbcore.NewQuery(
		"SELECT tier FROM [format_table_name("player220")] WHERE ckey = :ckey",
		list("ckey" = parent.ckey)
	)
	if(query_get_donator_level.warn_execute() && length(query_get_donator_level.rows))
		query_get_donator_level.NextRow()
		parent.donator_level = query_get_donator_level.item[1]
	qdel(query_get_donator_level)

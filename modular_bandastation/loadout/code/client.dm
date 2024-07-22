#define TIER1 220
#define TIER2 440
#define TIER3 1000
#define TIER4 2220
#define TIER5 10000

/client
	var/donator_level = 0

/client/add_admin_verbs()
	. = ..()
	donator_level = max(donator_level, holder?.get_donator_level_admin())

/datum/preferences/load_savefile()
	. = ..()
	parent.donator_level = max(parent.donator_level, get_donator_level_db())

/datum/admins/proc/get_donator_level_admin()
	var/best_level = 0
	for(var/datum/admin_rank/rank as anything in ranks)
		if(rank.rights & R_ADMIN)
			best_level = max(best_level, 3)
	return best_level

/datum/preferences/proc/get_donator_level_db()
	var/datum/db_query/query_get_donator_level = SSdbcore.NewQuery({"
		SELECT CAST(SUM(amount) as UNSIGNED INTEGER) FROM budget
		WHERE ckey=:ckey
			AND is_valid=true
			AND date_start <= NOW()
			AND (NOW() < date_end OR date_end IS NULL)
		GROUP BY ckey
	"}, list("ckey" = parent.ckey))

	var/amount = 0
	if(query_get_donator_level.warn_execute() && length(query_get_donator_level.rows))
		query_get_donator_level.NextRow()
		amount = query_get_donator_level.item[1]
	qdel(query_get_donator_level)

	switch(amount)
		if(TIER1 to (TIER2 - 1))
			return 1
		if(TIER2 to (TIER3 - 1))
			return 2
		if(TIER3 to (TIER4 - 1))
			return 3
		if(TIER4 to (TIER5 - 1))
			return 4
		if(TIER5 to INFINITY)
			return 5
	return 0

#undef TIER1
#undef TIER2
#undef TIER3
#undef TIER4
#undef TIER5

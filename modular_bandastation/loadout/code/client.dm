#define TIER1 220
#define TIER2 440
#define TIER3 1000
#define TIER4 2220
#define TIER5 10000

/client
	var/donator_level = 0

/datum/preferences/load_savefile()
	. = ..()
	var/donator_level = get_donator_level_db()
	parent.donator_level = donator_level

/datum/preferences/proc/get_donator_level_db()
	var/datum/db_query/query_get_donator_level = SSdbcore.NewQuery({"
		SELECT CAST(SUM(amount) as UNSIGNED INTEGER) FROM budget
		WHERE ckey=:ckey
			AND is_valid=true
			AND date_start <= NOW()
			AND (NOW() < date_end OR date_end IS NULL)
		GROUP BY ckey
	"}, list("ckey" = parent.ckey))

	var/best_value = 0
	if(query_get_donator_level.warn_execute() && length(query_get_donator_level.rows))
		while(query_get_donator_level.NextRow())
			var/amount = query_get_donator_level.item[1]
			best_value = max(best_value, amount)
	qdel(query_get_donator_level)

	switch(best_value)
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

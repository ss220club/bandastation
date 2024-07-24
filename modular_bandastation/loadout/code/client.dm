#define DONATION_TIER_1 220
#define DONATION_TIER_2 440
#define DONATION_TIER_3 1000
#define DONATION_TIER_4 2220
#define DONATION_TIER_5 10000

/client
	/// Call `proc/get_donator_level()` instead to get a value when possible.
	var/donator_level = 0
	COOLDOWN_DECLARE(db_check_cooldown)

// For unit-tests
/datum/client_interface
	var/donator_level = 0

/client/proc/get_donator_level()
	donator_level = max(donator_level, get_donator_level_from_db(), get_donator_level_from_admin())
	return donator_level

/client/proc/get_donator_level_from_admin()
	if(!holder)
		return 0
	var/best_level = 0
	for(var/datum/admin_rank/rank as anything in holder.ranks)
		if(rank.rights & R_ADMIN)
			best_level = max(best_level, 3)
	return best_level

/client/proc/get_donator_level_from_db()
	if(!COOLDOWN_FINISHED(src, db_check_cooldown))
		return 0
	COOLDOWN_START(src, db_check_cooldown, 15 SECONDS)
	var/datum/db_query/query_get_donator_level = SSdbcore.NewQuery({"
		SELECT CAST(SUM(amount) as UNSIGNED INTEGER) FROM budget
		WHERE ckey=:ckey
			AND is_valid=true
			AND date_start <= NOW()
			AND (NOW() < date_end OR date_end IS NULL)
		GROUP BY ckey
	"}, list("ckey" = ckey))

	var/amount = 0
	if(query_get_donator_level.warn_execute() && length(query_get_donator_level.rows))
		query_get_donator_level.NextRow()
		amount = query_get_donator_level.item[1]
	qdel(query_get_donator_level)

	switch(amount)
		if(DONATION_TIER_1 to (DONATION_TIER_2 - 1))
			return 1
		if(DONATION_TIER_2 to (DONATION_TIER_3 - 1))
			return 2
		if(DONATION_TIER_3 to (DONATION_TIER_4 - 1))
			return 3
		if(DONATION_TIER_4 to (DONATION_TIER_5 - 1))
			return 4
		if(DONATION_TIER_5 to INFINITY)
			return 5
	return 0

#undef DONATION_TIER_1
#undef DONATION_TIER_2
#undef DONATION_TIER_3
#undef DONATION_TIER_4
#undef DONATION_TIER_5

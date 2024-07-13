/datum/config_entry/flag/whitelist220
	default = FALSE
	protection = CONFIG_ENTRY_LOCKED

/world/IsBanned(key, address, computer_id, type, real_bans_only)
	. = ..()
	if(.)
		return .

	/// If interviews are enabled, the player will be processed in `/mob/dead/new_player/Login()`
	/// as `client` is not created on this stage
	if(CONFIG_GET(flag/panic_bunker_interview))
		return null

	var/ckey = ckey(key)
	var/deny_message = list(
		"reason"="whitelist",
		"desc"="\nПричина: Вас ([key]) нет в вайтлисте этого сервера. Приобрести доступ возможно у одного из стримеров Банды за баллы канала или записаться самостоятельно с помощью команды в дискорде, доступной сабам бусти, начиная со второго тира.")

	return is_ckey_whitelisted(ckey) ? null : deny_message

/mob/dead/new_player/proc/check_whitelist_or_make_interviewee()
	if(client.interviewee)
		return

	if(!CONFIG_GET(flag/panic_bunker_interview))
		return

	if(is_ckey_whitelisted(ckey))
		return

	client.interviewee = TRUE

/proc/is_ckey_whitelisted(ckey_to_check)
	if(!CONFIG_GET(flag/whitelist220))
		return TRUE

	if(!ckey || !SSdbcore.IsConnected())
		return FALSE

	var/datum/db_query/whitelist_query = SSdbcore.NewQuery(
		{"
			SELECT ckey FROM ckey_whitelist WHERE ckey=:ckey AND
			is_valid=1 AND port=:port AND date_start<=NOW() AND
			(date_end IS NULL OR NOW()<date_end)
		"},
		list("ckey" = ckey, "port" = "[world.port]")
	)

	if(!whitelist_query.warn_execute())
		qdel(whitelist_query)
		return FALSE

	while(whitelist_query.NextRow())
		if(whitelist_query.item[1])
			qdel(whitelist_query)
			return TRUE

	qdel(whitelist_query)
	return FALSE

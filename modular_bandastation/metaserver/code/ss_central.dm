/datum/config_entry/string/ss_central_url
	default = ""
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/ss_central_token
	default = ""
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/whitelist_type
	default = "default"

SUBSYSTEM_DEF(central)
	var/list/discord_links = list()

/datum/controller/subsystem/central/Initialize()
	if(!(CONFIG_GET(string/ss_central_url) && CONFIG_GET(string/ss_central_token)))
		return SS_INIT_FAILURE
	load_whitelist()

/datum/controller/subsystem/central/proc/load_whitelist()
	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/whitelist/simple/active_whitelists/ckey?wl_type=[CONFIG_GET(string/whitelist_type)]"

	SShttp.create_async_request(RUSTG_HTTP_METHOD_GET, endpoint, "", list(), CALLBACK(src, PROC_REF(load_whitelist_callback)))

/datum/controller/subsystem/central/proc/load_whitelist_callback(datum/http_response/response)
	if(response.errored || response.status_code != 200)
		stack_trace("Failed to load whitelist: HTTP status code " + response.status_code)
		return

	var/list/ckeys = json_decode(response.body)
	GLOB.whitelist = ckeys

/datum/controller/subsystem/central/proc/get_player_discord_async(client/player)
	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/player/ckey/[player.ckey]"

	SShttp.create_async_request(RUSTG_HTTP_METHOD_GET, endpoint, "", list(), CALLBACK(src, PROC_REF(get_player_discord_callback), player))

/datum/controller/subsystem/central/proc/get_player_discord_callback(client/player, datum/http_response/response)
	if(response.errored || response.status_code != 200)
		stack_trace("Failed to get player discord: HTTP status code " + response.status_code)
		return

	var/list/data = json_decode(response.body)
	var/discord_id = data["discord_id"]
	var/ckey = data["ckey"]
	discord_links[ckey] = discord_id

	player.prefs.discord_id = discord_id

/datum/controller/subsystem/central/proc/is_player_discord_linked(client/player)
	if(!player)
		return FALSE

	if(player.prefs.discord_id)
		return TRUE

	// If player somehow losed its id. Not sure if needed
	if(SScentral.discord_links[player.ckey])
		player.prefs.discord_id = SScentral.discord_links[player.ckey]
		return TRUE

	// Update the info just in case
	SScentral.get_player_discord_async(src)

	return FALSE

/// WARNING: only semi async - UNTIL based
/datum/controller/subsystem/central/proc/is_player_whitelisted(ckey)
	. = (ckey in GLOB.whitelist)

	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/whitelist/simple/is_whitelisted/ckey/[ckey]?wl_type=[CONFIG_GET(string/whitelist_type)]"
	var/datum/http_response/response = SShttp.make_blocking_request(RUSTG_HTTP_METHOD_GET, endpoint, "", list())
	if(response.errored || response.status_code != 200)
		return FALSE

	return json_decode(response.body)

/datum/controller/subsystem/central/proc/add_to_whitelist(ckey, added_by, duration_days = 0)
	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/whitelist/ckey/[ckey]"

	var/list/headers = list()
	headers["Authorization"] = "Bearer [CONFIG_GET(string/ss_central_token)]"
	var/list/body = list()
	body["player_ckey"] = ckey
	body["admin_ckey"] = added_by
	body["wl_type"] = CONFIG_GET(string/whitelist_type)
	body["duration_days"] = duration_days

	SShttp.create_async_request(RUSTG_HTTP_METHOD_POST, endpoint, json_encode(body), headers, CALLBACK(src, PROC_REF(add_to_whitelist_callback)))

/datum/controller/subsystem/central/proc/add_to_whitelist_callback(datum/http_response/response)
	if(response.errored || response.status_code != 200)
		stack_trace("Failed to add to whitelist: HTTP status code " + response.status_code)
		return

	var/list/data = json_decode(response.body)
	var/ckey = data["ckey"]

	GLOB.whitelist |= ckey

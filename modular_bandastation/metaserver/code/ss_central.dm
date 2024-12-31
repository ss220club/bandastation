GLOBAL_DATUM_INIT(ss_central, /datum/ss_central, new)

/datum/config_entry/string/ss_central_url
	default = ""
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/ss_central_token
	default = ""
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/whitelist_type
	default = "default"

/datum/ss_central
	var/list/discord_links = list()


/datum/ss_central/proc/load_whitelist()
	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/whitelist/simple/active_whitelists/ckey?wl_type=[CONFIG_GET(string/whitelist_type)]"

	SShttp.create_async_request(RUSTG_HTTP_METHOD_GET, endpoint, "", list(), CALLBACK(src, PROC_REF(load_whitelist_callback)))

/datum/ss_central/proc/load_whitelist_callback(datum/http_response/response)
	if(response.status_code != 200)
		stack_trace("Failed to load whitelist: HTTP status code " + response.status_code)
		return

	var/list/ckeys = json_decode(response.body)
	GLOB.whitelist = ckeys

/datum/ss_central/proc/get_player_discord(ckey)
	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/player/ckey/[ckey]"

	SShttp.create_async_request(RUSTG_HTTP_METHOD_GET, endpoint, "", list(), CALLBACK(src, PROC_REF(get_player_discord_callback)))

/datum/ss_central/proc/get_player_discord_callback(datum/http_response/response)
	if(response.status_code != 200)
		stack_trace("Failed to get player discord: HTTP status code " + response.status_code)
		return

	var/list/data = json_decode(response.body)
	var/discord_id = data["discord_id"]
	var/ckey = data["ckey"]
	discord_links[ckey] = discord_id

/client/verify_in_discord()
	// TODO: check if already linked

	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/player/token/[ckey]"
	var/list/headers = list(
		"Authorization" = "Bearer [CONFIG_GET(string/ss_central_token)]"
	)
	to_chat(src, span_notice("Пытаемся получить токен для входа в Discord..."))
	SShttp.create_async_request(RUSTG_HTTP_METHOD_POST, endpoint, "", headers, CALLBACK(GLOB.ss_central, TYPE_PROC_REF(/datum/ss_central, verify_in_discord_callback), src))

/datum/ss_central/proc/verify_in_discord_callback(client/user, datum/http_response/response)
	if(response.status_code != 201)
		stack_trace("Failed to get discord verification token: HTTP status code " + response.status_code)
		return

	var/list/data = json_decode(response.body)
	var/login_endpoint = "[CONFIG_GET(string/ss_central_url)]/player/login?token=[data]"

	to_chat(user, span_big("Авторизуйтесь в открывшемся окне. Если окно не открывается, можете открыть сами ссылку `[login_endpoint]`"))
	user << link(login_endpoint)

/datum/controller/subsystem/discord/find_discord_link_by_ckey(ckey, timebound, only_valid)
	return GLOB.ss_central.discord_links[ckey]

/mob/dead/new_player/proc/check_whitelist_or_make_interviewee()
	return
	// TODO: Implement all the old functionality

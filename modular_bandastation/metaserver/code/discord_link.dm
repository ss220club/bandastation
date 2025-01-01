/datum/preferences
	var/discord_id

/client/New()
	. = ..()
	GLOB.ss_central.get_player_discord_async(src)

/client/verify_in_discord()
	if(!GLOB.ss_central.active)
		to_chat(src, span_warning("Привязка Discord сейчас недоступна."))

	if(GLOB.ss_central.discord_links[src.ckey])
		to_chat(src, span_warning("Вы уже привязали свою учетную запись Discord."))

	to_chat(src, span_notice("Пытаемся получить токен для входа в Discord..."))
	GLOB.ss_central.verify_in_discord(src)

/datum/ss_central/proc/verify_in_discord(client/player)
	var/endpoint = "[CONFIG_GET(string/ss_central_url)]/player/token/[player.ckey]"
	var/list/headers = list(
		"Authorization" = "Bearer [CONFIG_GET(string/ss_central_token)]"
	)
	SShttp.create_async_request(RUSTG_HTTP_METHOD_POST, endpoint, "", headers, CALLBACK(GLOB.ss_central, PROC_REF(verify_in_discord_callback), player))

/datum/ss_central/proc/verify_in_discord_callback(client/player, datum/http_response/response)
	if(response.errored || response.status_code != 201)
		stack_trace("Failed to get discord verification token: HTTP status code " + response.status_code)
		return

	var/list/data = json_decode(response.body)
	var/login_endpoint = "[CONFIG_GET(string/ss_central_url)]/player/login?token=[data]"

	to_chat(player, span_big("Авторизуйтесь в открывшемся окне. Если окно не открывается, можете открыть сами ссылку <a href='[login_endpoint]'>[login_endpoint]</a> в браузере."))
	player << link(login_endpoint)

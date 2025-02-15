/// Doesnt need the panic bunker to work
/mob/dead/new_player/proc/check_whitelist_or_make_interviewee()
	if(!CONFIG_GET(flag/panic_bunker_interview))
		return
	if(SScentral.is_player_whitelisted(ckey))
		client.interviewee = FALSE
		return
	client.interviewee = TRUE

/datum/config_entry/string/interview_webhook_url

/datum/interview/approve(client/approved_by)
	if(!SScentral.is_player_discord_linked(owner))
		to_chat(approved_by, span_warning("У игрока не привязана своя учетная запись Discord!"))
		to_chat(owner, span_warning("Ваше интервью не удалось принять по причине: У вас не привязана учетная запись Discord!"))
		log_admin("[key_name(approved_by)] попытался безуспешно принять интервью [key_name(owner)]. Причина: Дискорд игрока не привязан.")
		return
	. = ..()
	add_owner_to_whitelist(approved_by)
	send_interview_webhook(src, "[approved_by.ckey] принял:")

/datum/interview_manager/enqueue(datum/interview/to_queue)
	. = ..()
	send_interview_webhook(to_queue, "Новое интервью в очереди:")

/datum/interview/deny(client/denied_by)
	. = ..()
	send_interview_webhook(src, "[denied_by.ckey] отказал:")

/datum/interview/proc/serialize_embed()
	. = list(
		"fields" = list(),
		"author" = list(
			"name" = owner_ckey
			)
	)
	for(var/question_id in 1 to length(questions))
		var/list/question_data = list(
			"name" = "[questions[question_id]]",
			"value" = "[isnull(responses[question_id]) ? "N/A" : responses[question_id]]"
		)
		.["fields"] += list(question_data)
	return .

/proc/send_interview_webhook(datum/interview/interview, additional_msg)
	var/webhook = CONFIG_GET(string/interview_webhook_url)
	if(!webhook || !interview)
		return
	var/list/webhook_info = list()
	webhook_info["content"] = additional_msg
	webhook_info["embeds"] = list(interview.serialize_embed())
	var/list/headers = list()
	headers["Content-Type"] = "application/json"
	SShttp.create_async_request(RUSTG_HTTP_METHOD_POST, webhook, json_encode(webhook_info), headers)

/datum/interview/proc/add_owner_to_whitelist(client/added_by)
	SScentral.add_to_whitelist(owner_ckey, added_by.ckey, 365)

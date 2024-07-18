/datum/jukebox
	/// Music start time.
	var/startTime = 0
	/// Music end time.
	var/endTime = 0
	/// Whether the uploaded track will be saved on the server.
	var/save_track = FALSE

/datum/jukebox/start_music()
	. = ..()
	startTime = world.time
	for(var/song_name in songs)
		var/datum/track/one_song = songs[song_name]
		endTime = startTime + one_song.song_length

/datum/jukebox/unlisten_all()
	. = ..()
	startTime = 0
	endTime = 0

/obj/machinery/jukebox/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Jukebox220", name)
		ui.open()

/obj/machinery/jukebox/ui_data(mob/user)
	var/list/data = ..()
	music_player.get_ui_data(data)
	data["admin"] = check_rights_for(user.client, R_ADMIN)
	data["saveTrack"] = music_player.save_track
	data["startTime"] = music_player.startTime
	data["endTime"] = music_player.endTime
	data["worldTime"] = world.time
	return data

/obj/machinery/jukebox/ui_act(action, list/params)
	. = ..()
	var/mob/user = usr
	if(action == "add_song")
		if(!check_rights_for(user.client, R_ADMIN))
			message_admins("[key_name(user)] попытался добавить трек, не имея прав администратора!")
			log_admin("[key_name(user)] попытался добавить трек, не имея прав администратора!")
			return
		var/track_name = params["track_name"]
		var/track_length = params["track_length"]
		var/track_beat = params["track_beat"]
		if(!track_name || !track_length || !track_beat)
			to_chat(user, span_warning("Ошибка: Имеются не заполненные поля."))
			return

		var/track_file = input(user, "Загрузите файл весом не более 5мб, поддерживается только формат .ogg", "Загрузка файла") as null|file
		if(isnull(track_file))
			to_chat(user, span_warning("Ошибка: Необходимо выбрать файл."))
			return
		if(copytext("[track_file]", -4) != ".ogg")
			to_chat(user, span_warning("Формат файла должен быть '.ogg': [track_file]"))
			return
		if(music_player.save_track)
			if(tgui_alert(user, "ВНИМАНИЕ! Включено сохранение трека на сервере. Нажимая «Да» вы подтверждаете, что загружаемый трек не нарушает никаких авторских прав. Вы уверены, что хотите продолжить?", "Сохранение трека", list("Да", "Нет")) != "Да")
				music_player.save_track = !music_player.save_track
				to_chat(user, span_warning("Сохранение трека было отключено."))
				return
			var/track_to_config = "[track_name]" + "+" + "[track_length]" + "+" + "[track_beat]"
			if(!fcopy(track_file, "[global.config.directory]/jukebox_music/sounds/[track_to_config].ogg"))
				to_chat(user, span_warning("По какой-то причине, трек не был сохранён, попробуйте ещё раз. <br> Входной файл: [track_file] <br> Выходной файл: [track_to_config].ogg"))
				return
			to_chat(user, span_notice("Ваш трек успешно загружен на сервер под следующим названием: [track_to_config].ogg"))
			message_admins("[key_name(user)] загрузил трек [track_to_config].ogg с изначальным названием [track_file] на сервер")
			log_admin("[key_name(user)] загрузил трек [track_to_config].ogg с изначальным названием [track_file] на сервер")

		var/datum/track/new_track = new()
		new_track.song_name = track_name
		new_track.song_length = track_length
		new_track.song_beat = track_beat
		new_track.song_path = file(track_file)

		music_player.songs[track_name] = new_track
		say("Загружен новый трек: «[track_name]».")
		return TRUE

	if(action == "save_song")
		if(!check_rights_for(user.client, R_ADMIN))
			message_admins("[key_name(user)] попытался включить сохранение трека, не имея прав администратора!")
			log_admin("[key_name(user)] попытался включить сохранение трека, не имея прав администратора!")
			return
		if(music_player.save_track)
			music_player.save_track = !music_player.save_track
			return
		if(tgui_alert(user, "Вы уверены, что хотите сохранить трек на сервере?", "Сохранение трека", list("Да", "Нет")) != "Да")
			return
		if(tgui_alert(user, "Внимание! Сохранённый трек сможет удалить ТОЛЬКО хост! Подойдите максимально ответственно к заполнению полей!", "Сохранение трека", list("Ок", "Я передумал")) != "Ок")
			return
		music_player.save_track = !music_player.save_track

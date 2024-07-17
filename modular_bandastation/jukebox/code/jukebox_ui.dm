/datum/jukebox
	/// Music start time.
	var/startTime = 0
	/// Music end time.
	var/endTime = 0

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
	data["startTime"] = music_player.startTime
	data["endTime"] = music_player.endTime
	data["worldTime"] = world.time
	return data

/obj/machinery/jukebox/ui_act(action, list/params)
	. = ..()
	if(action == "add_song")
		var/track_name = params["track_name"]
		var/track_length = params["track_length"]
		var/track_beat = params["track_beat"]
		if(!track_name || !track_length || !track_beat)
			to_chat(usr, span_warning("Ошибка: Имеются не заполненные поля."))
			return

		var/track_file = input(usr, "Загрузите файл, поддерживается только формат .ogg", "Загрузка файла") as null|file
		if(isnull(track_file))
			to_chat(usr, span_warning("Ошибка: Необходимо выбрать файл."))
			return
		if(copytext("[track_file]", -4) != ".ogg")
			to_chat(usr, span_warning("Формат файла должен быть '.ogg': [track_file]"))
			return

		var/datum/track/new_track = new()
		new_track.song_name = track_name
		new_track.song_length = track_length
		new_track.song_beat = track_beat
		new_track.song_path = file(track_file)

		music_player.songs[track_name] = new_track
		say("Загружен новый трек.")
		return TRUE

/datum/jukebox
	/// Music start time.
	var/startTime = 0
	/// Music end time.
	var/endTime = 0

/datum/jukebox/start_music()
	for(var/mob/nearby in hearers(sound_range, parent))
		register_listener(nearby)

	startTime = world.time
	for(var/song_name in songs)
		var/datum/track/one_song = songs[song_name]
		endTime = startTime + one_song.song_length

/datum/jukebox/get_ui_data()
	var/list/data = list()
	var/list/songs_data = list()
	for(var/song_name in songs)
		var/datum/track/one_song = songs[song_name]
		UNTYPED_LIST_ADD(songs_data, list( \
			"name" = song_name, \
			"length" = DisplayTimeText(one_song.song_length), \
			"beat" = one_song.song_beat, \
		))

	data["active"] = !!active_song_sound
	data["songs"] = songs_data
	data["track_selected"] = selection?.song_name
	data["looping"] = sound_loops
	data["volume"] = volume
	data["startTime"] = startTime
	data["endTime"] = endTime
	data["worldTime"] = world.time
	return data

/obj/machinery/jukebox/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Jukebox220", name)
		ui.open()

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
		visible_message("Загружен новый трек.")
		return TRUE

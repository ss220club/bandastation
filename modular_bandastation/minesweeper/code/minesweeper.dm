#define MINESWEEPER_ROWS 16
#define MINESWEEPER_COLUMNS 16
#define MINESWEEPER_BOMBS 40

/datum/computer_file/program/minesweeper
	filename = "minesweeper"
	filedesc = "Minesweeper"
	// program_open_overlay = "minesweeper"
	extended_desc = "Погрузись в удивительный мир 'Сапера',\
где каждое неверное нажатие может привести к взрыву!\
 Сразись с друзьями и стань мастером разминирования в этой захватывающей игре!."
	downloader_category = PROGRAM_CATEGORY_GAMES
	size = 6
	tgui_id = "NtosMinesweeperPanel"
	program_icon = "bomb"

	/// Thing, to make first touch safety
	var/first_touch = TRUE
	// Win condition things
	var/setted_flags = 0
	var/flagged_bombs = 0
	var/opened_cells = 0
	/// Decision to make interface untouchable in the momemnt of regenerating
	var/ignore_touches = FALSE
	/// Here we have all the minesweeper info
	var/list/minesweeper_matrix = list()
	// generations vars
	var/generation_rows = MINESWEEPER_ROWS
	var/generation_columns = MINESWEEPER_COLUMNS
	var/generation_bombs = MINESWEEPER_BOMBS
	///Current 3BV(special system of score for minesweeper)
	var/current_3BV = 0
	/// The moment then game was started for point count
	var/start_time = 0
	/// The current round leaderboard list
	var/static/list/leaderboard = list()
	/// The global leaderboard list
	var/static/list/glob_leaderboard = null

	//Emagged bomb stats
	var/range_heavy = -1
	var/range_medium = 1
	var/range_light = 3
	var/range_flame = 2

/datum/computer_file/program/minesweeper/New()
	..()
	if(isnull(glob_leaderboard))
		init_leaderboard()

///Get stored in database player results and fill glob_leaderboard with them
/datum/computer_file/program/minesweeper/proc/init_leaderboard()
	glob_leaderboard = list()
	var/datum/db_query/minesweeper_query = SSdbcore.NewQuery("SELECT nickname, points, points_per_sec, time, width, height, bombs FROM [format_table_name("minesweeper")]")
	if(!minesweeper_query.Execute())
		qdel(minesweeper_query)
		return
	while(minesweeper_query.NextRow())
		glob_leaderboard += list(
			list(
				"name" = minesweeper_query.item[1],
				"time" = "[minesweeper_query.item[4]]",
				"points" = "[minesweeper_query.item[2]]",
				"pointsPerSec" = "[minesweeper_query.item[3]]",
				"fieldParams" = "[minesweeper_query.item[5]]X[minesweeper_query.item[6]]([minesweeper_query.item[7]])"
			)
		)
	qdel(minesweeper_query)

///Insert new player result into database
/datum/computer_file/program/minesweeper/proc/add_result_to_db(list/new_result, ckey, width, height, bombs)
	if(SSdbcore.Connect())
		var/datum/db_query/query_minesweeper = SSdbcore.NewQuery(
			"INSERT INTO [format_table_name("minesweeper")] (ckey, time, points, points_per_sec, nickname, width, height, bombs) VALUES (:ckey, :time, :points, :points_per_sec, :nickname, :width, :height, :bombs)",
			list(
				"ckey" = ckey,
				"time" = new_result["time"],
				"points" = new_result["points"],
				"points_per_sec" = new_result["pointsPerSec"],
				"nickname" = new_result["name"],
				"width" = width,
				"height" = height,
				"bombs" = bombs
			)
		)
		query_minesweeper.Execute()
		qdel(query_minesweeper)

/datum/computer_file/program/minesweeper/ui_interact(mob/user, datum/tgui/ui)
	if(!LAZYLEN(minesweeper_matrix))
		make_empty_matrix()

/datum/computer_file/program/minesweeper/ui_data(mob/user)
	var/list/data = list()
	data["matrix"] = minesweeper_matrix
	data["flags"] = setted_flags
	data["bombs"] = generation_bombs
	data["leaderboard"] = leaderboard
	data["glob_leaderboard"] = glob_leaderboard
	data["first_touch"] = first_touch
	data["field_params"] = list("width" = generation_columns, "height" = generation_rows, "bombs" = generation_bombs)
	return data

/datum/computer_file/program/minesweeper/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	// After loose/win cooldown
	if(ignore_touches)
		return

	switch(action)
		// Click on game field
		if("Square")
			var/x = text2num(params["X"]) + 1
			var/y = text2num(params["Y"]) + 1
			switch(params["mode"])
				if("bomb")
					if(first_touch)
						generate_matrix(x, y)
					open_cell(x, y)

					if(minesweeper_matrix[x][y]["bomb"])
						on_loose(ui.user)
						return TRUE

				if("flag")
					if(first_touch || minesweeper_matrix[x][y]["open"])
						return

					if(minesweeper_matrix[x][y]["flag"])
						minesweeper_matrix[x][y]["flag"] = FALSE
						setted_flags -= 1
						if(minesweeper_matrix[x][y]["bomb"])
							flagged_bombs -= 1
					else
						minesweeper_matrix[x][y]["flag"] = TRUE
						setted_flags += 1
						if(minesweeper_matrix[x][y]["bomb"])
							flagged_bombs += 1

			check_win(ui.user)
		// Change field params
		if("ChangeSize")
			if(!first_touch)
				return
			var/ans = tgui_alert(ui.user, "Вы хотите изменить параметры поля?", "Настройки Сапёра", list("Да", "Нет"))
			if(ans != "Да")
				return
			var/width = tgui_input_number(ui.user, "Выставите ширину", "Настройки Сапёра", generation_columns, 25, 9)
			var/height = tgui_input_number(ui.user, "Выставите длину", "Настройки Сапёра", generation_rows, 25, 9)
			var/bombs = tgui_input_number(ui.user, "Выставите кол-во бомб", "Настройки Сапёра", generation_bombs, 100, 10)
			if(computer.loc != ui.user)
				return
			if(bombs > (width*height/5))
				tgui_alert(ui.user, "Слишком много бомб для данного размера поля!", "Настройки Сапёра", list("Ок"))
				return
			generation_rows = height
			generation_columns = width
			generation_bombs = bombs
			make_empty_matrix()


	return TRUE

/datum/computer_file/program/minesweeper/proc/check_win(mob/user)
	if(flagged_bombs == generation_bombs && \
		setted_flags == generation_bombs && \
		opened_cells == (generation_rows * generation_columns - generation_bombs))
		on_win(user)

/datum/computer_file/program/minesweeper/proc/on_win(mob/user)
	ignore_touches = TRUE
	playsound(get_turf(computer), 'sound/machines/ping.ogg', 20, TRUE)
	addtimer(CALLBACK(src, PROC_REF(make_empty_matrix)), 5 SECONDS)
	add_into_leaders(user, world.time - start_time)

/// Add player result to local, global leaderboards and DB
/datum/computer_file/program/minesweeper/proc/add_into_leaders(mob/user, game_time)
	var/nickname = tgui_input_text(user, "You finished the game in [game_time / 10] seconds.\n Write a nickname to save your result on the leaderboard.\n", "Minesweeper", "", 10)
	if(!nickname)
		return

	var/result_to_add = list(
		"name" = nickname,
		"time" = "[game_time/10]",
		"points" = "[current_3BV]",
		"pointsPerSec" = "[round(current_3BV/(game_time/10), 0.1)]",
		"fieldParams" = "[generation_columns]X[generation_rows]([generation_bombs])"
	)

	leaderboard += list(result_to_add)
	glob_leaderboard += list(result_to_add)
	add_result_to_db(result_to_add, user.ckey, generation_columns, generation_rows, generation_bombs)

/datum/computer_file/program/minesweeper/proc/on_loose(mob/user)
	ignore_touches = TRUE
	playsound(get_turf(computer), 'sound/effects/explosion/explosion1.ogg', 50, TRUE)
	if(computer.obj_flags & EMAGGED)
		explosion(computer, range_heavy, range_medium, range_light, range_flame)
	addtimer(CALLBACK(src, PROC_REF(make_empty_matrix)), 3 SECONDS)

// Return the minesweeper matrix to initial state
/datum/computer_file/program/minesweeper/proc/make_empty_matrix()
	minesweeper_matrix = list()
	for(var/i in 1 to generation_rows)
		var/list/new_row = list()
		for(var/j in 1 to generation_columns)
			new_row += list(list("open" = FALSE, "bomb" = FALSE, "flag" = FALSE, "around" = 0, "marked" = FALSE))
		minesweeper_matrix += list(new_row)
	first_touch = TRUE
	ignore_touches = FALSE
	SStgui.update_uis(computer)

// Fill matrix with bombs, ignores 3x3 square around first touch place
/datum/computer_file/program/minesweeper/proc/generate_matrix(x, y)
	flagged_bombs = 0
	setted_flags = 0
	opened_cells = 0
	var/list/possible_list = list()
	var/this_x = x
	var/this_y = y
	var/count = 0

	for(var/i in 1 to generation_rows)
		for(var/j in 1 to generation_columns)
			if((i in list(this_x - 1, this_x, this_x + 1)) && (j in list(this_y - 1, this_y, this_y + 1)))
				continue
			possible_list["[count]"] = list(i, j)
			count++

	for(var/bomb in 1 to generation_bombs)
		var/cell = pick(possible_list)
		var/coordinates = possible_list[cell]
		possible_list -= cell
		var/new_x = coordinates[1]
		var/new_y = coordinates[2]
		minesweeper_matrix[new_x][new_y]["bomb"] = TRUE

		if(new_x != 1)
			minesweeper_matrix[new_x-1][new_y]["around"] += 1

		if(new_y != 1)
			minesweeper_matrix[new_x][new_y-1]["around"] += 1

		if(new_x != 1 && new_y != 1)
			minesweeper_matrix[new_x-1][new_y-1]["around"] += 1

		if(new_x != generation_rows)
			minesweeper_matrix[new_x+1][new_y]["around"] += 1

		if(new_y != generation_columns)
			minesweeper_matrix[new_x][new_y+1]["around"] += 1

		if(new_x != generation_rows && new_y != generation_columns)
			minesweeper_matrix[new_x+1][new_y+1]["around"] += 1

		if(new_x != 1 && new_y != generation_columns)
			minesweeper_matrix[new_x-1][new_y+1]["around"] += 1

		if(new_x != generation_rows && new_y != 1)
			minesweeper_matrix[new_x+1][new_y-1]["around"] += 1

	first_touch = FALSE
	count_3BV()
	start_time = world.time

/**
 * Makes cell by passed coordinates open.
 * Increases `opened_cells` if cell was successfully opened and removes flag from it.
 *
 * @param {number] x - The row of the cell
 * @param {number] y - The column of the cell
 *
 * @return coordinates of opened cell as `list(x, y)` if cell was successfully opened
 *               and no bombs are around, `null` otherwise
/* 
/datum/computer_file/program/minesweeper/proc/open_cell(x, y)
	var/list/minesweeper_cell = minesweeper_matrix[x][y]
	if(minesweeper_cell["open"])
		return null
		
	minesweeper_cell["open"] = TRUE
	opened_cells += 1

	if(minesweeper_cell["flag"])
		minesweeper_cell["flag"] = FALSE
		setted_flags -= 1
		if(minesweeper_cell["bomb"])
			flagged_bombs -= 1
	
	if(minesweeper_cell["around"] != 0)
		return null

	return list(x, y)

// Open all "zeroes" around the click place
/datum/computer_file/program/minesweeper/proc/update_zeros(x, y)
	var/list/directions = list(
		list(-1,  0), // Left
		list( 1,  0), // Right
		list( 0, -1), // Up
		list( 0,  1), // Down
		list(-1, -1), // Top-Left
		list( 1,  1), // Bottom-Right
		list(-1,  1), // Top-Right
		list( 1, -1)  // Bottom-Left
	)

	var/list/list_for_update = list(list(x, y))
	var/index = 1

	while (index < list_for_update.len)
		var/list/coordinates = list_for_update[index]
		var/this_x = coordinates[1]
		var/this_y = coordinates[2]

		for (var/list/direction in directions)
			var/new_x = this_x + direction[1]
			var/new_y = this_y + direction[2]

			// Boundary checks
			if (new_x >= 1 && new_x <= generation_rows && new_y >= 1 && new_y <= generation_columns)
				// Diagonal check requires both adjacent cells to be open
				if (abs(direction[1]) == 1 && abs(direction[2]) == 1)
					if (!(minesweeper_matrix[new_x][this_y]["open"] && minesweeper_matrix[this_x][new_y]["open"]))
						continue

				list_for_update += open_cell(new_x, new_y, FALSE)
		index++

// Count value of field for scoring
/datum/computer_file/program/minesweeper/proc/count_3BV()
	current_3BV = 0
	for(var/i in 1 to generation_rows)
		for(var/j in 1 to generation_columns)
			if(minesweeper_matrix[i][j]["marked"])
				continue
			minesweeper_matrix[i][j]["marked"] = TRUE
			if(minesweeper_matrix[i][j]["bomb"])
				continue
			if(minesweeper_matrix[i][j]["around"])
				current_3BV++
				continue
			else
				current_3BV++
				count_zeros(i, j)
				continue

// part of proc/count_3BV, used to ignore adjacent "zeroes"
/datum/computer_file/program/minesweeper/proc/count_zeros(start_x, start_y)
	var/check_list = list(list(start_x, start_y))
	for(var/coordinates in check_list)
		var/x = coordinates[1]
		var/y = coordinates[2]
		minesweeper_matrix[x][y]["marked"] = TRUE
		for(var/i in list(x - 1, x, x + 1))
			for(var/j in list(y - 1, y, y + 1))
				if((i== 0) || (j == 0) || (i > generation_rows) || (j > generation_columns))
					continue
				if(minesweeper_matrix[i][j]["marked"])
					continue
				if(!minesweeper_matrix[i][j]["around"])
					check_list += list(list(i, j))

#undef MINESWEEPER_ROWS
#undef MINESWEEPER_COLUMNS
#undef MINESWEEPER_BOMBS

/* MINESWEEPER-PDA EMAG ACT */

/obj/item/modular_computer/pda/emag_act(mob/user, obj/item/card/emag/emag_card, forced)
	. = ..()
	if(.)
		INVOKE_ASYNC(src, PROC_REF(add_minesweeper))

/obj/item/modular_computer/pda/proc/add_minesweeper()
	store_file(new /datum/computer_file/program/minesweeper)

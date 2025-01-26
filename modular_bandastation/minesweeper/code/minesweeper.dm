#define MINESWEEPER_ROWS 16
#define MINESWEEPER_COLUMNS 16
#define MINESWEEPER_BOMBS 40

/datum/computer_file/program/minesweeper
	filename = "minesweeper"
	filedesc = "Minesweeper"
	// program_open_overlay = "minesweeper"
	extended_desc = "A program with the Minesweeper game! Don`t forget to share your results in online leaderbaord."
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

	/// The leaderboard list
	var/static/list/leaderboard = list()

/datum/computer_file/program/minesweeper/ui_interact(mob/user, datum/tgui/ui)
	if(!LAZYLEN(minesweeper_matrix))
		make_empty_matrix()

/datum/computer_file/program/minesweeper/ui_data(mob/user)
	var/list/data = list()
	data["matrix"] = minesweeper_matrix
	data["flags"] = setted_flags
	data["bombs"] = generation_bombs
	data["leaderboard"] = leaderboard
	data["first_touch"] = first_touch
	data["field_params"] = list("width" = generation_columns, "height" = generation_rows, "bombs" = generation_bombs)
	return data

/datum/computer_file/program/minesweeper/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	if(ignore_touches)
		return

	switch(action)
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
		if("ChangeSize")
			if(!first_touch)
				return
			var/ans = tgui_alert(ui.user, "You want to change field parametrs?", "Minesweeper Settings", list("Yes", "No"))
			if(ans == "No")
				return
			var/width = tgui_input_number(ui.user, "Set new width", "Minesweeper Settings", generation_columns, 25, 9)
			var/height = tgui_input_number(ui.user, "Set new height", "Minesweeper Settings", generation_rows, 25, 9)
			var/bombs = tgui_input_number(ui.user, "Set new bombs quantity", "Minesweeper Settings", generation_bombs, 100, 10)
			if(computer.loc != ui.user)
				return
			if(bombs > (width*height/5))
				tgui_alert(ui.user, "Too many bombs for this size!", "Minesweeper Settings", list("Ok"))
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

/datum/computer_file/program/minesweeper/proc/add_into_leaders(mob/user, game_time)
	var/nickname = tgui_input_text(user, "You finished the game in [game_time / 10] seconds.\n Write a nickname to save your result on the leaderboard.\n", "Minesweeper", "", 10)
	if(!nickname)
		return

	leaderboard += list(list("name" = nickname, "time" = "[game_time/10]", "points" = "[current_3BV]", "pointsPerSec" = "[round(current_3BV/(game_time/10), 0.1)]", "fieldParams" = "[generation_columns]X[generation_rows]([generation_bombs])"))

/datum/computer_file/program/minesweeper/proc/on_loose(mob/user)
	ignore_touches = TRUE
	playsound(get_turf(computer), 'sound/effects/explosion/explosion1.ogg', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(make_empty_matrix)), 3 SECONDS)

/datum/computer_file/program/minesweeper/proc/make_empty_matrix(pay = TRUE)
	minesweeper_matrix = list()
	for(var/i in 1 to generation_rows)
		var/list/new_row = list()
		for(var/j in 1 to generation_columns)
			new_row += list(list("open" = FALSE, "bomb" = FALSE, "flag" = FALSE, "around" = 0, "marked" = FALSE))
		minesweeper_matrix += list(new_row)
	first_touch = TRUE
	ignore_touches = FALSE
	SStgui.update_uis(computer)

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

/datum/computer_file/program/minesweeper/proc/open_cell(x, y, start_cycle = TRUE)
	. = list()
	if(!minesweeper_matrix[x][y]["open"])
		minesweeper_matrix[x][y]["open"] = TRUE
		opened_cells += 1

		if(minesweeper_matrix[x][y]["flag"])
			minesweeper_matrix[x][y]["flag"] = FALSE
			setted_flags -= 1
			if(minesweeper_matrix[x][y]["bomb"])
				flagged_bombs -= 1

		if(minesweeper_matrix[x][y]["around"] == 0)
			if(start_cycle)
				update_zeros(x, y)
			else
				. = list(list(x, y))

/datum/computer_file/program/minesweeper/proc/update_zeros(x, y)
	var/list/list_for_update = list(list(x, y))
	for(var/list/coordinates in list_for_update)
		var/this_x = coordinates[1]
		var/this_y = coordinates[2]
		var/new_x
		var/new_y

		if(this_x != 1)
			new_x = this_x-1
			list_for_update += open_cell(new_x, this_y)

		if(this_y != 1)
			new_y = this_y-1
			list_for_update += open_cell(this_x, new_y)

		if(this_x != generation_rows)
			new_x = this_x+1
			list_for_update += open_cell(new_x, this_y)

		if(this_y != generation_columns)
			new_y = this_y+1
			list_for_update += open_cell(this_x, new_y)

		if(this_x != 1 && this_y != 1)
			new_x = this_x-1
			new_y = this_y-1
			if(minesweeper_matrix[new_x][this_y]["open"] && minesweeper_matrix[this_x][new_y]["open"])
				list_for_update += open_cell(new_x, new_y)

		if(this_x != generation_rows && this_y != generation_columns)
			new_x = this_x+1
			new_y = this_y+1
			if(minesweeper_matrix[new_x][this_y]["open"] && minesweeper_matrix[this_x][new_y]["open"])
				list_for_update += open_cell(new_x, new_y)

		if(this_x != 1 && this_y != generation_columns)
			new_x = this_x-1
			new_y = this_y+1
			if(minesweeper_matrix[new_x][this_y]["open"] && minesweeper_matrix[this_x][new_y]["open"])
				list_for_update += open_cell(new_x, new_y)

		if(this_x != generation_rows && this_y != 1)
			new_x = this_x+1
			new_y = this_y-1
			if(minesweeper_matrix[new_x][this_y]["open"] && minesweeper_matrix[this_x][new_y]["open"])
				list_for_update += open_cell(new_x, new_y)

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

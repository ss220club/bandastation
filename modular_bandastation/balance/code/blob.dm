/mob/eye/blob
	var/expand_cost = BLOB_EXPAND_COST

/mob/eye/blob/Initialize(mapload, starting_points)
	. = ..()
	check_station_floor()

/mob/eye/blob/Login()
	. = ..()
	if(!main_station_floor(src))
		var/blob_message = "[span_boldwarning("Поскольку Вы находитесь не на основном этаже станции, Вы получаете следующие дебаффы:")]\n"
		blob_message += "1. Вам требуется больше тайлов для захвата.\n"
		blob_message += "2. Вам требуется больше ресурсов для установки тайла блоба."
		to_chat(src, boxed_message(blob_message))

/mob/eye/blob/proc/check_station_floor()
	if(main_station_floor(src))
		return
	expand_cost = BLOB_EXPAND_COST * 2
	blobwincount  = 700

/datum/action/innate/blobpop/Activate(timer_activated = FALSE)
	if(!main_station_floor(usr))
		if(tgui_alert(usr, "Вы находитесь не на основном этаже станции. Появление приведёт к накладыванию дебаффа. Вы уверены?", "Появление Блоба", list("Да", "Нет")) != "Да")
			return
	return ..()

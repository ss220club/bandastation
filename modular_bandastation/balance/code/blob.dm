GLOBAL_VAR_INIT(blob_expand_cost, 4)

/mob/eye/blob/Initialize(mapload, starting_points)
	. = ..()
	if(!main_station_floor(src))
		blobwincount = 700
	update_blob_expand_cost(src)

/mob/eye/blob/Login()
	. = ..()
	if(!main_station_floor(src))
		var/blob_message = "[span_boldwarning("Поскольку Вы находитесь не на основном этаже станции, Вы получаете следующие дебаффы:")]\n"
		blob_message += "1. Вам требуется больше тайлов для захвата.\n"
		blob_message += "2. Вам требуется больше ресурсов для установки тайла блоба."
		to_chat(src, boxed_message(blob_message))

/mob/eye/blob/proc/update_blob_expand_cost(mob/blob)
	if(!blob)
		return
	if(!main_station_floor(blob))
		GLOB.blob_expand_cost = 8
	else
		GLOB.blob_expand_cost = 4

/datum/action/innate/blobpop/Activate(timer_activated = FALSE)
	if(!main_station_floor(usr))
		if(tgui_alert(usr, "Вы находитесь не на основном этаже станции. Появление приведёт к накладыванию дебаффа. Вы уверены?", "Появление Блоба", list("Да", "Нет")) != "Да")
			return
	return ..()

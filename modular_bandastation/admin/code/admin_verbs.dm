ADMIN_VERB_ONLY_CONTEXT_MENU(spawn_debug_outfit, R_SPAWN, "Debug Outfit", mob/admin in world)
	if(tgui_alert(admin,"Это заспавнит вас в специальном Debug прикиде, удаляя при этом ваше старое тело если оно было. Вы уверены?", "Debug Outfit", list("Да", "Нет")) != "Да")
		return
	var/mob/living/carbon/human/admin_body = admin.change_mob_type(/mob/living/carbon/human, delete_old_mob = TRUE)
	admin_body.equipOutfit(/datum/outfit/debug)

ADMIN_VERB_ONLY_CONTEXT_MENU(download_flaticon, R_ADMIN, "Download Icon", atom/thing in world)
	var/icon/image = getFlatIcon(thing, no_anim = TRUE)
	var/original_width = max(image.Width(), 32)
	var/original_height = max(image.Height(), 32)
	var/image_width
	var/image_height

	var/resize_answer = tgui_alert(usr, "Хотите ли вы изменить размер иконки? Оригинальный размер: [original_width]x[original_height]", "Download Icon", list("Да", "Нет", "Удвоить"))
	if(resize_answer != "Нет" && !isnull(resize_answer))
		switch(resize_answer)
			if("Да")
				image_width = tgui_input_number(usr, "Оригинальная ширина: [original_width]px", "Изменение ширины", original_width, 1024, 16)
				if(isnull(image_width))
					image_width = original_width

				image_height = tgui_input_number(usr, "Оригинальная высота: [original_height]px", "Изменение высоты", original_height, 1024, 16)
				if(isnull(image_height))
					image_height = original_height

			if("Удвоить")
				image_width = original_width * 2
				image_height = original_height * 2

		image.Scale(image_width, image_height)
	else
		image_width = original_width
		image_height = original_height

	usr << ftp(image, "[thing.name]_[image_width]x[image_height].png")

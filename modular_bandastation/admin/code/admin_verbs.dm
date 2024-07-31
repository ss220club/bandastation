ADMIN_VERB_ONLY_CONTEXT_MENU(spawn_debug_outfit, R_SPAWN, "Debug Outfit", mob/admin in world)
	if(tgui_alert(admin,"Это заспавнит вас в специальном Debug прикиде, удаляя при этом ваше старое тело если оно было. Вы уверены?", "Debug Outfit", list("Да", "Нет")) != "Да")
		return
	var/mob/living/carbon/human/admin_body = admin.change_mob_type(/mob/living/carbon/human, delete_old_mob = TRUE)
	admin_body.equipOutfit(/datum/outfit/debug)

ADMIN_VERB_ONLY_CONTEXT_MENU(download_flaticon, R_ADMIN, "Download Icon", atom/thing as mob|obj|turf)
	var/icon/image = getFlatIcon(thing)
	if(image.Width() == 32 || image.Height() == 32)
		image.Scale(64, 64)
	usr << ftp(image, "[thing.name].png")

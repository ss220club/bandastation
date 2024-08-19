/mob/living/silicon/ai/verb/ai_cryo()
	set name = "AI Cryogenic Stasis"
	set desc = "Puts the current AI personality into cryogenic stasis, freeing the space for another."
	set category = "AI Commands"

	if(incapacitated())
		return
	if(tgui_alert(usr, "Войти в криосон? Вы станете призраком. Не забывайте Ахелпать при вхождении в криосон на важных ролях.", "Войти в криогенный стазис", list("Да", "Нет")) == "Да")
		src.ghostize(FALSE)
		minor_announce("Станционный ИИ был отключён от внутренних систем и был перемещён на хранение. Подготовка к загрузке нового ИИ.", "Станционный ИИ")
		new /obj/structure/ai_core/latejoin_inactive(loc)
		if(src.mind)
			//Handle job slot/tater cleanup.
			if(src.mind.assigned_role.title == JOB_AI)
				SSjob.FreeRole(JOB_AI)
		src.mind.special_role = null
		qdel(src)
	else
		return

/datum/action/changeling/adrenaline
	name = "Adrenaline Sacs"
	desc = "Мы развиваем дополнительные адреналиновые мешочки по всему телу. Стоит 30 химикатов."
	helptext = "Мгновенно снимает все оглушения и добавляет кратковременное снижение последующих оглушений. Можно использовать, находясь без сознания. Продолжительное использование отравляет тело."
	button_icon_state = "adrenaline"
	chemical_cost = 30
	dna_cost = 2
	req_human = TRUE
	req_stat = UNCONSCIOUS

//Recover from stuns.
/datum/action/changeling/adrenaline/sting_action(mob/living/user)
	..()
	to_chat(user, span_notice("Энергия проносится сквозь нас."))
	user.SetKnockdown(0)
	user.set_resting(FALSE)
	user.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4) //20 seconds
	user.reagents.add_reagent(/datum/reagent/medicine/changelinghaste, 3) //6 seconds, for a really quick burst of speed
	return TRUE

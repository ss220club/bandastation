/datum/action/changeling/spiders
	name = "Spread Infestation"
	desc = "Наша форма делится, создавая скопление яиц, из которых вырастет смертельно опасный арахнид. Стоит 45 химикатов."
	helptext = "Пауки - безжалостные существа и могут напасть на своих создателей, когда вырастут. Требуется не менее 3 поглощений ДНК."
	button_icon_state = "spread_infestation"
	chemical_cost = 45
	dna_cost = 1
	req_absorbs = 3

//Makes a spider egg cluster. Allows you enable further general havok by introducing spiders to the station.
/datum/action/changeling/spiders/sting_action(mob/user)
	..()
	new /obj/effect/mob_spawn/ghost_role/spider/bloody(user.loc)
	return TRUE

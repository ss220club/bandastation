/datum/controller/subsystem/gamemode/proc/send_trait_report()
	. = "<b><i>Информационное сообщение Департамента разведки Нанотрейзен, Сектор Спинвард, Дата [time2text(world.realtime, "DDD, MMM DD")], [CURRENT_STATION_YEAR]:</i></b><hr>"
	SSstation.generate_station_goals(20)

	. += generate_station_goal_report()
	. += generate_station_trait_report()

	. += "<hr>Это включает в себя вашу смену с начала до момента окончания. Удачной смены!<hr>\
	<p style=\"color: grey; text-align: justify;\">Этот ярлык подтверждает, что стажёр проверил вышеизложенное перед отправкой. Данный документ является собственностью корпорации Nanotrasen.</p>"

	print_command_report(., "Отчет Центрального Командования", announce = FALSE)
	priority_announce("Приветствуем вас, экипаж станции [station_name()]. Наш стажёр проверил отчет и возможные отклонения и направил вам результат. Хорошей смены!", "Протокол отклонений", SSstation.announcer.get_rand_report_sound())

/*
 * Generate a list of station goals available to purchase to report to the crew.
 *
 * Returns a formatted string all station goals that are available to the station.
 */
/datum/controller/subsystem/gamemode/proc/generate_station_goal_report()
	var/list/station_goals = SSstation.get_station_goals()
	if(!length(station_goals))
		return "<hr><b>Активные задачи - отсутствуют.</b><br>"
	var/list/goal_reports = list()
	for(var/datum/station_goal/station_goal as anything in station_goals)
		station_goal.on_report()
		goal_reports += station_goal.get_report()
	return  "<hr><b>Специальные цели для [station_name()]:</b><br>[goal_reports.Join("<hr>")]"

/*
 * Generate a list of active station traits to report to the crew.
 *
 * Returns a formatted string of all station traits (that are shown) affecting the station.
 */
/datum/controller/subsystem/gamemode/proc/generate_station_trait_report()
	if(!length(SSstation.station_traits))
		return "<hr><b>Нет выявленных отклонений на смене.</b><br>"

	var/list/station_traits_report = list("<hr><b>Выявленные отклонения в смене:</b><BR>")
	for(var/datum/station_trait/station_trait as anything in SSstation.station_traits)
		if(!station_trait.show_in_report)
			continue
		station_traits_report += "[station_trait.get_report()]<br>"

	return station_traits_report.Join()

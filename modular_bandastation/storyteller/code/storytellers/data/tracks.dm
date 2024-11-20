// A point is added every second, adjust new track threshold overrides accordingly

/// Storyteller track data, for easy overriding of tracks without having to copypaste
/// thresholds - Used to show how many points the track has to collect before it triggers, lower means faster
/datum/storyteller_data/tracks
	///События категории Mundane - скруберы, валентинки, т.е. мелочь
	var/threshold_mundane = 1200
	///События категории Moderate - аномалии, лозы, утечка радейки
	var/threshold_moderate = 1800
	///События категории Major - пираты, рад-шторм, бюрократическая ошибка
	var/threshold_major = 8000
	///События категории Crewset - еретики, генокрады, шпионы, трейторы, нюак, малф (когда активный член экипажа становится антагом (спящий агент))
	var/threshold_crewset = 1200
	///События категории Ghostset - ниндзя, дракон (когда гостам предлагается роль антага)
	var/threshold_ghostset = 7000

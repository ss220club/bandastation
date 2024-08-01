/datum/status_effect/cpred
	id = "cpred"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = 15

/datum/status_effect/autocpred
	id = "autocpred"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = 25

/datum/status_effect/painkiller/low
	id = "lowpk"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = 50

/datum/status_effect/painkiller/medium
	id = "midpk"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = 50

/datum/status_effect/painkiller/high
	id = "hihgpk"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = 50

/datum/status_effect/necroinversite
	id = "necroinversite_reagent"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = 50


// internal bleeding
/datum/status_effect/wound/internal_bleed/moderate
	id = "light_ib"
/datum/status_effect/wound/internal_bleed/severe
	id = "medium_ib"
/datum/status_effect/wound/internal_bleed/critical
	id = "heavy_ib"

// necrosis
/datum/status_effect/wound/necrosis/moderate
	id = "light_necrosis"
/datum/status_effect/wound/necrosis/severe
	id = "medium_necrosis"
/datum/status_effect/wound/necrosis/critical
	id = "heavy_necrosis"

/datum/movespeed_modifier/status_effect/pain/low
	multiplicative_slowdown = 0.15

/datum/movespeed_modifier/status_effect/pain/midlow
	multiplicative_slowdown = 0.25

/datum/movespeed_modifier/status_effect/pain/mid
	multiplicative_slowdown = 0.45

/datum/movespeed_modifier/status_effect/pain/midhigh
	multiplicative_slowdown = 0.85

/datum/movespeed_modifier/status_effect/pain/high
	multiplicative_slowdown = 0.99

/datum/actionspeed_modifier/status_effect/pain/low
	multiplicative_slowdown = 0.5

/datum/actionspeed_modifier/status_effect/pain/midlow
	multiplicative_slowdown = 1

/datum/actionspeed_modifier/status_effect/pain/mid
	multiplicative_slowdown = 2

/datum/actionspeed_modifier/status_effect/pain/midhigh
	multiplicative_slowdown = 3.5

/datum/actionspeed_modifier/status_effect/pain/high
	multiplicative_slowdown = 5

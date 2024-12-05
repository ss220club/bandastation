/datum/config_entry/flag/log_storyteller

/datum/config_entry/flag/disable_storyteller

/datum/config_entry/flag/log_antag_rep

/datum/config_entry/number/transfer_vote_time
	default = 90 MINUTES
	min_val = 0

/datum/config_entry/number/transfer_vote_time/ValidateAndSet(str_val)
	. = ..()
	if(.)
		config_entry_value *= 600 // documented as minutes

/datum/config_entry/number/subsequent_transfer_vote_time
	default = 30 MINUTES
	min_val = 0

/datum/config_entry/number/subsequent_transfer_vote_time/ValidateAndSet(str_val)
	. = ..()
	if(.)
		config_entry_value *= 600 // documented as minutes

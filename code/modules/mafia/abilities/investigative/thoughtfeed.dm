/**
 * Thoughtfeeding
 *
 * During the night, thoughtfeeding will reveal the person's exact role.
 */
/datum/mafia_ability/thoughtfeeder
	name = "Мысленная пища"
	ability_action = "наслаждайтесь воспоминаниями"

/datum/mafia_ability/thoughtfeeder/perform_action_target(datum/mafia_controller/game, datum/mafia_role/day_target)
	. = ..()
	if(!.)
		return FALSE

	if((target_role.role_flags & ROLE_UNDETECTABLE))
		host_role.send_message_to_player(span_warning("[target_role.body.real_name], его воспоминания показывают, что он [pick(game.all_roles - target_role)]."))
	else
		host_role.send_message_to_player(span_warning("[target_role.body.real_name], его Воспоминания показывают, что он [target_role.name]."))
	return TRUE

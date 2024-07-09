/datum/action/cooldown/spell/pointed/burglar_finesse
	name = "Burglar's Finesse"
	desc = "Крадет случайны предмет из сумки жертвы."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "burglarsfinesse"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 40 SECONDS

	invocation = "Khenem"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	cast_range = 4

/datum/action/cooldown/spell/pointed/burglar_finesse/is_valid_target(atom/cast_on)
	return ..() && ishuman(cast_on) && (locate(/obj/item/storage/backpack) in cast_on.contents)

/datum/action/cooldown/spell/pointed/burglar_finesse/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_danger("Вы чувствуете легкое потягивание, но в остальном все в порядке, вы были защищены святыми силами!"))
		to_chat(owner, span_danger("[cast_on] под защитой святой силы!"))
		return FALSE

	var/obj/storage_item = locate(/obj/item/storage/backpack) in cast_on.contents

	if(isnull(storage_item))
		return FALSE

	var/item = pick(storage_item.contents)
	if(isnull(item))
		return FALSE

	to_chat(cast_on, span_warning("Ваш [storage_item] чувствуется легче..."))
	to_chat(owner, span_notice("Одним мгновением, вы вытягиваете [item] из [storage_item] у [cast_on]."))
	owner.put_in_active_hand(item)

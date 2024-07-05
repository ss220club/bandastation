#define ADVMED_PAIN_THRESHOLD_MAX 150
#define ADVMED_PAIN_PART_MAX 200
#define ADVMED_PAIN_EFFECT_MODIFIER 2
#define ADVMED_PAIN_CHAT_LIMBS_LOW 10
#define ADVMED_PAIN_CHAT_LIMBS_MIDDLE 30
#define ADVMED_PAIN_CHAT_LIMBS_HIGH 50
#define ADVMED_PAIN_EFFECT_LIMBS 50
#define ADVMED_PAIN_EFFECT_CHEST 75
#define ADVMED_PAIN_EFFECT_HEAD 25
#define ADVMED_PAIN_MIN_MODIFIER 0.5
#define ADVMED_PAIN_FADE 0.5
#define ADVMED_PAIN_APPLICATION_MODIFIER 1.5
#define ADVMED_PAIN_HEART_ATTACK_MODIFIER 2

/datum/component/additional_med
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/mob/living/carbon/assigned_mob = null

/datum/component/additional_med/Initialize(list/arguments)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	assigned_mob = arguments
	START_PROCESSING(SSobj, src)

/datum/component/additional_med/process()
	var/damaged_parts_list = assigned_mob.get_damaged_bodyparts(TRUE, TRUE, ALL)
	var/min_pain = 0
	var/all_pain = 0
	var/add_pain
	for(var/obj/item/bodypart/part in damaged_parts_list)
		min_pain = (part.burn_dam + part.brute_dam) * ADVMED_PAIN_MIN_MODIFIER
		if (part.pain >= ADVMED_PAIN_PART_MAX)
			part.pain = ADVMED_PAIN_PART_MAX
		if (part.pain - ADVMED_PAIN_FADE >= min_pain)
			part.pain -= ADVMED_PAIN_FADE
		else
			part.pain = min_pain
		add_pain = part.pain
		if (assigned_mob.has_status_effect(/datum/status_effect/painkiller/low))
			add_pain = part.pain * 0.67
		if (assigned_mob.has_status_effect(/datum/status_effect/painkiller/medium))
			add_pain = part.pain * 0.34
		if (assigned_mob.has_status_effect(/datum/status_effect/painkiller/high))
			add_pain = part.pain * 0.01
		if (HAS_TRAIT(assigned_mob, TRAIT_ANALGESIA))
			add_pain = 0
		all_pain += add_pain

		if (prob(10))
			switch(add_pain)
				if(0.01 to ADVMED_PAIN_CHAT_LIMBS_LOW)
					to_chat(assigned_mob, span_danger("You feel small pain in your [part.name]"))
				if(ADVMED_PAIN_CHAT_LIMBS_LOW to ADVMED_PAIN_CHAT_LIMBS_MIDDLE)
					to_chat(assigned_mob, span_danger("You feel pain in your [part.name] and looks like it's time to threat your wounds"))
				if(ADVMED_PAIN_CHAT_LIMBS_MIDDLE to ADVMED_PAIN_CHAT_LIMBS_HIGH)
					to_chat(assigned_mob, span_danger("You feel sever pain in your [part.name] and it's almost unverable"))
				if(ADVMED_PAIN_CHAT_LIMBS_HIGH to INFINITY)
					to_chat(assigned_mob, span_danger("You [part.name] is burning like hell from pain!"))

		if (part != BODY_ZONE_HEAD && part != BODY_ZONE_CHEST)
			if (add_pain >= ADVMED_PAIN_EFFECT_LIMBS / ADVMED_PAIN_EFFECT_MODIFIER && (part == BODY_ZONE_L_ARM || part == BODY_ZONE_R_ARM ))
				if (prob(add_pain - ADVMED_PAIN_EFFECT_LIMBS))
					assigned_mob.drop_all_held_items()
				switch(add_pain)
					if(ADVMED_PAIN_EFFECT_LIMBS / ADVMED_PAIN_EFFECT_MODIFIER to ADVMED_PAIN_EFFECT_LIMBS / (ADVMED_PAIN_EFFECT_MODIFIER / 2))
						assigned_mob.add_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/pain/low)
					if(ADVMED_PAIN_EFFECT_LIMBS / (ADVMED_PAIN_EFFECT_MODIFIER / 2) to ADVMED_PAIN_EFFECT_LIMBS)
						assigned_mob.add_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/pain/midlow)
					if(ADVMED_PAIN_EFFECT_LIMBS to ADVMED_PAIN_EFFECT_LIMBS * (ADVMED_PAIN_EFFECT_MODIFIER / 2))
						assigned_mob.add_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/pain/mid)
					if(ADVMED_PAIN_EFFECT_LIMBS * (ADVMED_PAIN_EFFECT_MODIFIER / 2) to ADVMED_PAIN_EFFECT_LIMBS * ADVMED_PAIN_EFFECT_MODIFIER)
						assigned_mob.add_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/pain/midhigh)
					if(ADVMED_PAIN_EFFECT_LIMBS * ADVMED_PAIN_EFFECT_MODIFIER to INFINITY)
						assigned_mob.add_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/pain/high)
			if (add_pain >= ADVMED_PAIN_EFFECT_LIMBS / ADVMED_PAIN_EFFECT_MODIFIER && (part == BODY_ZONE_L_LEG || part == BODY_ZONE_R_LEG ))
				if (prob(add_pain - ADVMED_PAIN_EFFECT_LIMBS))
					assigned_mob.Knockdown(1 SECONDS)
				switch(add_pain)
					if(ADVMED_PAIN_EFFECT_LIMBS / ADVMED_PAIN_EFFECT_MODIFIER to ADVMED_PAIN_EFFECT_LIMBS / (ADVMED_PAIN_EFFECT_MODIFIER / 2))
						assigned_mob.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/pain/low)
					if(ADVMED_PAIN_EFFECT_LIMBS / (ADVMED_PAIN_EFFECT_MODIFIER / 2) to ADVMED_PAIN_EFFECT_LIMBS)
						assigned_mob.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/pain/midlow)
					if(ADVMED_PAIN_EFFECT_LIMBS to ADVMED_PAIN_EFFECT_LIMBS * (ADVMED_PAIN_EFFECT_MODIFIER / 2))
						assigned_mob.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/pain/mid)
					if(ADVMED_PAIN_EFFECT_LIMBS * (ADVMED_PAIN_EFFECT_MODIFIER / 2) to ADVMED_PAIN_EFFECT_LIMBS * ADVMED_PAIN_EFFECT_MODIFIER)
						assigned_mob.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/pain/midhigh)
					if(ADVMED_PAIN_EFFECT_LIMBS * ADVMED_PAIN_EFFECT_MODIFIER to INFINITY)
						assigned_mob.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/pain/high)
		if (part == BODY_ZONE_HEAD)
			if (add_pain >= ADVMED_PAIN_EFFECT_HEAD / ADVMED_PAIN_EFFECT_MODIFIER)
				//при уровне боли от 0 до 90 накладывает визуальный эффект пульсирующего белого экрана по краям.
				if (add_pain >= ADVMED_PAIN_EFFECT_HEAD && prob(add_pain - ADVMED_PAIN_EFFECT_HEAD))
					assigned_mob.Unconscious(40)
					assigned_mob.Stun(100)

	for(var/obj/item/organ/internal/organ in assigned_mob.organs)
		min_pain = organ.damage * ADVMED_PAIN_MIN_MODIFIER
		if (organ.pain >= ADVMED_PAIN_PART_MAX)
			organ.pain = ADVMED_PAIN_PART_MAX
		if (organ.pain - ADVMED_PAIN_FADE >= min_pain)
			organ.pain -= ADVMED_PAIN_FADE
		else
			organ.pain = min_pain
		add_pain = organ.pain
		if (assigned_mob.has_status_effect(/datum/status_effect/painkiller/low))
			add_pain = organ.pain * 0.67
		if (assigned_mob.has_status_effect(/datum/status_effect/painkiller/medium))
			add_pain = organ.pain * 0.34
		if (assigned_mob.has_status_effect(/datum/status_effect/painkiller/high))
			add_pain = organ.pain * 0.01
		if (HAS_TRAIT(assigned_mob, TRAIT_ANALGESIA))
			add_pain = 0
		all_pain += add_pain

	to_chat(assigned_mob, span_danger("Current pain of [assigned_mob.name] is [all_pain]"))
	if (all_pain >= ADVMED_PAIN_THRESHOLD_MAX)
		if (all_pain >= (ADVMED_PAIN_THRESHOLD_MAX * ADVMED_PAIN_HEART_ATTACK_MODIFIER))
			if (prob((all_pain - ADVMED_PAIN_THRESHOLD_MAX * ADVMED_PAIN_HEART_ATTACK_MODIFIER) / 3))
				var/datum/disease/heart_failure/heart_attack = new(src)
				to_chat(assigned_mob, span_danger("Your chest is bursting and hurts a lot"))
				heart_attack.stage_prob = 5
				assigned_mob.ForceContractDisease(heart_attack)
				assigned_mob.Unconscious(100)
				assigned_mob.Stun(200)


/// Security level is gamma. (Ebut nuki)
#define SEC_LEVEL_GAMMA 4
/// Security level is epsilon. (Ebut Deadi!)
#define SEC_LEVEL_EPSILON 5

/**
 * Gamma
 *
 * Station major hostile threats
 */
/datum/security_level/gamma
	name = "gamma"
	announcement_color = "orange"
	sound = 'modular_bandastation/events/sound/new_siren.ogg'
	number_level = SEC_LEVEL_GAMMA
	lowering_to_announcement = "Центральным Командованием был установлен Код Гамма на станции. Служба безопасности должна быть полностью вооружена. Гражданский персонал обязан немедленно обратиться к Главам отделов для получения дальнейших указаний."
	elevating_to_announcement = "Центральным Командованием был установлен Код Гамма на станции. Служба безопасности должна быть полностью вооружена. Гражданский персонал обязан немедленно обратиться к Главам отделов для получения дальнейших указаний."

/**
 * Epsilon
 *
 * Station is not longer under the Central Command and to be destroyed by Death Squad (Or maybe not)
 */
/datum/security_level/epsilon
	name = "epsilon"
	announcement_color = "purple"
	sound = 'modular_bandastation/events/sound/epsilon.ogg'
	number_level = SEC_LEVEL_EPSILON
	lowering_to_announcement = "Центральным командованием был установлен код ЭПСИЛОН. Все контракты расторгнуты."
	elevating_to_announcement = "Центральным командованием был установлен код ЭПСИЛОН. Все контракты расторгнуты."

#undef SEC_LEVEL_GAMMA
#undef SEC_LEVEL_EPSILON

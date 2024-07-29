/// Security level is gamma.
#define SEC_LEVEL_GAMMA 4
/// Security level is epsilon.
#define SEC_LEVEL_EPSILON 5

/**
 * Gamma
 *
 * Station major hostile threats
 */

/datum/security_level/gamma
	name = "gamma"
	announcement_color = "orange"
	sound = 'modular_bandastation/security_levels/sound/new_siren.ogg'
	status_display_icon_state = "gammaalert"
	//fire_alarm_light_color = LIGHT_COLOR_INTENSE_RED пока не работает
	number_level = SEC_LEVEL_GAMMA
	lowering_to_announcement = "Центральным Командованием был установлен Код Гамма. Служба безопасности должна быть полностью вооружена. Гражданский персонал обязан немедленно обратиться к Главам отделов для получения дальнейших указаний."
	elevating_to_announcement = "Центральным Командованием был установлен Код Гамма. Служба безопасности должна быть полностью вооружена. Гражданский персонал обязан немедленно обратиться к Главам отделов для получения дальнейших указаний."
	//shuttle_call_time_mod = ALERT_COEFF_DELTA Не знаю какой коэф. выставить

/**
 * Epsilon
 *
 * Station is not longer under the Central Command and to be destroyed by Death Squad (Or maybe not)
 */
/datum/security_level/epsilon
	name = "epsilon"
	announcement_color = "purple"
	sound = 'modular_bandastation/security_levels/sound/epsilon.ogg'
	number_level = SEC_LEVEL_EPSILON
	status_display_icon_state = "epsilonalert"
	//fire_alarm_light_color = LIGHT_COLOR_INTENSE_RED пока не работает
	lowering_to_announcement = "Центральным командованием был установлен код ЭПСИЛОН. Все контракты расторгнуты."
	elevating_to_announcement = "Центральным командованием был установлен код ЭПСИЛОН. Все контракты расторгнуты."
	//shuttle_call_time_mod = ALERT_COEFF_DELTA Нужен ли он вообще, с учетом того, что педали сами отменят

#undef SEC_LEVEL_GAMMA
#undef SEC_LEVEL_EPSILON

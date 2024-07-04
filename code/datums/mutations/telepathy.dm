/datum/mutation/human/telepathy
	name = "Telepathy"
	desc = "Редкая мутация, позволяющая её обладателю телепатически общаться с другими."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>Ты слышишь эхо собственного голоса в своём разуме!</span>"
	text_lose_indication = "<span class='notice'>Ты перестаешь слышать эхо внутри своего разума.</span>"
	difficulty = 12
	power_path = /datum/action/cooldown/spell/list_target/telepathy
	instability = POSITIVE_INSTABILITY_MINOR // basically a mediocre PDA messager
	energy_coeff = 1

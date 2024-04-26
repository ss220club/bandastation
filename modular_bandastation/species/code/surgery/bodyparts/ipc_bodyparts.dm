/obj/item/bodypart/head/robot/ipc
	icon = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_static = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	limb_id = "synth" //Overriden in /species/ipc/replace_body()
	icon_state = "synth_head"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	biological_state = BIO_ROBOTIC
	bodytype = BODYTYPE_ROBOTIC

	body_damage_coeff = 1.1	//IPC's Head can dismember	//Monkestation Edit
	max_damage = 40	//Keep in mind that this value is used in the //Monkestation Edit
	dmg_overlay_type = "synth"

/obj/item/bodypart/chest/robot/ipc
	icon = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_static = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	limb_id = "synth"
	icon_state = "synth_chest"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	biological_state = BIO_ROBOTIC
	bodytype = BODYTYPE_ROBOTIC

	body_damage_coeff = 1	//IPC Chest at default	///Monkestation Edit
	max_damage = 250	//Default: 200 ///Monkestation Edit

	dmg_overlay_type = "synth"

/obj/item/bodypart/arm/left/robot/ipc
	icon = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_static = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	limb_id = "synth"
	icon_state = "synth_l_arm"
	should_draw_greyscale = FALSE
	biological_state = BIO_ROBOTIC | BIO_JOINTED
	bodytype = BODYTYPE_ROBOTIC

	body_damage_coeff = 1.1	//IPC's Limbs Should Dismember Easier	//Monkestation Edit
	max_damage = 30	//Monkestation Edit

	dmg_overlay_type = "synth"

/obj/item/bodypart/arm/right/robot/ipc
	icon = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_static = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	limb_id = "synth"
	icon_state = "synth_r_arm"
	should_draw_greyscale = FALSE
	biological_state = BIO_ROBOTIC | BIO_JOINTED
	bodytype = BODYTYPE_ROBOTIC

	body_damage_coeff = 1.1	//IPC's Limbs Should Dismember Easier	//Monkestation Edit
	max_damage = 30	//Monkestation Edit

	dmg_overlay_type = "synth"

/obj/item/bodypart/leg/left/robot/ipc
	icon = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_static = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	limb_id = "synth"
	icon_state = "synth_l_leg"
	should_draw_greyscale = FALSE
	biological_state = BIO_ROBOTIC | BIO_JOINTED
	bodytype = BODYTYPE_ROBOTIC

	dmg_overlay_type = "synth"

/obj/item/bodypart/leg/right/robot/ipc
	icon = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_greyscale = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	icon_static = 'modular_bandastation/species/icons/mob/species/ipc/bodyparts.dmi'
	limb_id = "synth"
	icon_state = "synth_r_leg"
	should_draw_greyscale = FALSE
	biological_state = BIO_ROBOTIC | BIO_JOINTED
	bodytype = BODYTYPE_ROBOTIC

	body_damage_coeff = 1.1	//IPC's Limbs Should Dismember Easier	//Monkestation Edit
	max_damage = 30	//Monkestation Edit

	dmg_overlay_type = "synth"

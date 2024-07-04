/obj/structure/table/optable
	name = "operating table"
	desc = "Used for advanced medical procedures."
	icon = 'icons/obj/medical/surgery_table.dmi'
	icon_state = "surgery_table"

/obj/structure/table/optable/recheck_patient(mob/living/carbon/potential_patient)
	if(isnull(potential_patient))
		return

	SIGNAL_HANDLER
	if(patient && patient != potential_patient)
		return

	if(potential_patient.body_position == LYING_DOWN && potential_patient.loc == loc)
		patient = potential_patient
		return

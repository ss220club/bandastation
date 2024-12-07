/**
 * EXTRA MOB VV
 */
/mob/living/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SEND_CRYO, "Send to Cryogenic Storage")

/mob/living/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_SEND_CRYO])
		vv_send_cryo()

/mob/living/proc/vv_send_cryo()
	if(!check_rights(R_SPAWN))
		return

	var/send_notice = tgui_alert(usr, "Add a paper notice about sending [name] into a cryopod?", "Leave a paper?", list("Yes", "No", "Cancel"))
	if(send_notice != "Yes" && send_notice != "No")
		return

	//log/message
	log_admin("[key_name(usr)] has put [key_name(src)] into a cryopod.")
	var/msg = span_notice("[key_name_admin(usr)] has put [key_name(src)] into a cryopod from [ADMIN_VERBOSEJMP(src)].")
	message_admins(msg)
	admin_ticket_log(src, msg)

	send_notice = send_notice == "Yes"
	send_to_cryo(send_notice)

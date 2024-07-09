/obj/item/flag
	name = "\improper Nanotrasen flag"
	desc = "A flag proudly boasting the logo of NT."
	icon = 'modular_bandastation/objects/icons/flag.dmi'
	icon_state = "ntflag"
	inhand_icon_state = "ntflag"
	lefthand_file = 'modular_bandastation/objects/icons/inhands/flags_lefthand.dmi'
	righthand_file = 'modular_bandastation/objects/icons/inhands/flags_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	max_integrity = 40
	resistance_flags = FLAMMABLE
	var/rolled = FALSE

/obj/item/flag/attack_self(mob/user, modifiers)
	. = ..()
	rolled = !rolled
	user.visible_message(span_notice("[user] [rolled ? "скручивает" : "раскручивает"] [src.name]."), span_notice("Вы [rolled ? "скручиваете" : "раскручиваете"] [src.name]."), span_warning("Вы слышите шорох ткани."))
	update_icon()

/obj/item/flag/update_icon_state()
	. = ..()
	if(!rolled)
		icon_state = initial(icon_state)
	if(rolled)
		icon_state = "[icon_state]_rolled"
	if(ismob(loc))
		var/mob/M = loc
		M.update_held_items()

/obj/item/flag/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(burn_paper_product_attackby_check(attacking_item, user))
		return

/obj/item/flag/soundhand
	name = "флаг группы Саундхэнд"
	desc = "Флаг легендарной группы Саундхэнд. Вероятно были созданы исключительно для сжигания и эффекта восхищения от крутости."
	icon_state = "flag_group"
	inhand_icon_state = "flag_group"

/obj/item/flag/clown
	name = "\improper Clown Unity flag"
	desc = "The universal banner of clowns everywhere. It smells faintly of bananas."
	icon_state = "clownflag"
	inhand_icon_state = "clownflag"

/obj/item/flag/mime
	name = "\improper Mime Unity flag"
	desc = "The standard by which all mimes march to war, as cold as ice and silent as the grave."
	icon_state = "mimeflag"
	inhand_icon_state = "mimeflag"

/obj/item/flag/ian
	name = "\improper Ian flag"
	desc = "The banner of Ian, because SQUEEEEE."
	icon_state = "ianflag"
	inhand_icon_state = "ianflag"

//Species flags

/obj/item/flag/slime
	name = "\improper Slime People flag"
	desc = "A flag proudly proclaiming the superior heritage of Slime People."
	icon_state = "slimeflag"
	inhand_icon_state = "slimeflag"

/obj/item/flag/skrell
	name = "\improper Skrell flag"
	desc = "A flag proudly proclaiming the superior heritage of Skrell."
	icon_state = "skrellflag"
	inhand_icon_state = "skrellflag"

/obj/item/flag/vox
	name = "\improper Vox flag"
	desc = "A flag proudly proclaiming the superior heritage of Vox."
	icon_state = "voxflag"
	inhand_icon_state = "voxflag"

/obj/item/flag/machine
	name = "\improper Synthetics flag"
	desc = "A flag proudly proclaiming the superior heritage of Synthetics."
	icon_state = "machineflag"
	inhand_icon_state = "machineflag"

/obj/item/flag/diona
	name = "\improper Diona flag"
	desc = "A flag proudly proclaiming the superior heritage of Dionae."
	icon_state = "dionaflag"
	inhand_icon_state = "dionaflag"

/obj/item/flag/human
	name = "\improper Human flag"
	desc = "A flag proudly proclaiming the superior heritage of Humans."
	icon_state = "humanflag"
	inhand_icon_state = "humanflag"

/obj/item/flag/greys
	name = "\improper Greys flag"
	desc = "A flag proudly proclaiming the superior heritage of Greys."
	icon_state = "greysflag"
	inhand_icon_state = "greysflag"

/obj/item/flag/kidan
	name = "\improper Kidan flag"
	desc = "A flag proudly proclaiming the superior heritage of Kidan."
	icon_state = "kidanflag"
	inhand_icon_state = "kidanflag"

/obj/item/flag/tajaran
	name = "\improper Tajaran flag"
	desc = "A flag proudly proclaiming the superior heritage of Tajaran."
	icon_state = "tajflag"
	inhand_icon_state = "tajflag"

/obj/item/flag/unathi
	name = "\improper Unathi flag"
	desc = "A flag proudly proclaiming the superior heritage of Unathi."
	icon_state = "unathiflag"
	inhand_icon_state = "unathiflag"

/obj/item/flag/vulp
	name = "\improper Vulpkanin flag"
	desc = "A flag proudly proclaiming the superior heritage of Vulpkanin."
	icon_state = "vulpflag"
	inhand_icon_state = "vulpflag"

/obj/item/flag/drask
	name = "\improper Drask flag"
	desc = "A flag proudly proclaiming the superior heritage of Drask."
	icon_state = "draskflag"
	inhand_icon_state = "draskflag"

/obj/item/flag/plasma
	name = "\improper Plasmaman flag"
	desc = "A flag proudly proclaiming the superior heritage of Plasmamen."
	icon_state = "plasmaflag"
	inhand_icon_state = "plasmaflag"

/obj/item/flag/nian
	name ="\improper Nian flag"
	desc = "An eccentric handmade standard, luxuriously soft due to exotic silks and embossed with lustrous gold. Although inspired by the pride that Nianae take in their baubles, it ultimately feels melancholic. Beauty knows no pain, afterall."
	icon_state = "nianflag"
	inhand_icon_state = "nianflag"

//Department Flags

/obj/item/flag/cargo
	name = "\improper Cargonia flag"
	desc = "The flag of the independent, sovereign nation of Cargonia."
	icon_state = "cargoflag"
	inhand_icon_state = "cargoflag"

/obj/item/flag/med
	name = "\improper Medistan flag"
	desc = "The flag of the independent, sovereign nation of Medistan."
	icon_state = "medflag"
	inhand_icon_state = "medflag"

/obj/item/flag/sec
	name = "\improper Brigston flag"
	desc = "The flag of the independent, sovereign nation of Brigston."
	icon_state = "secflag"
	inhand_icon_state = "secflag"

/obj/item/flag/rnd
	name = "\improper Scientopia flag"
	desc = "The flag of the independent, sovereign nation of Scientopia."
	icon_state = "rndflag"
	inhand_icon_state = "rndflag"

/obj/item/flag/atmos
	name = "\improper Atmosia flag"
	desc = "The flag of the independent, sovereign nation of Atmosia."
	icon_state = "atmosflag"
	inhand_icon_state = "atmosflag"

/obj/item/flag/command
	name = "\improper Command flag"
	desc = "The flag of the independent, sovereign nation of Command."
	icon_state = "ntflag"
	inhand_icon_state = "ntflag"

//Antags

/obj/item/flag/grey
	name = "\improper Greytide flag"
	desc = "A banner made from an old grey jumpsuit."
	icon_state = "greyflag"
	inhand_icon_state = "greyflag"

/obj/item/flag/syndi
	name = "\improper Syndicate flag"
	desc = "A flag proudly boasting the logo of the Syndicate, in defiance of NT."
	icon_state = "syndiflag"
	inhand_icon_state = "syndiflag"

/obj/item/flag/wiz
	name = "\improper Wizard Federation flag"
	desc = "A flag proudly boasting the logo of the Wizard Federation, sworn enemies of NT."
	icon_state = "wizflag"
	inhand_icon_state = "wizflag"

/obj/item/flag/cult
	name = "\improper Nar'Sie Cultist flag"
	desc = "A flag proudly boasting the logo of the cultists, sworn enemies of NT."
	icon_state = "cultflag"
	inhand_icon_state = "cultflag"

/obj/item/flag/ussp
	name = "\improper USSP flag"
	desc = "A flag proudly boasting the logo of the USSP, a noticeable faction in the galaxy."
	icon_state = "usspflag"
	inhand_icon_state = "usspflag"

/obj/item/flag/solgov
	name = "\improper Trans-Solar Federation flag"
	desc = "A flag proudly boasting the logo of the SolGov, allied to NT government originated from Earth."
	icon_state = "solgovflag"
	inhand_icon_state = "solgovflag"

/obj/item/flag/ninja
	name = "\improper Spider Clan flag"
	desc = "A flag proudly boasting the logo of the Spider Clan, a skillful ninjas of the universe."
	icon_state = "ninjaflag"
	inhand_icon_state = "ninjaflag"
/*
/obj/item/flag/chameleon
	name = "chameleon flag"
	desc = "A poor recreation of the official NT flag. It seems to shimmer a little."
	icon_state = "ntflag"
	inhand_icon_state = "ntflag"
	var/used = FALSE
	var/static/list/flag_types = list(
		"Нанотрейзен" = /obj/item/flag,
		"Саундхэнд" = /obj/item/flag/soundhand,
		"Атмосия" = /obj/item/flag/atmos,
	)

/obj/item/flag/chameleon/attack_self(mob/user, modifiers,)
	if(used)
		return
	var/choice = tgui_input_list(usr, "Выберите флаг", "Выбор флага", flag_types)
	if(!choice)
		return
	var/flag_to_set = flag_types[choice]
	if(!flag_to_set)
		return

	name = flag_to_set.name
	desc = flag_to_set.desc
	icon_state = flag_to_set.icon_state
	inhand_icon_state = flag_to_set.inhand_icon_state
	used = TRUE
	*/

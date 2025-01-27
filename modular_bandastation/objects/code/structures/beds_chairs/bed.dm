/obj/structure/bed/Initialize(mapload)
	. = ..()
	//2% шанс
	if(prob(2))
		name = "Boris"
		desc = "Really bed."

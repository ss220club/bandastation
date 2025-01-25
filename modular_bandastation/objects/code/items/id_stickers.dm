/obj/item/card/id/advanced
	var/obj/item/id_sticker/applied_sticker = null
	var/mutable_appearance/card_sticker

/obj/item/card/id/advanced/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(!istype(tool, /obj/item/id_sticker))
		return .

	if(applied_sticker)
		to_chat(user, span_warning("На ID карте уже есть наклейка, сначала снимите её!"))
		return

	to_chat(user, span_notice("Вы начинаете наносить наклейку на ID карту."))
	if(!do_after(user, 2 SECONDS, src, progress = TRUE))
		return
	apply_sticker(user, tool)

/obj/item/card/id/advanced/examine_more(mob/user)
	. = ..()
	if(applied_sticker)
		. += span_info("Вы можете снять наклейку, используя <b>Ctrl-Shift-Click</b>.")

/obj/item/card/id/advanced/click_ctrl_shift(mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_HANDS_BLOCKED))
		to_chat(user, span_warning("Ваши руки должны быть свободны, чтобы сделать это!"))
		return
	if(!applied_sticker)
		to_chat(user, span_warning("На ID карте нет наклейки!"))
		return
	if(user.combat_mode)
		to_chat(user, span_notice("Вы сдираете наклейку с ID карты!"))
		remove_sticker(user, delete = TRUE)
		return
	to_chat(user, span_notice("Вы начинаете пытаться снять наклейку с ID карты..."))
	if(do_after(user, 5 SECONDS, src, progress = TRUE))
		to_chat(user, span_notice("Вам удалось снять наклейку с ID карты."))
		remove_sticker(user, delete = FALSE)

/obj/item/card/id/advanced/proc/apply_sticker(mob/user, obj/item/id_sticker/sticker)
	card_sticker = mutable_appearance(sticker.icon, sticker.icon_state)
	card_sticker.color = sticker.color
	sticker.forceMove(src)
	applied_sticker = sticker
	desc += "<br>[sticker.info]"
	add_overlay(card_sticker)
	to_chat(user, span_notice("Вы наклеили [sticker.declent_ru(ACCUSATIVE)] на ID карту."))

/obj/item/card/id/advanced/proc/remove_sticker(mob/user, delete = FALSE)
	if(delete)
		qdel(applied_sticker)
	else
		if(isnull(user.get_active_held_item()))
			user.put_in_active_hand(applied_sticker)
		else
			applied_sticker.forceMove(get_turf(user))
	desc = src::desc
	applied_sticker = src::applied_sticker
	cut_overlay(card_sticker)

/obj/machinery/pdapainter/attackby(obj/item/O, mob/living/user, params)
	if(istype(O, /obj/item/card/id/advanced))
		var/obj/item/card/id/advanced/card = O
		if(card.applied_sticker)
			to_chat(user, span_warning("ID карта со стикером не может быть покрашена!"))
			return
	. = ..()

/obj/item/id_sticker
	name = "\improper ID sticker"
	desc = "Этим можно изменить внешний вид своей карты! Покажи службе безопасности какой ты стильный."
	icon = 'modular_bandastation/objects/icons/obj/items/id_stickers.dmi'
	icon_state = ""
	var/info = "Самая обыкновенная наклейка"

/obj/item/id_sticker/colored
	name = "\improper holographic ID sticker"
	desc = "Голографическая наклейка на карту. Вы можете выбрать цвет который она примет."
	icon_state = "colored"
	info = "На ней голо-наклейка."
	var/static/list/color_list = list(
		"Красный" = LIGHT_COLOR_INTENSE_RED,
		"Зелёный" = LIGHT_COLOR_GREEN,
		"Синий" = LIGHT_COLOR_CYAN,
		"Жёлтый" = LIGHT_COLOR_HOLY_MAGIC,
		"Оранжевый" = LIGHT_COLOR_ORANGE,
		"Фиолетовый" = LIGHT_COLOR_LAVENDER,
		"Голубой" = LIGHT_COLOR_LIGHT_CYAN,
		"Циановый" = LIGHT_COLOR_CYAN,
		"Аквамариновый" = LIGHT_COLOR_BLUEGREEN,
		"Розовый" = LIGHT_COLOR_PINK)

/obj/item/id_sticker/colored/Initialize(mapload)
	. = ..()
	if(color)
		return .

	color = color_list[pick(color_list)]

/obj/item/id_sticker/colored/attack_self(mob/living)
	var/choice = tgui_input_list(usr, "Какой цвет предпочитаете?", "Выбор цвета", list("Выбрать предустановленный", "Выбрать вручную"))
	if(!choice)
		return
	switch(choice)
		if("Выбрать предустановленный")
			choice = tgui_input_list(usr, "Выберите цвет", "Выбор цвета", color_list)
			var/color_to_set = color_list[choice]
			if(!color_to_set)
				return

			color = color_to_set

		if("Выбрать вручную")
			color = input(usr,"Выберите цвет") as color

/obj/item/id_sticker/donut
	name = "\improper donut ID sticker"
	icon_state = "donut"
	info = "На ней пончиковая наклейка. С глазурью!"

/obj/item/id_sticker/silver
	name = "\improper silver ID sticker"
	icon_state = "silver"
	info = "На ней серебрянная наклейка."

/obj/item/id_sticker/colored/silver
	name = "\improper silver holographic ID sticker"
	desc = "Голографическая наклейка на карту, изготовленная из специального материала, похожего на серебро. Вы можете выбрать цвет который она примет."
	icon_state = "colored_shiny"
	info = "На ней серебряная голо-наклейка."

/obj/item/id_sticker/gold
	name = "\improper gold ID sticker"
	desc = "Можно продать какому-то дураку за баснословные деньги. Ой..."
	icon_state = "gold"
	info = "На ней золотая наклейка."

/obj/item/id_sticker/business
	name = "\improper businessman ID sticker"
	desc = "Осталось раздобыть портмоне и стильный костюм."
	icon_state = "business"
	info = "На ней бизнесменская наклейка."

/obj/item/id_sticker/lifetime
	name = "\improper stylish ID sticker"
	desc = "Ничего особенного, но что-то в этом есть..."
	icon_state = "lifetime"
	info = "На ней стильная наклейка."

/obj/item/id_sticker/ussp
	name = "\improper communistic ID sticker"
	desc = "Партия гордится вами! Возьмите своя миска-рис в ближайшем баре."
	icon_state = "ussp"
	info = "На ней коммунистическая наклейка."

/obj/item/id_sticker/clown
	name = "\improper clownish ID sticker"
	desc = "HONK!"
	icon_state = "clown"
	info = "На ней клоунская наклейка. HONK!"

/obj/item/id_sticker/neon
	name = "\improper neon ID sticker"
	desc = "Неоновая наклейка в цианово-розовых цветах."
	icon_state = "neon"
	info = "Кажется будто она светится."

/obj/item/id_sticker/colored/neon
	name = "\improper neon holographic ID sticker"
	desc = "Какая же она яркая... Ещё и цвета меняет!"
	icon_state = "colored_neon"
	info = "Кажется будто она светится."

/obj/item/id_sticker/missing
	name = "\improper black-and-pink ID sticker"
	desc = "Текстура пропала..."
	icon_state = "missing"
	info = "А где?"

/obj/item/id_sticker/ouija
	name = "\improper Ouija ID sticker"
	desc = "Ходят легенты, что тот кто наклеит это на карту, может общаться с духами..."
	icon_state = "ouija"
	info = "Умеет ли он общаться с призраками?"

/obj/item/id_sticker/paradise
	name = "\improper beach ID sticker"
	desc = "Хола!"
	icon_state = "paradise"
	info = "На ней пляжная наклейка."

/obj/item/id_sticker/rainbow
	name = "\improper rainbow ID sticker"
	desc = "Переливается всеми цветами радуги!"
	icon_state = "rainbow"
	info = "На ней радужная наклейка. Одобряемо."

/obj/item/id_sticker/space
	name = "\improper SPACE ID sticker"
	desc = "Яркая, блестящая и бескрайняя. Прямо как хозяин карты на которую её приклеят."
	icon_state = "space"
	info = "Есть 3 вещи на которые можно смотреть вечно. Это четвёртая."

/obj/item/id_sticker/kitty
	name = "\improper cat ID sticker"
	desc = "Прекрасная наклейка, которая делает вашу карту похожей на котика. UwU."
	icon_state = "kitty"
	info = "Так и хочется погладить, жаль это всего-лишь наклейка..."

/obj/item/id_sticker/colored/kitty
	name = "\improper cat holographic ID sticker"
	desc = "Прекрасная наклейка, которая делает вашу карту похожей на котика. Эта может менять цвет."
	icon_state = "colored_kitty"
	info = "Так и хочется погладить, жаль это всего-лишь наклейка..."

/obj/item/id_sticker/cursedmiku
	name = "\improper anime ID sticker"
	desc = "Kawaii!!!"
	icon_state = "cursedmiku"
	info = "На ней анимешная наклейка. AYAYA!"

/obj/item/id_sticker/colored/snake
	name = "\improper running ID sticker"
	desc = "Она что-то загружает?"
	icon_state = "snake"
	info = "Бегает и бегает..."

/obj/item/id_sticker/magic
	name = "\improper magical ID sticker"
	desc = "EI NATH!"
	icon_state = "magic"
	info = "Кто-то до сих пор девственник..."

/obj/item/id_sticker/terminal
	name = "\improper terminal ID sticker"
	desc = "HACKERMAN."
	icon_state = "terminal"
	info = "Эта карта похожа на терминал."

/obj/item/id_sticker/jokerge
	name = "\improper jokerge ID sticker"
	desc = "Jokerge."
	icon_state = "jokerge"
	info = "Jokerge."

/obj/item/id_sticker/boykisser
	name = "\improper boykisser ID sticker"
	desc = "Наклеив её на карту, у вас с почти 100% вероятностью, появится желание целовать мальчиков."
	icon_state = "boykisser"
	info = "Он любит целовать мальчиков."

/datum/supply_pack/misc/id_stickers
	name = "ID stickers"
	desc = "test"
	crate_type = /obj/structure/closet/crate/wooden
	cost = CARGO_CRATE_VALUE * 18
	contains = list(/obj/effect/spawner/random/id_stickers = 5)
	crate_name = "ID stickers crate"

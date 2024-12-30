#define _COLOR_WHITE "#dddddd"
#define _COLOR_BLACK "#242424"
#define _COLOR_SAND "#c1ae7b"
#define _COLOR_VIOLET "#674ea7"
#define _COLOR_LIGHT_BLUE "#49aade"
#define _COLOR_PURPLE "#ad1845"
#define _COLOR_GOLD "#dfb02f"

#define COLORS_2(x, y) x + y
#define COLORS_3(x, y, z) x + y + z

/obj/item/clothing/under/carnival
	icon = 'modular_bandastation/objects/icons/obj/clothing/under/carnival.dmi'
	worn_icon = 'modular_bandastation/objects/icons/mob/clothing/under/carnival.dmi'

/obj/item/clothing/under/carnival/formal
	name = "formal suit"
	desc = "Костюм приятного качества из рубашки и брюк."
	icon_state = "formal"
	greyscale_config = /datum/greyscale_config/carnival_formal
	greyscale_config_worn = /datum/greyscale_config/carnival_formal/worn
	greyscale_colors = COLORS_2(_COLOR_BLACK, _COLOR_WHITE)

/obj/item/clothing/under/carnival/formal/black_purple
	greyscale_colors = COLORS_2(_COLOR_BLACK, _COLOR_PURPLE)

/obj/item/clothing/under/carnival/formal/sand_white
	greyscale_colors = COLORS_2(_COLOR_SAND, _COLOR_WHITE)

/obj/item/clothing/under/carnival/formal/white_lightblue
	greyscale_colors = COLORS_2(_COLOR_WHITE, _COLOR_LIGHT_BLUE)

/obj/item/clothing/under/carnival/jacket
	name = "jacket suit"
	desc = "Практичный костюм для торжественных вечеринок с жилетом."
	icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/carnival_jacket
	greyscale_config_worn = /datum/greyscale_config/carnival_jacket/worn
	greyscale_colors = COLORS_2(_COLOR_BLACK, _COLOR_WHITE)

/obj/item/clothing/under/carnival/jacket/black_purple
	greyscale_colors = COLORS_2(_COLOR_BLACK, _COLOR_PURPLE)

/obj/item/clothing/under/carnival/jacket/sand_white
	greyscale_colors = COLORS_2(_COLOR_SAND, _COLOR_WHITE)

/obj/item/clothing/under/carnival/jacket/white_lightblue
	greyscale_colors = COLORS_2(_COLOR_WHITE, _COLOR_LIGHT_BLUE)

/obj/item/clothing/under/carnival/dress_fancy
	name = "luxurious dress"
	desc = "Бальное платье, пошитое в викторианском стиле."
	icon_state = "dress_fancy"
	greyscale_config = /datum/greyscale_config/carnival_dress_fancy
	greyscale_config_worn = /datum/greyscale_config/carnival_dress_fancy/worn
	greyscale_colors = COLORS_3(_COLOR_BLACK, _COLOR_BLACK, _COLOR_WHITE)

/obj/item/clothing/under/carnival/dress_fancy/violet_gold
	greyscale_colors = COLORS_3(_COLOR_VIOLET, _COLOR_GOLD, _COLOR_GOLD)

/obj/item/clothing/under/carnival/dress_fancy/purple_black_white
	greyscale_colors = COLORS_3(_COLOR_PURPLE, _COLOR_BLACK, _COLOR_WHITE)

/obj/item/clothing/under/carnival/dress_fancy/lightblue_white
	greyscale_colors = COLORS_3(_COLOR_LIGHT_BLUE, _COLOR_WHITE, _COLOR_WHITE)

/obj/item/clothing/under/carnival/dress_corset
	name = "corset dress"
	desc = "Платье с корсетом, пошитое в викторианском стиле."
	icon_state = "dress_corset"
	greyscale_config = /datum/greyscale_config/carnival_dress_corset
	greyscale_config_worn = /datum/greyscale_config/carnival_dress_corset/worn
	greyscale_colors = COLORS_2(_COLOR_BLACK, _COLOR_WHITE)

/obj/item/clothing/under/carnival/dress_corset/violet_gold
	greyscale_colors = COLORS_2(_COLOR_VIOLET, _COLOR_GOLD)

/obj/item/clothing/under/carnival/dress_corset/purple_black
	greyscale_colors = COLORS_2(_COLOR_PURPLE, _COLOR_BLACK)

/obj/item/clothing/under/carnival/dress_corset/lightblue_white
	greyscale_colors = COLORS_2(_COLOR_LIGHT_BLUE, _COLOR_WHITE)

/obj/item/clothing/under/carnival/dress_mel
	name = "Wolf's dress"
	desc = "Платье, выполненное в особом стиле и пошитое неизвестной, но явно престижной компанией. \
		Скорее всего такой наряд могут позволить себе единицы ввиду ограниченного тиража."
	icon_state = "dress_mel"

/obj/item/clothing/under/carnival/silco
	name = "Industrialist's suit"
	desc = "Костюм, вышитый золотом. На бирке виднеется надпись - \"чтобы править - вселяй страх\"."
	icon_state = "silco"

/obj/item/clothing/under/carnival/kim
	name = "Kitsuragi's suit"
	desc = "Явно одежда какого-то полицейского..."
	icon_state = "kim"

#undef _COLOR_WHITE
#undef _COLOR_BLACK
#undef _COLOR_SAND
#undef _COLOR_VIOLET
#undef _COLOR_LIGHT_BLUE
#undef _COLOR_PURPLE
#undef _COLOR_GOLD

#undef COLORS_2
#undef COLORS_3

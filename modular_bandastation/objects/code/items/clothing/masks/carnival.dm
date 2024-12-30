#define _COLOR_WHITE "#dddddd"
#define _COLOR_BLACK "#242424"
#define _COLOR_VIOLET "#a64ea1"
#define _COLOR_BLUE "#3d8eba"
#define _COLOR_RUBY "#981724"
#define _COLOR_GOLD "#ffd700"
#define _COLOR_GREEN "#569546"
#define _COLOR_DARK_GREEN "#1e4e12"

#define COLORS_2(x, y) x + y
#define COLORS_3(x, y, z) x + y + z

/obj/item/clothing/mask/carnival
	name = "carnival mask"
	icon = 'modular_bandastation/objects/icons/obj/clothing/mask/carnival.dmi'
	worn_icon = 'modular_bandastation/objects/icons/mob/clothing/mask/carnival.dmi'
	flags_inv = HIDEFACE

/obj/item/clothing/mask/carnival/feather
	name = "Jester mask"
	desc = "Изысканная маска с перьями для карнавалов и маскарадов. Неотъемлемый спутник королей."
	icon_state = "feather"
	greyscale_config = /datum/greyscale_config/carnival_mask_feather
	greyscale_config_worn = /datum/greyscale_config/carnival_mask_feather/worn
	greyscale_colors = COLORS_3(_COLOR_RUBY, _COLOR_WHITE, _COLOR_GOLD)
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/carnival/feather/violet_blue
	greyscale_colors = COLORS_3(_COLOR_VIOLET, _COLOR_WHITE, _COLOR_BLUE)

/obj/item/clothing/mask/carnival/feather/green
	greyscale_colors = COLORS_3(_COLOR_DARK_GREEN, _COLOR_WHITE, _COLOR_GREEN)

/obj/item/clothing/mask/carnival/feather/red_black
	greyscale_colors = COLORS_3(_COLOR_WHITE, _COLOR_BLACK, _COLOR_RUBY)

/obj/item/clothing/mask/carnival/half
	name = "Colombina mask"
	desc = "Изысканная полумаска для карнавалов и маскарадов. Для тех, кто не склонен прятать красоту лица."
	icon_state = "half"
	greyscale_config = /datum/greyscale_config/carnival_mask_half
	greyscale_config_worn = /datum/greyscale_config/carnival_mask_half/worn
	greyscale_colors = COLORS_2(_COLOR_WHITE, _COLOR_GOLD)

/obj/item/clothing/mask/carnival/half/violet
	greyscale_colors = COLORS_2(_COLOR_WHITE, _COLOR_VIOLET)

/obj/item/clothing/mask/carnival/half/green
	greyscale_colors = COLORS_2(_COLOR_WHITE, _COLOR_GREEN)

/obj/item/clothing/mask/carnival/half/red_black
	greyscale_colors = COLORS_2(_COLOR_BLACK, _COLOR_RUBY)

/obj/item/clothing/mask/carnival/triangles
	name = "Harlequin mask"
	desc = "Изысканная маска с конусами и колокольчиками для карнавалов и маскарадов. Воплощение поединка с собой и со всем миром."
	icon_state = "triangles"
	greyscale_config = /datum/greyscale_config/carnival_mask_triangles
	greyscale_config_worn = /datum/greyscale_config/carnival_mask_triangles/worn
	greyscale_colors = COLORS_3(_COLOR_WHITE, _COLOR_GOLD, _COLOR_RUBY)

/obj/item/clothing/mask/carnival/triangles/blue_violet
	greyscale_colors = COLORS_3(_COLOR_WHITE, _COLOR_BLUE, _COLOR_VIOLET)

/obj/item/clothing/mask/carnival/triangles/green
	greyscale_colors = COLORS_3(_COLOR_WHITE, _COLOR_GREEN, _COLOR_DARK_GREEN)

/obj/item/clothing/mask/carnival/triangles/red_black
	greyscale_colors = COLORS_3(_COLOR_BLACK, _COLOR_RUBY, _COLOR_WHITE)

/obj/item/clothing/mask/carnival/colored
	name = "Volto mask"
	desc = "Изысканная маска для карнавалов и маскарадов, покрывающая все лицо. Дуализм души и тела."
	icon_state = "colored"
	greyscale_config = /datum/greyscale_config/carnival_mask_colored
	greyscale_config_worn = /datum/greyscale_config/carnival_mask_colored/worn
	greyscale_colors = COLORS_2(_COLOR_GOLD, _COLOR_WHITE)

/obj/item/clothing/mask/carnival/colored/violet
	greyscale_colors = COLORS_2(_COLOR_VIOLET, _COLOR_WHITE)

/obj/item/clothing/mask/carnival/colored/green
	greyscale_colors = COLORS_2(_COLOR_GREEN, _COLOR_WHITE)

/obj/item/clothing/mask/carnival/colored/red_black
	greyscale_colors = COLORS_2(_COLOR_RUBY, _COLOR_BLACK)

#undef _COLOR_WHITE
#undef _COLOR_BLACK
#undef _COLOR_VIOLET
#undef _COLOR_BLUE
#undef _COLOR_RUBY
#undef _COLOR_GOLD
#undef _COLOR_GREEN
#undef _COLOR_DARK_GREEN

#undef COLORS_2
#undef COLORS_3

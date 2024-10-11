
///////////////////////////////////////////////Condiments
//Notes by Darem: The condiments food-subtype is for stuff you don't actually eat but you use to modify existing food. They all
// leave empty containers when used up and can be filled/re-filled with other items. Formatting for first section is identical
// to mixed-drinks code. If you want an object that starts pre-loaded, you need to make it in addition to the other code.

//Food items that aren't eaten normally and leave an empty container behind.
/obj/item/reagent_containers/condiment
	name = "condiment bottle"
	desc = "Просто обычная бутылка со специями."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "bottle"
	inhand_icon_state = "beer" //Generic held-item sprite until unique ones are made.
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	reagent_flags = OPENCONTAINER
	obj_flags = UNIQUE_RENAME
	possible_transfer_amounts = list(1, 5, 10, 15, 20, 25, 30, 50)
	volume = 50
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 100)
	/// Icon (icon_state) to be used when container becomes empty (no change if falsy)
	var/icon_empty
	/// Holder for original icon_state value if it was overwritten by icon_emty to change back to
	var/icon_preempty

/obj/item/reagent_containers/condiment/update_icon_state()
	. = ..()
	if(reagents.reagent_list.len)
		if(icon_preempty)
			icon_state = icon_preempty
			icon_preempty = null
		return ..()

	if(icon_empty && !icon_preempty)
		icon_preempty = icon_state
		icon_state = icon_empty
	return ..()

/obj/item/reagent_containers/condiment/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[capitalize(user.declent_ru(NOMINATIVE))] пытается проглотить  [declent_ru(GENITIVE)] целиком! Похоже, [ru_p_they()] пытается совершить суицид!"))
	return OXYLOSS

/obj/item/reagent_containers/condiment/attack(mob/M, mob/user, def_zone)

	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("Внутри [declent_ru(GENITIVE)] пусто, о нет!"))
		return FALSE

	if(!canconsume(M, user))
		return FALSE

	if(M == user)
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] проглатывает немного содержимого [declent_ru(GENITIVE)]."), \
			span_notice("Вы проглотили немного содержимого [declent_ru(GENITIVE)]."))
	else
		M.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] пытается накормить [M.declent_ru(ACCUSATIVE)] c помощью [declent_ru(GENITIVE)]."), \
			span_warning("[capitalize(user.declent_ru(NOMINATIVE))] пытается накормить вас [declent_ru(INSTRUMENTAL)]."))
		if(!do_after(user, 3 SECONDS, M))
			return
		if(!reagents || !reagents.total_volume)
			return // The condiment might be empty after the delay.
		M.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] кормит [M.declent_ru(ACCUSATIVE)] с помощью[declent_ru(GENITIVE)]."), \
			span_warning("[capitalize(user.declent_ru(NOMINATIVE))] кормит вас [declent_ru(INSTRUMENTAL)]"))
		log_combat(user, M, "fed", reagents.get_reagent_log_string())
	reagents.trans_to(M, 10, transferred_by = user, methods = INGEST)
	playsound(M.loc,'sound/items/drink.ogg', rand(10,50), TRUE)
	return TRUE

/obj/item/reagent_containers/condiment/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(istype(target, /obj/structure/reagent_dispensers)) //A dispenser. Transfer FROM it TO us.
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("Внутри [target.declent_ru(GENITIVE)] пусто!"))
			return ITEM_INTERACT_BLOCKING

		if(reagents.total_volume >= reagents.maximum_volume)
			to_chat(user, span_warning("Внутри [declent_ru(GENITIVE)] нет места!"))
			return ITEM_INTERACT_BLOCKING

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user)
		to_chat(user, span_notice("[capitalize(declent_ru(NOMINATIVE))] наполняет [trans] [declension_ru(trans,"юнитом","юнитами","юнитами")] содержимое [target.declent_ru(GENITIVE)]."))
		return ITEM_INTERACT_SUCCESS

	//Something like a glass or a food item. Player probably wants to transfer TO it.
	else if(target.is_drainable() || IS_EDIBLE(target))
		if(!reagents.total_volume)
			to_chat(user, span_warning("В [target.declent_ru(GENITIVE)] пусто!"))
			return ITEM_INTERACT_BLOCKING
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("В [declent_ru(DATIVE)] нет места!"))
			return ITEM_INTERACT_BLOCKING
		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this, transferred_by = user)
		to_chat(user, span_notice("Содержимое [target.declent_ru(GENITIVE)] заполняется на [trans] [declension_ru(trans,"юнит","юнита","юнитов")]."))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/reagent_containers/condiment/enzyme
	name = "universal enzyme"
	desc = "Используется в приготовлении различных блюд."
	icon_state = "enzyme"
	list_reagents = list(/datum/reagent/consumable/enzyme = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/enzyme/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += span_notice("Требуется [milk_required] [declension_ru(milk_required,"юнит","юнита","юнитов")] молока, [enzyme_required] [declension_ru(enzyme_required,"юнит","юнита","юнитов")] энзима и вы получите сыр.")
	. += span_warning("Помните, что энзим лишь катализатор, не забудьте вернуть его в бутылку!")

/obj/item/reagent_containers/condiment/sugar
	name = "sugar sack"
	desc = "Сладкий космический сахар!"
	icon_state = "sugar"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/sugar = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/sugar/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter]
	var/flour_required = recipe.required_reagents[/datum/reagent/consumable/flour]
	var/eggyolk_required = recipe.required_reagents[/datum/reagent/consumable/eggyolk]
	var/sugar_required = recipe.required_reagents[/datum/reagent/consumable/sugar]
	. += span_notice("[flour_required] [declension_ru(flour_required,"юнит","юнита","юнитов")] муки, [eggyolk_required] [declension_ru(eggyolk_required,"яйцо","яйца","яиц")] или соевого молока, [sugar_required] [declension_ru(sugar_required,"юнит","юнита","юнитов")] сахара, чтобы сделать слоенное тесто. Вы даже можете сделать пирог из него!")

/obj/item/reagent_containers/condiment/saltshaker //Separate from above since it's a small shaker rather then
	name = "salt shaker" // a large one.
	desc = "Соль. Скорее всего из космического океана."
	icon_state = "saltshakersmall"
	icon_empty = "emptyshaker"
	inhand_icon_state = ""
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/salt = 20)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/saltshaker/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[capitalize(user.declent_ru(NOMINATIVE))] начинает поглощать содержимое солонки! Кажется, [user.ru_p_they()] пытается совершить самоубийство!"))
	var/newname = "[name]"
	name = "[user.declent_ru(NOMINATIVE)]"
	user.name = newname
	user.real_name = newname
	desc = "Соль. Скорее всего из мертвого члена экипажа."
	return TOXLOSS

/obj/item/reagent_containers/condiment/saltshaker/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(isturf(target))
		if(!reagents.has_reagent(/datum/reagent/consumable/salt, 2))
			to_chat(user, span_warning("У вас недостаточно соли, чтобы сделать горсть!"))
			return
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] наполняется солью [target.declent_ru(ACCUSATIVE)]."), span_notice("[capitalize(target.declent_ru(NOMINATIVE))] наполняется солью."))
		reagents.remove_reagent(/datum/reagent/consumable/salt, 2)
		new/obj/effect/decal/cleanable/food/salt(target)
		return ITEM_INTERACT_SUCCESS
	return .

/obj/item/reagent_containers/condiment/peppermill
	name = "pepper mill"
	desc = "Часто используется для придания особого вкуса. Или чтобы заставить людей чихать."
	icon_state = "peppermillsmall"
	icon_empty = "emptyshaker"
	inhand_icon_state = ""
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/blackpepper = 20)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/milk
	name = "space milk"
	desc = "Это молоко. Белое и питательное божество!"
	icon_state = "milk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/milk/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += span_notice("Требуется [milk_required] [declension_ru(milk_required,"юнит","юнита","юнитов")] молока, [enzyme_required] [declension_ru(enzyme_required,"юнит","юнита","юнитов")] энзима и вы получите сыр.")
	. += span_warning("Помните, что энзим лишь катализатор, поэтому верните его потом на место!")

/obj/item/reagent_containers/condiment/flour
	name = "flour sack"
	desc = "Крупная упаковка с мукой. Прекрасный выбор для выпечки!"
	icon_state = "flour"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/flour = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/flour/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe_dough = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/dough]
	var/datum/chemical_reaction/recipe_cakebatter = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter]
	var/dough_flour_required = recipe_dough.required_reagents[/datum/reagent/consumable/flour]
	var/dough_water_required = recipe_dough.required_reagents[/datum/reagent/water]
	var/cakebatter_flour_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/flour]
	var/cakebatter_eggyolk_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/eggyolk]
	var/cakebatter_sugar_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/sugar]
	. += "<b><i>Вы копаетесь в своих мыслях и вспоминаете рецепт... теста...</i></b>"
	. += span_notice("Требуется [dough_flour_required] [declension_ru(dough_flour_required,"юнит","юнита","юнитов")] муки, [dough_water_required] [declension_ru(dough_water_required,"юнит","юнита","юнитов")] воды подойдет для обычного кусочка теста. Его можно потом раскатать в плоскую лепешку.")
	. += span_notice("Нужно [cakebatter_flour_required] [declension_ru(cakebatter_flour_required,"юнит","юнита","юнитов")] муки, [cakebatter_eggyolk_required] [declension_ru(cakebatter_eggyolk_required,"юнит","юнита","юнитов")] яичного желтка (или соевого молока), [cakebatter_sugar_required] [declension_ru(cakebatter_sugar_required,"юнит","юнита","юнитов")] сахара, чтобы сделать слоенное тесто. Из него выйдет отличный пирог!")

/obj/item/reagent_containers/condiment/soymilk
	name = "soy milk"
	desc = "соя, божество прозрачное, но все еще питательное!"
	icon_state = "soymilk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/soymilk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/rice
	name = "rice sack"
	desc = "Крупная упаковка с рисом. Идеальна для приготовления блюд!"
	icon_state = "rice"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/rice = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/cornmeal
	name = "cornmeal box"
	desc = "Крупная коробка с кукрзной мукой. Отличный выбор для приготовления южных блюд."
	icon_state = "cornmeal"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/cornmeal = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/bbqsauce
	name = "bbq sauce"
	desc = "Салфетки не включены."
	icon_state = "bbqsauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 50)

/obj/item/reagent_containers/condiment/soysauce
	name = "soy sauce"
	desc = "Соленоватый соус на основе сои."
	icon_state = "soysauce"
	list_reagents = list(/datum/reagent/consumable/soysauce = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/mayonnaise
	name = "mayonnaise"
	desc = "Маслянистая приправа из яичного желтка."
	icon_state = "mayonnaise"
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/vinegar
	name = "vinegar"
	desc = "Превосходно подходит для чипсов. Если у вас специфичный вкус."
	icon_state = "vinegar"
	list_reagents = list(/datum/reagent/consumable/vinegar = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/vegetable_oil
	name = "cooking oil"
	desc = "Для особо глубокого фритюра."
	icon_state = "cooking_oil"
	list_reagents = list(/datum/reagent/consumable/nutriment/fat/oil = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/olive_oil
	name = "quality oil"
	desc = "Для утонченных шеф-поваров, что скрываются в каждом из нас."
	icon_state = "oliveoil"
	list_reagents = list(/datum/reagent/consumable/nutriment/fat/oil/olive = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/yoghurt
	name = "yoghurt carton"
	desc = "Кремовый и мягкий."
	icon_state = "yoghurt"
	list_reagents = list(/datum/reagent/consumable/yoghurt = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/peanut_butter
	name = "peanut butter"
	desc = "Вкусное, тянущееся масло в банке."
	icon_state = "peanutbutter"
	list_reagents = list(/datum/reagent/consumable/peanut_butter = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/cherryjelly
	name = "cherry jelly"
	desc = "Баночка с супер-сладким вишневым желе."
	icon_state = "cherryjelly"
	list_reagents = list(/datum/reagent/consumable/cherryjelly = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/honey
	name = "honey"
	desc = "Баночка приятного и тягучего меда."
	icon_state = "honey"
	list_reagents = list(/datum/reagent/consumable/honey = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/ketchup
	name = "ketchup"
	// At time of writing, "ketchup" mechanically, is just ground tomatoes,
	// rather than // tomatoes plus vinegar plus sugar.
	desc = "Выжатые томаты, что скрываются в пластиковой бутылке."
	icon_state = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/worcestershire
	name = "worcestershire sauce"
	desc = "Фермнтированный легендарный соус с Земли."
	icon_state = "worcestershire"
	list_reagents = list(/datum/reagent/consumable/worcestershire = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/red_bay
	name = "\improper Red Bay seasoning"
	desc = "Прямо с Марса!"
	icon_state = "red_bay"
	list_reagents = list(/datum/reagent/consumable/red_bay = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/curry_powder
	name = "curry powder"
	desc = "В нем заключена особая магия, что придает карри вкус карри."
	icon_state = "curry_powder"
	list_reagents = list(/datum/reagent/consumable/curry_powder = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/dashi_concentrate
	name = "dashi concentrate"
	desc = "Бутылка концентрата даси марки Amagi. Варите на медленном огне воду в соотношении 1:8, чтобы получить идеальный бульон даси."
	icon_state = "dashi_concentrate"
	list_reagents = list(/datum/reagent/consumable/dashi_concentrate = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/coconut_milk
	name = "coconut milk"
	desc = "Это кокосовое молоко. Потрясно!"
	icon_state = "coconut_milk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/coconut_milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/grounding_solution
	name = "grounding solution"
	desc = "Безопасный для пищевых продуктов ионный раствор, предназначенный для нейтрализации загадочного «жидкого электричества», свойственного продуктам Sprout, образуя при контакте безвредную соль."
	icon_state = "grounding_solution"
	list_reagents = list(/datum/reagent/consumable/grounding_solution = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/protein
	name = "protein powder"
	desc = "Fuel for your inner Hulk - because you can't spell 'swole' without 'whey'!"
	icon_state = "protein"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 40)
	fill_icon_thresholds = null

//technically condiment packs but they are non transparent

/obj/item/reagent_containers/condiment/creamer
	name = "coffee creamer pack"
	desc = "Лучше не думать о том, из чего это сделано."
	icon_state = "condi_creamer"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/creamer = 5)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/chocolate
	name = "chocolate sprinkle pack"
	desc= "Вам недостаточно сахара, который уже там есть?"
	icon_state = "condi_chocolate"
	list_reagents = list(/datum/reagent/consumable/choccyshake = 10)

/obj/item/reagent_containers/condiment/hotsauce
	name = "hotsauce bottle"
	desc= "Вы можете чувствовать язву!"
	icon_state = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 50)

/obj/item/reagent_containers/condiment/coldsauce
	name = "coldsauce bottle"
	desc= "Оставляет язык онемевшим после пробы."
	icon_state = "coldsauce"
	list_reagents = list(/datum/reagent/consumable/frostoil = 50)

//Food packs. To easily apply deadly toxi... delicious sauces to your food!

/obj/item/reagent_containers/condiment/pack
	name = "condiment pack"
	desc = "Небольшой пластиковый пакет с приправами для вашей еды."
	icon_state = "condi_empty"
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(10)
	/**
	  * List of possible styles (list(<icon_state>, <name>, <desc>)) for condiment packs.
	  * Since all of them differs only in color should probably be replaced with usual reagentfillings instead
	  */
	var/list/possible_states = list(
		/datum/reagent/consumable/ketchup = list("condi_ketchup", "Кетчуп", "Вы уже чувствуете себя более космическим."),
		/datum/reagent/consumable/capsaicin = list("condi_hotsauce", "Острый соус", "Теперь вы почти можете ПОПРОБОВАТЬ язвы желудка!"),
		/datum/reagent/consumable/soysauce = list("condi_soysauce", "Соевый соус", "Соленая приправа на основе сои."),
		/datum/reagent/consumable/frostoil = list("condi_frostoil", "Холодный соус", "Оставляет язык онемевшим при еде."),
		/datum/reagent/consumable/salt = list("condi_salt", "Солонка", "Соль. Вероятно, из космических океанов."),
		/datum/reagent/consumable/blackpepper = list("condi_pepper", "Перечница", "Часто используется для придания вкуса пище или чтобы заставить людей чихать."),
		/datum/reagent/consumable/nutriment/fat/oil = list("condi_cornoil", "Растительное масло", "Вкусное масло, используемое в кулинарии."),
		/datum/reagent/consumable/sugar = list("condi_sugar", "Сахар", "Вкусный космический сахар!"),
		/datum/reagent/consumable/astrotame = list("condi_astrotame", "Астротейм", "Сладость тысячи сахаров, но без калорий."),
		/datum/reagent/consumable/bbqsauce = list("condi_bbq", "BBQ соус", "Салфетки не включены."),
		/datum/reagent/consumable/peanut_butter = list("condi_peanutbutter", "Арахисовое масло", "Кремовая паста из молотого арахиса."),
		/datum/reagent/consumable/cherryjelly = list("condi_cherryjelly", "Вишневое желе", "Банка сверхсладкого вишневого желе."),
		/datum/reagent/consumable/mayonnaise = list("condi_mayo", "Майонез", "Не является инструментом."),
	)
	/// Can't use initial(name) for this. This stores the name set by condimasters.
	var/originalname = "condiment"

/obj/item/reagent_containers/condiment/pack/create_reagents(max_vol, flags)
	. = ..()
	RegisterSignals(reagents, list(COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_REM_REAGENT), PROC_REF(on_reagent_add), TRUE)
	RegisterSignal(reagents, COMSIG_REAGENTS_DEL_REAGENT, PROC_REF(on_reagent_del), TRUE)

/obj/item/reagent_containers/condiment/pack/update_icon()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/item/reagent_containers/condiment/pack/attack(mob/M, mob/user, def_zone) //Can't feed these to people directly.
	return

/obj/item/reagent_containers/condiment/pack/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	//Пакет можно разорвать над едой, чтобы добавить приправы.
	if(IS_EDIBLE(target))
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src.name] открыли, но внутри пусто."))
			qdel(src)
			return ITEM_INTERACT_BLOCKING
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("[src.name] вскрыли, но [target.name] уже не вмещает больше, и все просто стекает!"))
			qdel(src)
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("[src.name] открыли, и [target.name] наполняется."))
		src.reagents.trans_to(target, amount_per_transfer_from_this, transferred_by = user)
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	return ..()

/// Handles reagents getting added to the condiment pack.
/obj/item/reagent_containers/condiment/pack/proc/on_reagent_add(datum/reagents/reagents)
	SIGNAL_HANDLER

	var/datum/reagent/main_reagent = reagents.get_master_reagent()

	var/main_reagent_type = main_reagent?.type
	if(main_reagent_type in possible_states)
		var/list/temp_list = possible_states[main_reagent_type]
		icon_state = temp_list[1]
		desc = temp_list[3]
	else
		icon_state = "condi_mixed"
		desc = "Небольшой пакетик с приправами. На этикетке написано, что внутри [originalname]"

/// Handles reagents getting removed from the condiment pack.
/obj/item/reagent_containers/condiment/pack/proc/on_reagent_del(datum/reagents/reagents)
	SIGNAL_HANDLER
	icon_state = "condi_empty"
	desc = "Небольшой пакетик с приправами и он пуст."

//Ketchup
/obj/item/reagent_containers/condiment/pack/ketchup
	name = "ketchup pack"
	originalname = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 10)

//Hot sauce
/obj/item/reagent_containers/condiment/pack/hotsauce
	name = "hotsauce pack"
	originalname = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 10)

/obj/item/reagent_containers/condiment/pack/astrotame
	name = "astrotame pack"
	originalname = "astrotame"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/astrotame = 5)

/obj/item/reagent_containers/condiment/pack/bbqsauce
	name = "bbq sauce pack"
	originalname = "bbq sauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 10)

/obj/item/reagent_containers/condiment/pack/creamer
	name = "creamer pack"
	originalname = "creamer"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/cream = 5)

/obj/item/reagent_containers/condiment/pack/sugar
	name = "sugar pack"
	originalname = "sugar"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/sugar = 5)

/obj/item/reagent_containers/condiment/pack/soysauce
	name = "soy sauce pack"
	originalname = "soy sauce"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/soysauce = 5)

/obj/item/reagent_containers/condiment/pack/mayonnaise
	name = "mayonnaise pack"
	originalname = "mayonnaise"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 5)

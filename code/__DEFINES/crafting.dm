///If the machine is used/deleted in the crafting process
#define CRAFTING_MACHINERY_CONSUME 1
///If the structure is used/deleted in the crafting process
#define CRAFTING_STRUCTURE_CONSUME 1
///If the machine is only "used" i.e. it checks to see if it's nearby and allows crafting, but doesn't delete it
#define CRAFTING_MACHINERY_USE 0
///If the structure is only "used" i.e. it checks to see if it's nearby and allows crafting, but doesn't delete it
#define CRAFTING_STRUCTURE_USE 0

//stack recipe placement check types
/// Checks if there is an object of the result type in any of the cardinal directions
#define STACK_CHECK_CARDINALS (1<<0)
/// Checks if there is an object of the result type within one tile
#define STACK_CHECK_ADJACENT (1<<1)

//---- Defines for var/crafting_flags
///If this craft must be learned before it becomes available
#define CRAFT_MUST_BE_LEARNED (1<<0)
///Should only one object exist on the same turf?
#define CRAFT_ONE_PER_TURF (1<<1)
/// Setting this to true will effectively set check_direction to true.
#define CRAFT_IS_FULLTILE (1<<2)
/// If this craft should run the direction check, for use when building things like directional windows where you can have more than one per turf
#define CRAFT_CHECK_DIRECTION (1<<3)
/// If the craft requires a floor below
#define CRAFT_ON_SOLID_GROUND (1<<4)
/// If the craft checks that there are objects with density in the same turf when being built
#define CRAFT_CHECK_DENSITY (1<<5)
/// If the created atom will gain custom mat datums
#define CRAFT_APPLIES_MATS (1<<6)

//food/drink crafting defines
//When adding new defines, please make sure to also add them to the encompassing list
#define CAT_FOOD "Еда"
#define CAT_BREAD "Хлебобулочное"
#define CAT_BURGER "Бургеры"
#define CAT_CAKE "Торты"
#define CAT_EGG "Яица"
#define CAT_LIZARD "Ящерское"
#define CAT_MEAT "Мясное"
#define CAT_SEAFOOD "Морепродукты"
#define CAT_MARTIAN "Марсианское"
#define CAT_MISCFOOD "Прочее"
#define CAT_MEXICAN "Мексиканское"
#define CAT_MOTH "Молиное"
#define CAT_PASTRY "Кондитерское"
#define CAT_PIE "Пироги"
#define CAT_PIZZA "Пиццы"
#define CAT_SALAD "Салаты"
#define CAT_SANDWICH "Сэндвичи"
#define CAT_SOUP "Супы"
#define CAT_SPAGHETTI "Спагетти"
#define CAT_ICE "Замороженные"
#define CAT_DRINK "Напитки"

//crafting defines
//When adding new defines, please make sure to also add them to the encompassing list
#define CAT_WEAPON_RANGED "Оружие: дальнобойное"
#define CAT_WEAPON_MELEE "Оружие: холодное"
#define CAT_WEAPON_AMMO "Оружие: патроны"
#define CAT_ROBOT "Робототехника"
#define CAT_MISC "Прочее"
#define CAT_CLOTHING "Одежда"
#define CAT_CHEMISTRY "Химия"
#define CAT_ATMOSPHERIC "Атмосферика"
#define CAT_STRUCTURE "Структуры"
#define CAT_TILES "Полы"
#define CAT_WINDOWS "Окна"
#define CAT_DOORS "Двери"
#define CAT_FURNITURE "Мебель"
#define CAT_EQUIPMENT "Снаряжение"
#define CAT_CONTAINERS "Контейнеры"
#define CAT_ENTERTAINMENT "Развлечение"
#define CAT_TOOLS "Инструменты"
#define CAT_CULT "Кровавый культ"


// Clown Operative Stuff
// Maybe someday, someone will care to maintain this

/datum/uplink_item/weapon_kits/pie_cannon
	name = "Banana Cream Pie Cannon"
	desc = "Специальная пушка стреляющая пирогами для особого клоуна, этот гаджет может вмещать до 20 пирогов и автоматически изготавливать их раз в две секунды!"
	cost = 10
	item = /obj/item/pneumatic_cannon/pie/selfcharge
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/bananashield
	name = "Bananium Energy Shield"
	desc = "Самое мощное защитное оружие клоуна, этот личный щит обеспечивает почти полную защиту от энергетических атак,\
		отражая их обратно в стреляющего. Его также можно бросить в людей, отскочив от них он сбивает их с ног \
		и возвращается к вам в случае промаха. ВНИМАНИЕ: НЕ ПЫТАЙТЕСЬ ВСТАТЬ НА ЩИТ ПОКА ОН РАЗВЁРНУТ, ДАЖЕ ЕСЛИ НОСИТЕ ПРОТИВОСКОЛЬЗЯЩИЕ БОТИНКИ."
	item = /obj/item/shield/energy/bananium
	cost = 16
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/clownsword
	name = "Bananium Energy Sword"
	desc = "Энергетический меч, который не наносит урона, но заставляет поскользнуться любого контактирующего с ним, будь то атака ближнего боя, \
		бросок в кого нибудь или наступившего на него. Остерегайтесь огня по своим, так как противоскользящая обувь не защищает от него."
	item = /obj/item/melee/energy/sword/bananium
	cost = 3
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/clownoppin
	name = "Ultra Hilarious Firing Pin"
	desc = "Огеновой штифт, когда установлен в оружие делает его пригодным для использования клоунами и неуклюжими людьми. Оружие начинает издавать хонк, когда кто-то пытается выстрелить из него."
	cost = 1 //much cheaper for clown ops than for clowns
	item = /obj/item/firing_pin/clown/ultra
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE

/datum/uplink_item/weapon_kits/clownopsuperpin
	name = "Super Ultra Hilarious Firing Pin"
	desc = "Схож с ultra hilarious firing pin, за исключением того, что когда вставлен в оружие взрывается если кто-то кроме клоунов или неуклюжих людей пытается выстрелить из него."
	cost = 4 //much cheaper for clown ops than for clowns
	item = /obj/item/firing_pin/clown/ultra/selfdestruct
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE

/datum/uplink_item/weapon_kits/foamsmg
	name = "Toy Submachine Gun"
	desc = "Полностью заряженный пистолет-пулемёт булл-пап \"Donksoft\", который стреляет дротиками класса подавления беспорядков оснащён 20-ти зарядным магазином."
	item = /obj/item/gun/ballistic/automatic/c20r/toy
	cost = 5
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/weapon_kits/foammachinegun
	name = "Toy Machine Gun"
	desc = "Полностью заряженный пулемёт \"Donksoft\". Это оружие имеет огромный 50-ти зарядный магазин \
		дротиков класса подавления беспорядков, которые могут ненадолго вырубить человека за один залп."
	item = /obj/item/gun/ballistic/automatic/l6_saw/toy
	cost = 10
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/bombanana
	name = "Bombanana"
	desc = "Банан с взрывным вкусом! Бытсро снимите и выбросьте кожурку, ведь она взорвется как мини бомба Синдиката \
		через несколько секунд после того, как банан был съеден."
	item = /obj/item/food/grown/banana/bombanana
	cost = 4 //it is a bit cheaper than a minibomb because you have to take off your helmet to eat it, which is how you arm it
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/clown_bomb_clownops
	name = "Clown Bomb"
	desc = "Бомба клоуна — это забавное устройство способное на масштабные шалости. Оснащена регулируемым таймером, \
		с минимальным временем %MIN_BOMB_TIMER секунд. Может быть прикручена к полу гаечным ключом для предотвращения \
		её передвижения. Бомба громоздкая и не может быть перемещена; при заказе этого предмета, доставляет к вам маленький маяк, \
		при активации телепортирует настоящую бомбу. Учтите, что эту бомбу могут \
		обезвредить, и некоторые члены экипажа могут попытаться это сделать."
	item = /obj/item/sbeacondrop/clownbomb
	cost = 15
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/clown_bomb_clownops/New()
	. = ..()
	desc = replacetext(desc, "%MIN_BOMB_TIMER", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/explosives/tearstache
	name = "Teachstache Grenade"
	desc = "Слезоточивая граната, которая запускает липкие усы на лицо любого, кто не носит маску клоуна или мима. Усы \
		остаются на лице всех в течении одной минуты, мешая использовать дыхательную маску и другие подобные устройства."
	item = /obj/item/grenade/chem_grenade/teargas/moustache
	cost = 3
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_SPY

/datum/uplink_item/explosives/pinata
	name = "Weapons Grade Pinata Kit"
	desc = "Пиньята наполненная конфетами и взрывчаткой, а также два пояса, чтобы носить их, разбейте её и посмотрите, что вы получите!"
	item = /obj/item/storage/box/syndie_kit/pinata
	purchasable_from = UPLINK_CLOWN_OPS
	limited_stock = 1
	cost = 12 //This is effectively the clown ops version of the grenadier belt where you should on average get 8 explosives if you use a weapon with exactly 10 force.
	surplus = 0

/datum/uplink_item/reinforcement/clown_reinforcement
	name = "Clown Reinforcements"
	desc = "Вызовите дополнительного клоуна, чтобы разделить веселье с ним он оснащён стартовым снаряжением, но не телекристаллыми."
	item = /obj/item/antag_spawner/nuke_ops/clown
	cost = 20
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/reinforcement/monkey_agent
	name = "Simian Agent Reinforcements"
	desc = "Вызовите чрезвычайно хорошо обученного секретного агента обезьяну из нашего отдела бананов Синдиката. \
		Она обучена, чтобы работать с механизмами и умеет читать, но не может говорить на общем."
	item = /obj/item/antag_spawner/loadout/monkey_man
	cost = 7
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/reinforcement/monkey_supplies
	name = "Simian Agent Supplies"
	desc = "Иногда вам нужно немного больше огневой мощи, чем простая бешеная обезьяна. Например, бешеная, вооруженная обезьяна! \
		Обезьяны могут распаковать этот набор, чтобы получить \"bargain-bin\", патроны и некоторые дополнительные принадлежности."
	item = /obj/item/storage/toolbox/guncase/monkeycase
	cost = 4
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/mech/honker
	name = "Dark H.O.N.K."
	desc = "Клоунский боевой мех, оснащенный кожурой бомбобанана и слезоточивым гранатомётом, а также вездесущим ХоНкЕР БлАсТОм 5000."
	item = /obj/vehicle/sealed/mecha/honker/dark/loaded
	cost = 80
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/stealthy_tools/combatbananashoes
	name = "Combat Banana Shoes"
	desc = "Делают обладателя невосприимчивым к большинству подскальзывающим атакам, как обычные боевые клоунские ботинки. Эти ботинки \
		могут генерировать огромное количество синтетических банановых кожурок пока владелец ходит, подскальзывая потенциальных преследователей. Они также \
		пищат гораздо громче."
	item = /obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	cost = 6
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/badass/clownopclumsinessinjector //clowns can buy this too, but it's in the role-restricted items section for them
	name = "Clumsiness Injector"
	desc = "Вколите себе, чтобы стать таким же неуклюжим как клоун... или вколите кому-нибудь ДРУГОМУ, чтобы сделать ЕГО таким же неуклюжим как клоун. Полезен для клоунов оперативников, которые хотят воссоединиться со своей прежней клоунской природой или клоунам оперативникам, которые хотят помучить и поиграть со своей добычей перед тем как убить её."
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE

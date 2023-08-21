// TODO: Remove those global lists...... They are used for loop cache spawns

// FLAGS

// SIDORMAT
/// Should sidormat show all faction equipment even if you don't belong to it?
#define SHOW_FACTION_EQUIPMENT (1<<0)
/// Should you be able to sell loot at sidormat?
#define BUY_STUFF (1<<1)
/// Should you be able to buy "Unbuyable" stuff, that's only meant to be sold to sidormat as loot?
#define SELL_UNBUYABLE (1<<2)


// Other defines

/// Item cost tiers

#define TRASH_TIER_COST 4000
#define LOW_TIER_COST 9000
#define MEDIUM_TIER_COST 36000
#define HIGH_TIER_COST 72000


// GLOBAL LISTS

GLOBAL_LIST_EMPTY(trash_tier_sidormat_items)
GLOBAL_LIST_EMPTY(low_tier_sidormat_items)
GLOBAL_LIST_EMPTY(medium_tier_sidormat_items)
GLOBAL_LIST_EMPTY(high_tier_sidormat_items)
GLOBAL_LIST_EMPTY(real_sidormat_items)

GLOBAL_LIST_INIT(global_sidormat_list, list(
		///////////////////////////////  Weapons  /////////////////////////////////////////
	/*"Handguns" = list(
		///////////////////////////// **Pistols, SMGs** /////////////////////////////////////
		new /datum/data/stalker_equipment("PMm", /obj/item/gun/ballistic/automatic/pistol/pm, 3000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("TT", /obj/item/gun/ballistic/automatic/pistol/tt, 3000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Fort-12", /obj/item/gun/ballistic/automatic/pistol/fort12, 6500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("PB1s", /obj/item/gun/ballistic/automatic/pistol/pb1s, 4500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("SIG-Sauer P220", /obj/item/gun/ballistic/automatic/pistol/sip, 12500, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Colt M1911", /obj/item/gun/ballistic/automatic/pistol/cora, 9000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Beretta 92FS", /obj/item/gun/ballistic/automatic/pistol/marta, 9000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("USP-match", /obj/item/gun/ballistic/automatic/pistol/usp_match, 16000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Colt Anaconda", /obj/item/gun/ballistic/revolver/anaconda, 25000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Desert Eagle", /obj/item/gun/ballistic/automatic/pistol/desert, 30000, RANK_EXPERIENCED),
		),


	"Submachine Guns" = list(
		new /datum/data/stalker_equipment("Beretta M38", /obj/item/gun/ballistic/automatic/berettam38, 10000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Kiparis", /obj/item/gun/ballistic/automatic/kiparis, 12000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("PPSh", /obj/item/gun/ballistic/automatic/ppsh, 15000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("MP-5", /obj/item/gun/ballistic/automatic/mp5, 18000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("MAC10 Ingram", /obj/item/gun/ballistic/automatic/mac10, 24000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("FN P90", /obj/item/gun/ballistic/automatic/p90, 38000, RANK_ROOKIE, faction = FACTION_MERC),
		),


	"Automatic Weapons" = list(
		///////////////////////////// **ARs** /////////////////////////////////////
		new /datum/data/stalker_equipment("SKS", /obj/item/gun/ballistic/rifle/semiautobolt/sks, 20000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("AK-74S", /obj/item/gun/ballistic/automatic/aksu74 , 24000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("AK-74", /obj/item/gun/ballistic/automatic/ak74, 30000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("AKM", /obj/item/gun/ballistic/automatic/akm, 30400, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("AS-96", /obj/item/gun/ballistic/automatic/abakan, 40000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("LR-300", /obj/item/gun/ballistic/automatic/tpc301, 40000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("L85", /obj/item/gun/ballistic/automatic/il86, 40000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Tunder OTs-14", /obj/item/gun/ballistic/automatic/groza, 35000, RANK_VETERAN),
		new /datum/data/stalker_equipment("AS \"Val\"", /obj/item/gun/ballistic/automatic/val, 50000, RANK_VETERAN),
		new /datum/data/stalker_equipment("SIG SG 550", /obj/item/gun/ballistic/automatic/sigsg550, 50000, RANK_VETERAN),
		new /datum/data/stalker_equipment("FN F2000", /obj/item/gun/ballistic/automatic/fnf2000, 65000, RANK_EXPERT),
		new /datum/data/stalker_equipment("GP 37", /obj/item/gun/ballistic/automatic/gp37, 75000, RANK_EXPERT),
		new /datum/data/stalker_equipment("FN FAL", /obj/item/gun/ballistic/automatic/fnfal, 85000, RANK_EXPERT),
		new /datum/data/stalker_equipment("FN FAL Wood Stock", /obj/item/gun/ballistic/automatic/woodfnfal, 85000, RANK_EXPERT),
		new /datum/data/stalker_equipment("FN F2000S", /obj/item/gun/ballistic/automatic/fnf2000s, 100000, RANK_EXPERT, faction = FACTION_MERC)
		//new /datum/data/stalker_equipment("PKM", /obj/item/gun/ballistic/automatic/l6_saw/pkm, 600000, RANK_EXPERT)
		),


	"Shotguns" = list(
		/////////////////////////////// **Shotguns** /////////////////////////////////////
		new /datum/data/stalker_equipment("Sawn off", /obj/item/gun/ballistic/shotgun/bm16/sawnoff, 6000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("BM-16", /obj/item/gun/ballistic/shotgun/bm16, 10000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("TOZ-34", /obj/item/gun/ballistic/shotgun/bm16/toz34, 15000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Ithaca M37", /obj/item/gun/ballistic/shotgun/ithaca, 20000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Wincheaster-1300", /obj/item/gun/ballistic/shotgun/chaser, 30000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("SPAS-12", /obj/item/gun/ballistic/shotgun/spsa, 50000, RANK_VETERAN)
		),


	"Rifles" = list(
		/////////////////////////////// **Rifles** /////////////////////////////////////
		new /datum/data/stalker_equipment("Mosin-Nagant obrez", /obj/item/gun/ballistic/rifle/boltaction/mosinobrez, 14000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Mosin-Nagant", /obj/item/gun/ballistic/rifle/boltaction/mosin, 15000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Lee Enfield", /obj/item/gun/ballistic/rifle/boltaction/enfield, 15000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Vintorez", /obj/item/gun/ballistic/automatic/vintorez, 60000, RANK_EXPERT),
		new /datum/data/stalker_equipment("SVD", /obj/item/gun/ballistic/semiauto/svd, 75000, RANK_EXPERT),
		new /datum/data/stalker_equipment("AWSM", /obj/item/gun/ballistic/awm, 80000, RANK_ROOKIE, faction = FACTION_MERC)
		),


	"Melee Weapons" = list(
		/////////////////////////////// **Melee** /////////////////////////////////////
		new /datum/data/stalker_equipment("Kitchen Knife", /obj/item/kitchen/knife, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Tourist Knife", /obj/item/kitchen/knife/tourist, 4000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Bayonet", /obj/item/kitchen/knife/bayonet, 7000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Butcher's Cleaver", /obj/item/kitchen/knife/butcher, 10000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Hunting Knife", /obj/item/weapon/kitchen/knife/hunting, 15000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("M9 Bayonet", /obj/item/weapon/kitchen/knife/m9, 25000, RANK_ROOKIE)
		),


	"Ammo Boxes" = list(
		////////////////////////////////  Ammo  /////////////////////////////////////////
		new /datum/data/stalker_equipment("9x18mm Box", /obj/item/ammo_box/stalker/b9x18, 2500, RANK_ROOKIE, sale_price =300),
		new /datum/data/stalker_equipment("9x18mm AP Box", /obj/item/ammo_box/stalker/b9x18P, 3500, RANK_EXPERIENCED, sale_price =350),
		new /datum/data/stalker_equipment("7.62x25mm Box", /obj/item/ammo_box/stalker/b762x25, 2500, RANK_ROOKIE, sale_price =400),
		new /datum/data/stalker_equipment("9x19mm Box", /obj/item/ammo_box/stalker/b9x19, 3500, RANK_ROOKIE, sale_price =450),
		new /datum/data/stalker_equipment("9x19mm AP Box", /obj/item/ammo_box/stalker/b9x19P, 5750, RANK_EXPERIENCED, sale_price =500),
		new /datum/data/stalker_equipment("5.7×28mm Box", /obj/item/ammo_box/stalker/b5728, 16000, RANK_ROOKIE, sale_price =550),
		new /datum/data/stalker_equipment(".45 ACP Box", /obj/item/ammo_box/stalker/bacp45, 8000, RANK_ROOKIE, sale_price =550),
		new /datum/data/stalker_equipment(".45 ACP Hydroshock Box", /obj/item/ammo_box/stalker/bacp45ap, 15000, RANK_EXPERIENCED, sale_price =600),
		new /datum/data/stalker_equipment(".44 Magnum Box", /obj/item/ammo_box/stalker/bmag44, 14000, RANK_EXPERIENCED, sale_price =650),
		new /datum/data/stalker_equipment(".44 Magnum FMJ Box", /obj/item/ammo_box/stalker/bmag44fmj, 15000, RANK_EXPERIENCED, sale_price =700),
		new /datum/data/stalker_equipment("12x70 Buckshot Box", /obj/item/ammo_box/stalker/b12x70, 8000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("12x70 Slug Box", /obj/item/ammo_box/stalker/b12x70P, 9500, RANK_EXPERIENCED, sale_price =550),
		new /datum/data/stalker_equipment("12x70 Dart Box", /obj/item/ammo_box/stalker/b12x70D, 7000, RANK_EXPERIENCED, sale_price =600),
		new /datum/data/stalker_equipment("5.45x39mm Box", /obj/item/ammo_box/stalker/b545, 10000, RANK_ROOKIE, sale_price =650),
		new /datum/data/stalker_equipment("5.45x39mm AP Box", /obj/item/ammo_box/stalker/b545ap, 15000, RANK_VETERAN, sale_price =700),
		new /datum/data/stalker_equipment("7.62x39mm Box", /obj/item/ammo_box/stalker/b762x39, 10000, RANK_ROOKIE, sale_price =650),
		new /datum/data/stalker_equipment("7.62x39mm AP Box", /obj/item/ammo_box/stalker/b762x39ap, 15000, RANK_VETERAN, sale_price =700),
		new /datum/data/stalker_equipment("5.56x45mm Box", /obj/item/ammo_box/stalker/b55645, 12000, RANK_ROOKIE, sale_price =680),
		new /datum/data/stalker_equipment("5.56x45mm AP Box", /obj/item/ammo_box/stalker/b55645ap, 20000, RANK_VETERAN, sale_price =720),
		new /datum/data/stalker_equipment("7.62x51 Box", /obj/item/ammo_box/stalker/b762x51, 10000, RANK_ROOKIE, sale_price =480),
		new /datum/data/stalker_equipment("7.62x54mmR Box", /obj/item/ammo_box/stalker/b762x54r, 12000, RANK_ROOKIE, sale_price =480),
		new /datum/data/stalker_equipment("9x39 PAB-9 Box", /obj/item/ammo_box/stalker/b939, 30000, RANK_EXPERIENCED, sale_price =700),
		new /datum/data/stalker_equipment(".338 Lapua Magnum Box", /obj/item/ammo_box/stalker/b338, 60000, RANK_ROOKIE, sale_price =700, faction = FACTION_MERC),
		),


	"Ammo Magazines and Clips" = list(
		new /datum/data/stalker_equipment("PMm; PB1s Magazine", /obj/item/ammo_box/magazine/stalker/m9x18pm, 1000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("TT Magazine", /obj/item/ammo_box/magazine/stalker/tt, 1000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("Fort-12 Magazine", /obj/item/ammo_box/magazine/stalker/m9x18fort, 2000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("Kiparis Magazine", /obj/item/ammo_box/magazine/stalker/kiparis, 2400, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("MP-5 Magazine", /obj/item/ammo_box/magazine/stalker/m9x19mp5, 3000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("MAC10 Magazine", /obj/item/ammo_box/magazine/stalker/mac10, 3500, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("PPSh Drum", /obj/item/ammo_box/magazine/stalker/ppsh, 7000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("5.7×28mm Magazine", /obj/item/ammo_box/magazine/smg57, 8000, RANK_ROOKIE, sale_price =550),
		new /datum/data/stalker_equipment("5.45x39mm Magazine", /obj/item/ammo_box/magazine/stalker/m545, 5250, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("AKM magazine (7.62x39)", /obj/item/ammo_box/magazine/stalker/akm, 5350, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("5.56x45mm Magazine", /obj/item/ammo_box/magazine/stalker/m556x45, 6500, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("AS \"Val\" Magazine", /obj/item/ammo_box/magazine/stalker/sp9x39val, 6000, RANK_VETERAN, sale_price =500),
		new /datum/data/stalker_equipment("Tunder S14 Magazine", /obj/item/ammo_box/magazine/stalker/sp9x39groza, 6500, RANK_EXPERIENCED, sale_price =500),
		new /datum/data/stalker_equipment("Vintorez Magazine", /obj/item/ammo_box/magazine/stalker/sp9x39vint, 6000, RANK_VETERAN, sale_price =500),
		new /datum/data/stalker_equipment("SVD Magazine", /obj/item/ammo_box/magazine/stalker/svd, 7000, RANK_VETERAN, sale_price =500),
		new /datum/data/stalker_equipment("FN FAL magazine (7.62x51)", /obj/item/ammo_box/magazine/stalker/fnfal, 7200, RANK_VETERAN, sale_price = 500),
		new /datum/data/stalker_equipment("Colt M1911; SIG-Sauer P220 Magazine", /obj/item/ammo_box/magazine/stalker/sc45, 3400, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("Beretta 92FS Magazine", /obj/item/ammo_box/magazine/stalker/m9x19marta, 3500, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("Beretta M38 Magazine", /obj/item/ammo_box/magazine/stalker/berettam38, 3250, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("USP-match Magazine", /obj/item/ammo_box/magazine/stalker/usp45, 4500, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("Desert Eagle Magazine", /obj/item/ammo_box/magazine/stalker/desert, 4000, RANK_EXPERIENCED, sale_price =500),
		new /datum/data/stalker_equipment("MAC10 Ingram Magazine", /obj/item/ammo_box/magazine/stalker/mac10, 4500, RANK_EXPERIENCED, sale_price =500),
		new /datum/data/stalker_equipment("PKM ammo belt box", /obj/item/ammo_box/magazine/stalker/pkm, 40000, RANK_EXPERIENCED, sale_price =500),
		new /datum/data/stalker_equipment("7.62x51 Clip", /obj/item/ammo_box/stalker/cl762x51, 2000, RANK_ROOKIE, sale_price =500)
		),


	"Suits" = list(
		new /datum/data/stalker_equipment("Leather Jacket", /obj/item/clothing/suit/hooded/kozhanka, 5000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("White Leather Jacket", /obj/item/clothing/suit/hooded/kozhanka/white, 5000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Armored Tan Coat", /obj/item/clothing/suit/hooded/kozhanka/tancoat, 15000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Clear Sky Coat", /obj/item/clothing/suit/hooded/kozhanka/cs_hood, 15000, RANK_ROOKIE, faction = FACTION_CLEARSKY),
		new /datum/data/stalker_equipment("Bandit Jacket", /obj/item/clothing/suit/hooded/kozhanka/banditka, 6000, RANK_ROOKIE, faction = FACTION_BANDITS),
		new /datum/data/stalker_equipment("Renegade Coat", /obj/item/clothing/suit/hooded/kozhanka/renegadecoat, 6000, RANK_ROOKIE, faction = FACTION_RENEGATE),
		new /datum/data/stalker_equipment("Military Service Armor", /obj/item/clothing/suit/army, 15000, RANK_ROOKIE, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("Military Service Vest", /obj/item/clothing/suit/mil, 15000, RANK_ROOKIE, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("Sunrise Outfit", /obj/item/clothing/suit/hooded/kombez, 33000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("6B2", /obj/item/clothing/suit/sixb2, 14000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Defender II Vest", /obj/item/clothing/suit/d2, 24000, RANK_EXPERIENCED, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("Mercenary Outfit", /obj/item/clothing/suit/hooded/kombez/mercenary, 25000, RANK_ROOKIE, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("Ecologist Mercenary Outfit", /obj/item/clothing/suit/hooded/kombez/eco_mercenary, 25000, RANK_ROOKIE, faction = FACTION_ECOLOGIST),
		new /datum/data/stalker_equipment("Bandit Outfit", /obj/item/clothing/suit/hooded/kombez/kombez_bandit, 25000, RANK_ROOKIE, faction = FACTION_BANDITS),
		new /datum/data/stalker_equipment("Renegade Outfit", /obj/item/clothing/suit/hooded/kombez/kombez_renegade, 25000, RANK_ROOKIE, faction = FACTION_RENEGATE),
		new /datum/data/stalker_equipment("Renegade Vest", /obj/item/clothing/suit/hooded/kombez/kombezrenegadewornd2, 30000, RANK_ROOKIE, faction = FACTION_RENEGATE),
		new /datum/data/stalker_equipment("Black Trenchcoat", /obj/item/clothing/suit/hooded/kozhanka/banditka/coat, 12500, RANK_ROOKIE, faction = FACTION_BANDITS),
		new /datum/data/stalker_equipment("Brown Trenchcoat", /obj/item/clothing/suit/hooded/kozhanka/banditka/coat/brown, 12500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Ghillie Suit", /obj/item/clothing/suit/hooded/kozhanka/ghillie, 30000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Berill-5M", /obj/item/clothing/suit/berill, 50000, RANK_EXPERIENCED, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("Guardian of Freedom", /obj/item/clothing/suit/guardian_of_freedom, 50000, RANK_EXPERIENCED, faction = FACTION_FREEDOM),
		new /datum/data/stalker_equipment("Sentinel of Freedom", /obj/item/clothing/suit/hooded/kombez/veter, 25000, RANK_ROOKIE, faction = FACTION_FREEDOM),
		new /datum/data/stalker_equipment("Wind of Freedom", /obj/item/clothing/head/hooded/stalker/strazh, 40000, RANK_EXPERIENCED, faction = FACTION_FREEDOM),
		new /datum/data/stalker_equipment("PZ-1	", sale_price = 8000),
		new /datum/data/stalker_equipment("Monolith Scientific Suit", /obj/item/clothing/suit/hooded/sealed/monolith, 60000, RANK_ROOKIE, faction = FACTION_MONOLITH),
		new /datum/data/stalker_equipment("PS5-M", /obj/item/clothing/suit/hooded/kombez/ps5m, 25000, RANK_ROOKIE, faction = FACTION_DUTY),
		new /datum/data/stalker_equipment("CS-3a body armor", /obj/item/clothing/suit/hooded/cs_medium, 25000, RANK_ROOKIE, faction = FACTION_CLEARSKY),
		new /datum/data/stalker_equipment("Heavy Mercenary Armour", /obj/item/clothing/suit/assaultmerc, 50000, RANK_EXPERIENCED, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("Mercenary Ace Suit", /obj/item/clothing/suit/hooded/sealed/merc, 60000, RANK_ROOKIE, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("CS-1 Body Armor", /obj/item/clothing/suit/cs_heavy, 60000, RANK_VETERAN, faction = FACTION_CLEARSKY),
		new /datum/data/stalker_equipment("PSZ-9D", /obj/item/clothing/suit/psz9d, 60000, RANK_VETERAN, faction = FACTION_DUTY),
		new /datum/data/stalker_equipment("PSZ-9M", /obj/item/clothing/suit/hooded/sealed/psz9md, 75000, RANK_VETERAN, faction = FACTION_DUTY),
		new /datum/data/stalker_equipment("SSP-99 Ecologist", /obj/item/clothing/suit/hooded/sealed/ecolog, 75000, RANK_EXPERT, faction = FACTION_ECOLOGIST),
		new /datum/data/stalker_equipment("SSP-99M Ecologist", /obj/item/clothing/suit/hooded/sealed/ecologm, 100000, RANK_EXPERT, faction = FACTION_ECOLOGIST),
		new /datum/data/stalker_equipment("SEVA", /obj/item/clothing/suit/hooded/sealed/seva, 125000, RANK_EXPERT, faction = FACTION_ECOLOGIST),
		new /datum/data/stalker_equipment("SKAT-9M", /obj/item/clothing/suit/skat, 150000, RANK_EXPERT, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet, 400000, RANK_EXPERT, faction = FACTION_LONERS),
		new /datum/data/stalker_equipment("Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet, 400000, RANK_EXPERT, faction = FACTION_CLEARSKY),
		new /datum/data/stalker_equipment("Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet, 400000, RANK_EXPERT, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("Merc Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet/merc, 400000, RANK_EXPERT, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("Duty Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet/duty, 400000, RANK_EXPERT, faction = FACTION_DUTY),
		new /datum/data/stalker_equipment("Freedom Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet/freedom, 400000, RANK_EXPERT, faction = FACTION_FREEDOM),
		new /datum/data/stalker_equipment("Monolith Exoskeleton", /obj/item/clothing/suit/hooded/sealed/exoskelet/monolith, 400000, RANK_EXPERT, faction = FACTION_MONOLITH)
	),


	// Headwear
	"Masks and Helmets" = list(
		new /datum/data/stalker_equipment("Respirator", /obj/item/clothing/mask/gas/stalker/respirator, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Gas Mask", /obj/item/clothing/mask/gas/stalker, 7500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Mercenary Gas Mask", /obj/item/clothing/mask/gas/stalker/mercenary, 7500, RANK_ROOKIE, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("TSH-4M", /obj/item/clothing/head/tsh, 3000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Steel Helmet", /obj/item/clothing/head/steel, 7500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("SSH-68", /obj/item/clothing/head/ssh, 7600, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Light Tactical Helmet", /obj/item/clothing/head/hardhat/tactical/light, 12500, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Guardian of Freedom helmet", /obj/item/clothing/head/hardhat/tactical/guardian_of_freedom, 12500, RANK_EXPERIENCED, faction = FACTION_FREEDOM),
		new /datum/data/stalker_equipment("Tactical Helmet", /obj/item/clothing/head/tacticalhelmet, 25000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Assault Helmet", /obj/item/clothing/head/assaultmerc, 30000, RANK_EXPERIENCED, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("Sphera-M12", /obj/item/clothing/head/spheram, 30000, RANK_EXPERIENCED, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("SKAT-9M Helmet", /obj/item/clothing/head/skathelmet, 90000, RANK_VETERAN, faction = FACTION_MILITARY),
		new /datum/data/stalker_equipment("MASKA-1 SCH Helmet", /obj/item/clothing/head/maska_1, 12500, RANK_EXPERIENCED, faction = FACTION_CLEARSKY),
		new /datum/data/stalker_equipment("Renegade Ballistic Mask", /obj/item/clothing/mask/gas/stalker/renegademask, 3000, RANK_EXPERIENCED, faction = FACTION_RENEGATE)
	),


	"Medicine" = list(
		///////////////////////////////	Медикаменты	/////////////////////////////////////////
		new /datum/data/stalker_equipment("Medkit", /obj/item/storage/firstaid/stalker/civillian, 1500, RANK_ROOKIE, sale_price = 50),
		new /datum/data/stalker_equipment("Army medkit", /obj/item/storage/firstaid/stalker/military, 3500, RANK_EXPERIENCED, sale_price = 125),
		new /datum/data/stalker_equipment("Scientific medkit", /obj/item/storage/firstaid/stalker/scientific, 6000, RANK_VETERAN, sale_price = 250),
		new /datum/data/stalker_equipment("Bandage", /obj/item/stack/medical/gauze/bint, 750, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Anti-rad", /obj/item/reagent_containers/hypospray/medipen/stalker/antirad, 3500, RANK_ROOKIE, sale_price = 1000),
		new /datum/data/stalker_equipment("LSD Pills", /obj/item/storage/pill_bottle/lsd, 10000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Happines Pills", /obj/item/storage/pill_bottle/happiness, 5000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Epinephrine Pills", /obj/item/storage/pill_bottle/epinephrine, 5000, RANK_ROOKIE)
		),


	"Food" = list(
		/////////////////////////////////	Еда	///////////////////////////////////////////
		new /datum/data/stalker_equipment("Canned stew", /obj/item/reagent_containers/food/snacks/stalker/konserva, 550, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned fish", /obj/item/reagent_containers/food/snacks/stalker/konserva/shproti, 750, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Vodka \"Kazaki\"", /obj/item/reagent_containers/food/drinks/bottle/vodka/kazaki, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Energy drink \"NonStop\"", /obj/item/reagent_containers/food/drinks/soda_cans/energetic, 500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Snickers", /obj/item/reagent_containers/food/snacks/stalker/konserva/snack/snikers, 300, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Salami", /obj/item/reagent_containers/food/snacks/stalker/kolbasa, 500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Bread", /obj/item/reagent_containers/food/snacks/stalker/baton, 400, RANK_ROOKIE),
		new /datum/data/stalker_equipment("MRE", /obj/item/storage/box/MRE, 2500, RANK_EXPERIENCED)
		),


	"Backpacks" = list(
		new /datum/data/stalker_equipment("Civvie satchel", /obj/item/storage/backpack/satchel/stalker/civilian, 2500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Cheap backpack", /obj/item/storage/backpack/stalker/civilian, 2500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Tourist bag", /obj/item/storage/backpack/stalker/tourist, 10000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Professional backpack", /obj/item/storage/backpack/stalker/professional, 20000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Rucksack", /obj/item/storage/backpack/stalker/rucksack, 35000, RANK_VETERAN),
		),


	"Rigs" = list(
		new /datum/data/stalker_equipment("Tactical belt", /obj/item/storage/belt/military/tactibelt	, 8000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Carry webbing", /obj/item/storage/belt/military/webbing, 14000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Chestrig", /obj/item/storage/belt/military/chestrig, 20000, RANK_VETERAN),
		),


	"Misc" = list(
		/////////////////////////////////	Other	/////////////////////////////////////////////
		new /datum/data/stalker_equipment/stalker_pda("PDA", "PDA", /obj/item/stalker_pda, 4000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Radio", /obj/item/radio, 7000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Repair-kit for suits and helmets", /obj/item/repair_kit/clothing, 10000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Repair-kit for guns", /obj/item/repair_kit/gun, 4000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Guitar", /obj/item/instrument/guitar, 3000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Geiger counter", /obj/item/geiger_counter, 3000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Flashlight", /obj/item/flashlight/seclite, 1000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Big Artifact belt", /obj/item/storage/belt/stalker/artifact_belt, 60000, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Small Artifact belt", /obj/item/storage/belt/stalker/artifact_belt/small, 25000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Matches", /obj/item/storage/box/matches, 1000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Simple lighter", /obj/item/lighter/greyscale, 3000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Zippo lighter", /obj/item/lighter, 5000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Cigarettes \"Maxim\"", /obj/item/storage/fancy/cigarettes/cigpack/maxim, 2500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Cigars", /obj/item/storage/fancy/cigarettes/cigars, 10000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Weed Rollie", /obj/item/clothing/mask/cigarette/rollie/trippy, 1000, RANK_ROOKIE, faction = FACTION_FREEDOM),
		new /datum/data/stalker_equipment("100RUB", /obj/item/stack/spacecash/c100, 100, RANK_ROOKIE, sale_price =100),
		new /datum/data/stalker_equipment("500RUB", /obj/item/stack/spacecash/c500, 500, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("1000RUB", /obj/item/stack/spacecash/c1000, 1000, RANK_ROOKIE, sale_price =1000),
		new /datum/data/stalker_equipment("5000RUB", /obj/item/stack/spacecash/c5000, 5000, RANK_ROOKIE, sale_price =5000),
//		new /datum/data/stalker_equipment("Bolts", /obj/item/stalker/bolts, 300, RANK_ROOKIE),
		new /datum/data/stalker_equipment("HandCuffs", /obj/item/restraints/handcuffs/cable/zipties, 500, RANK_ROOKIE, faction = FACTION_BANDITS),
		new /datum/data/stalker_equipment("HandCuffs", /obj/item/restraints/handcuffs/cable/zipties, 500, RANK_ROOKIE, faction = FACTION_RENEGATE),
		new /datum/data/stalker_equipment("Binoculars", /obj/item/twohanded/binoculars, 2500, RANK_EXPERIENCED),
		new /datum/data/stalker_equipment("Frag Grenade", /obj/item/grenade/syndieminibomb/concussion/stalker/frag, 8500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Smoke Grenade", /obj/item/grenade/smokebomb/rgd, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Flash Grenade", /obj/item/grenade/flashbang, 10000, RANK_EXPERIENCED, faction = FACTION_MERC),
		new /datum/data/stalker_equipment("Wallet", /obj/item/storage/wallet, 500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Flare", /obj/item/flashlight/flare, 2000, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Glowstick", /obj/item/flashlight/glowstick, 2000, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Soap", /obj/item/soap, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("Trash Bag", /obj/item/storage/bag/trash, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("Spray Cleaner", /obj/item/reagent_containers/spray/cleaner, 250, RANK_ROOKIE, sale_price = 150)
		),


	"Clothing" = list(
		new /datum/data/stalker_equipment("Under", /obj/item/clothing/under/color/switer, 1000, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Dark under", /obj/item/clothing/under/color/switer/dark, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Telnyashka", /obj/item/clothing/under/color/switer/lolg, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Tracksuit", /obj/item/clothing/under/color/switer/tracksuit, 1500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Worn out army boots", /obj/item/clothing/shoes/jackboots/warm, 800, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Fingerless gloves", /obj/item/clothing/gloves/fingerless, 600, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Gloves", /obj/item/clothing/gloves/color/black, 800, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Balaclava", /obj/item/clothing/mask/balaclava, 700, RANK_ROOKIE)
		),


	"Detectors" = list(
		new /datum/data/stalker_equipment("Echo", /obj/item/detector/blink, 8000, RANK_ROOKIE, sale_price =7000),
		new /datum/data/stalker_equipment("Bear", /obj/item/detector/bear, 17000, RANK_EXPERIENCED, sale_price =10000),
		new /datum/data/stalker_equipment("Veles", /obj/item/detector/veles, 66000, RANK_ROOKIE, sale_price =50000, faction = FACTION_ECOLOGIST),
		),


	"Attachments" = list(
		new /datum/data/stalker_equipment("Universal suppressor", /obj/item/attachment/suppressor, 4000, RANK_ROOKIE, sale_price =500),
		new /datum/data/stalker_equipment("SUSAT", /obj/item/attachment/scope/SUSAT, 10000, RANK_EXPERIENCED, sale_price =3000),
		new /datum/data/stalker_equipment("PSU-1", /obj/item/attachment/scope/PS/U1, 15000, RANK_EXPERIENCED, sale_price =5000),
		new /datum/data/stalker_equipment("PSO-1", /obj/item/attachment/scope/PS/O1, 30000, RANK_EXPERIENCED, sale_price =8000),
		new /datum/data/stalker_equipment("Rifle/Shotgun scope", /obj/item/attachment/scope/rifle, 10000, RANK_ROOKIE, sale_price =4000)
		),


	"Unbuyable" = list(
		new /datum/data/stalker_equipment("Canned soup", /obj/item/reagent_containers/food/snacks/stalker/konserva/soup, 900, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned beans", /obj/item/reagent_containers/food/snacks/stalker/konserva/bobi, 750, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned stew", /obj/item/reagent_containers/food/snacks/stalker/konserva/govyadina2, 900, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned fish", /obj/item/reagent_containers/food/snacks/stalker/konserva/fish, 750, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Cream cheese", /obj/item/reagent_containers/food/snacks/stalker/konserva/snack/sirok, 400, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Chocolate bar", /obj/item/reagent_containers/food/snacks/stalker/konserva/snack/chocolate, 600, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Biscuits", /obj/item/reagent_containers/food/snacks/stalker/konserva/galets, 400, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Cereal", /obj/item/reagent_containers/food/snacks/stalker/konserva/kasha, 550, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned meat", /obj/item/reagent_containers/food/snacks/stalker/konserva/MREkonserva1, 700, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned meat", /obj/item/reagent_containers/food/snacks/stalker/konserva/MREkonserva2, 700, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Canned meat with vegetables", /obj/item/reagent_containers/food/snacks/stalker/konserva/MREkonserva3, 850, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Biscuits", /obj/item/reagent_containers/food/snacks/stalker/konserva/galets, 400, RANK_ROOKIE),

		// Mutant loot

		new /datum/data/stalker_equipment("Dog Tail", /obj/item/stalker/loot/mutantparts/dog_tail, 1000, RANK_ROOKIE, sale_price = 600),
		new /datum/data/stalker_equipment("Flesh Eye", /obj/item/stalker/loot/mutantparts/flesh_eye, 1800, RANK_ROOKIE, sale_price = 1050),
		new /datum/data/stalker_equipment("Boar Hoof", /obj/item/stalker/loot/mutantparts/boar_leg, 6000, RANK_ROOKIE, sale_price = 1800),
		new /datum/data/stalker_equipment("Snork Leg", /obj/item/stalker/loot/mutantparts/snork_leg, 7000, RANK_ROOKIE, sale_price = 3000),
		new /datum/data/stalker_equipment("Bloodsucker Tendrils", /obj/item/stalker/loot/mutantparts/bloodsucker, 16000, RANK_ROOKIE, sale_price = 8000),
		new /datum/data/stalker_equipment("Pseudodog Tail", /obj/item/stalker/loot/mutantparts/pseudo_tail, 8000, RANK_ROOKIE, sale_price = 7000),
		new /datum/data/stalker_equipment("Controller Brain", /obj/item/stalker/loot/mutantparts/controller_brain, 40000, RANK_ROOKIE, sale_price = 20000),
		new /datum/data/stalker_equipment("Poltergeist Skin", /obj/item/stalker/loot/mutantparts/poltergeist_skin, 80000, RANK_ROOKIE, sale_price = 40000),

		// Artifacts

		new /datum/data/stalker_equipment("Jellyfish", /obj/item/artifact/meduza, 5000, RANK_ROOKIE, sale_price = 2500),
//		new /datum/data/stalker_equipment("Stone Flower", /obj/item/artifact/stoneflower, 10000, RANK_ROOKIE, sale_price = 3000),
//		new /datum/data/stalker_equipment("Night Star", /obj/item/artifact/nightstar, 30000, RANK_ROOKIE, sale_price = 13000),
		new /datum/data/stalker_equipment("Depleted Stone Flower", /obj/item/artifact/stoneflower_depleted, 5000, RANK_ROOKIE, sale_price = 1500),
		new /datum/data/stalker_equipment("Depleted Night Star", /obj/item/artifact/nightstar_depleted, 10000, RANK_ROOKIE, sale_price = 8000),
		new /datum/data/stalker_equipment("Soul", /obj/item/artifact/soul, 80000, RANK_ROOKIE, sale_price = 25000),
		///////////////////////////////////////////////////////////////////////////////////////////
		new /datum/data/stalker_equipment("Flash", /obj/item/artifact/flash, 6000, RANK_ROOKIE, sale_price = 2500),
		new /datum/data/stalker_equipment("Moonlight", /obj/item/artifact/moonlight, 12000, RANK_ROOKIE, sale_price = 3500),
		new /datum/data/stalker_equipment("Shell", /obj/item/artifact/pustishka, 40000, RANK_ROOKIE, sale_price = 8000),
		new /datum/data/stalker_equipment("Battery", /obj/item/artifact/battery, 70000, RANK_ROOKIE, sale_price = 24000),
		///////////////////////////////////////////////////////////////////////////////////////////
		new /datum/data/stalker_equipment("Droplet", /obj/item/artifact/droplet, 7000, RANK_ROOKIE, sale_price = 5000),
		new /datum/data/stalker_equipment("Fireball", /obj/item/artifact/fireball, 15000, RANK_ROOKIE, sale_price = 7500),
		new /datum/data/stalker_equipment("Crystal", /obj/item/artifact/crystal, 60000, RANK_ROOKIE, sale_price = 15000),
		new /datum/data/stalker_equipment("\improper Mama's Beads", /obj/item/artifact/maminibusi, 80000, RANK_ROOKIE, sale_price = 35000),
		///////////////////////////////////////////////////////////////////////////////////////////
		new /datum/data/stalker_equipment("Stone Blood", /obj/item/artifact/stone_blood, 4000, RANK_ROOKIE, sale_price = 2500),
		new /datum/data/stalker_equipment("Bubble", /obj/item/artifact/bubble, 12000, RANK_ROOKIE, sale_price = 15000),
		new /datum/data/stalker_equipment("Mica", /obj/item/artifact/mica, 30000, RANK_ROOKIE, sale_price = 20000),
		new /datum/data/stalker_equipment("Firefly", /obj/item/artifact/firefly, 90000, RANK_ROOKIE, sale_price = 40000),

		// Trash

		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva, 400, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/MREkonserva1, 200, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/MREkonserva2, 200, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/MREkonserva3, 200, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/bobi, 400, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/fish, 500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/govyadina, 400, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/shproti, 600, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Konserva", /obj/item/trash/konserva/soup, 500, RANK_ROOKIE),
		new /datum/data/stalker_equipment("Used Zipties", /obj/item/restraints/handcuffs/cable/zipties/used, 250, RANK_ROOKIE),
		///////////////////////////////////////////////////////////////////////////////////////////
		new /datum/data/stalker_equipment("50 RU", /obj/item/stack/spacecash/c50, 50, RANK_ROOKIE, sale_price = 50),
		new /datum/data/stalker_equipment("100 RU", /obj/item/stack/spacecash/c100, 100, RANK_ROOKIE, sale_price = 100),
		new /datum/data/stalker_equipment("500 RU", /obj/item/stack/spacecash/c500, 500, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("1000 RU", /obj/item/stack/spacecash/c1000, 1000, RANK_ROOKIE, sale_price = 1000),
		new /datum/data/stalker_equipment("5000 RU", /obj/item/stack/spacecash/c5000, 5000, RANK_ROOKIE, sale_price = 5000),


		/////////////////////////////////	Medkit components	//////////////////////////////////////////////////
		new /datum/data/stalker_equipment("Ointment", /obj/item/stack/medical/ointment, 25, RANK_ROOKIE, sale_price = 25),
		new /datum/data/stalker_equipment("Bruise Pack", /obj/item/stack/medical/bruise_pack, 25, RANK_ROOKIE, sale_price = 25),
		new /datum/data/stalker_equipment("Charcoal Pill", /obj/item/reagent_containers/pill/charcoal, 125, RANK_ROOKIE, sale_price = 125),
		new /datum/data/stalker_equipment("Epipen", /obj/item/reagent_containers/pill/stalker/injector/epinephrine, 125, RANK_ROOKIE, sale_price = 125),
		new /datum/data/stalker_equipment("Brute Patch", /obj/item/reagent_containers/pill/patch/styptic, 250, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Burn Patch", /obj/item/reagent_containers/pill/patch/silver_sulf, 250, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Combat Patch", /obj/item/reagent_containers/pill/patch/synthflesh, 250, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Brute Injector", /obj/item/reagent_containers/pill/stalker/injector/brute, 250, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Burn Injector", /obj/item/reagent_containers/pill/stalker/injector/burn, 250, RANK_ROOKIE, sale_price = 250),
		new /datum/data/stalker_equipment("Blood Injector", /obj/item/reagent_containers/pill/stalker/injector/blood, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("Painkillers Injector", /obj/item/reagent_containers/pill/stalker/injector/painkiller, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("Antitoxin Injector", /obj/item/reagent_containers/pill/stalker/injector/toxin, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("Oxygen Injector", /obj/item/reagent_containers/pill/stalker/injector/oxygen, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("Antirad Injector", /obj/item/reagent_containers/pill/stalker/injector/antirad, 250, RANK_ROOKIE, sale_price = 150),


		/////////////////////////////////Rare Firearms	//////////////////////////////////////////////////
		new /datum/data/stalker_equipment("Arisaka", /obj/item/gun/ballistic/rifle/boltaction/arisaka, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Karabiner", /obj/item/gun/ballistic/rifle/boltaction/karabiner, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Springfield", /obj/item/gun/ballistic/rifle/boltaction/springfield, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Sten MK II", /obj/item/gun/ballistic/automatic/sten, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Sterling Submachine Gun", /obj/item/gun/ballistic/automatic/sterling, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("M3A1 Grease Gun", /obj/item/gun/ballistic/automatic/m3a1, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Reising Model 55", /obj/item/gun/ballistic/automatic/reising, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("MP-40", /obj/item/gun/ballistic/automatic/mp40, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("MP 3008", /obj/item/gun/ballistic/automatic/mp3008, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("PPS-43", /obj/item/gun/ballistic/automatic/pps43, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("PP-19 Bizon", /obj/item/gun/ballistic/automatic/bizon, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Smith & Wesson M76", /obj/item/gun/ballistic/automatic/m76, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Skorpion", /obj/item/gun/ballistic/automatic/skorpion, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("SKS", /obj/item/gun/ballistic/rifle/semiautobolt/sks, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("FN FAL", /obj/item/gun/ballistic/automatic/fnfal, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("FN FAL", /obj/item/gun/ballistic/automatic/woodfnfal, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("FAMAS", /obj/item/gun/ballistic/automatic/famas, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Steyr AUG", /obj/item/gun/ballistic/automatic/aug, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("vz. 58", /obj/item/gun/ballistic/automatic/vz58, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("M16A1", /obj/item/gun/ballistic/automatic/m16, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("M14 Carbine", /obj/item/gun/ballistic/automatic/m14, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("M16A4", /obj/item/gun/ballistic/automatic/m16a4, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("M4 Carbine", /obj/item/gun/ballistic/automatic/m4, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("ArmaLite AR-15", /obj/item/gun/ballistic/automatic/ar15, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("FN SCAR-H", /obj/item/gun/ballistic/automatic/scarh, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("AK74", /obj/item/gun/ballistic/automatic/ak74/black, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("AK74", /obj/item/gun/ballistic/automatic/ak74/camo, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("AK74", /obj/item/gun/ballistic/automatic/ak74/blackout, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Luger P08", /obj/item/gun/ballistic/automatic/pistol/luger, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Walther P38", /obj/item/gun/ballistic/automatic/pistol/walther, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Stetchkin APS", /obj/item/gun/ballistic/automatic/pistol/aps, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("OTs- Pernach", /obj/item/gun/ballistic/automatic/pistol/pernach, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Mauser C96", /obj/item/gun/ballistic/automatic/pistol/mauser, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Glock 17", /obj/item/gun/ballistic/automatic/pistol/glock, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("TT-30", /obj/item/gun/ballistic/automatic/pistol/tt30, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Five Seven", /obj/item/gun/ballistic/automatic/pistol/fiveseven, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment(".500 Bull", /obj/item/gun/ballistic/revolver/c500revolver, 7550, RANK_ROOKIE, sale_price = 100000),
		new /datum/data/stalker_equipment("Walther PP", /obj/item/gun/ballistic/automatic/pistol/waltherpp, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("CZ 83", /obj/item/gun/ballistic/automatic/pistol/cz83, 7550, RANK_ROOKIE, sale_price = 50000),
		new /datum/data/stalker_equipment("Silver Baretta", /obj/item/gun/ballistic/automatic/pistol/silvermarta, 7550, RANK_ROOKIE, sale_price = 50000),
		/////////////////////////////////Rare Firearm Ammo	//////////////////////////////////////////////////
		new /datum/data/stalker_equipment("aps pistol magazine (9x18mm)", /obj/item/ammo_box/magazine/stalker/m9x18aps, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("bizon magazine (9x18mm)", /obj/item/ammo_box/magazine/stalker/m9x18bizon, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("luger pistol magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19luger, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("walther P38 pistol magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19waltherp38, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("glock pistol magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19glock, 250, RANK_ROOKIE, sale_price = 150),
		new /datum/data/stalker_equipment("five seven pistol magazine (5.7×28mm)", /obj/item/ammo_box/magazine/stalker/m57x28fiveseven, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("walther PP pistol magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19waltherpp, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("CZ 83 pistol magazine (9x18mm)", /obj/item/ammo_box/magazine/stalker/m9x18cz83, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("reising magazine (.45)", /obj/item/ammo_box/magazine/stalker/reising, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("mat 49 magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19mat49, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("M14 magazine (7.62x51)", /obj/item/ammo_box/magazine/stalker/m14, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("SCAR magazine (7.62x51)", /obj/item/ammo_box/magazine/stalker/scarh, 250, RANK_ROOKIE, sale_price = 500),
//		new /datum/data/stalker_equipment("SKS magazine (7.62x51)", /obj/item/ammo_box/magazine/stalker/sks, 250, RANK_ROOKIE, sale_price = 500), //SKS IS INTERNAL MAG :megatroll:
		new /datum/data/stalker_equipment("vz. 58 magazine (7.62x39)", /obj/item/ammo_box/magazine/stalker/vz58, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("PPS43 magazine (7.62x25)", /obj/item/ammo_box/magazine/stalker/pps43, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("MP-40 magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/mp40, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("sten MK II magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/sten, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("sterling magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/sterling, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("M3A1 grease gun magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m3a1, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("S&W M76 magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19m76, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("skorpion magazine (9x19mm)", /obj/item/ammo_box/magazine/stalker/m9x19skorpion, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("mauser pistol magazine (7.62x25mm)", /obj/item/ammo_box/magazine/stalker/mauser, 250, RANK_ROOKIE, sale_price = 500),
		new /datum/data/stalker_equipment("extended mauser pistol magazine (7.62x25mm)", /obj/item/ammo_box/magazine/stalker/mauser/ext, 250, RANK_ROOKIE, sale_price = 500),
		)*/

	"Debug" = list(
		new /datum/data/stalker_equipment("Debug item (wrench)", /obj/item/wrench, 250, RANK_ROOKIE, sale_price = 250),
	)

	))

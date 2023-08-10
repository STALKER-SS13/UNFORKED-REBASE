/obj/machinery/stalker
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	icon = 'stalker/icons/decor.dmi'

/obj/machinery/stalker/sidormat
	name = "SYCHEMAT"
	desc = "An equipment vendor for beginning stalkers."
	icon_state = "radio"
	density = 1
	anchored = 1
	/// Turf that you place your items you want to sell on
	var/turf/items_to_sell_turf
	/// Turf that it places items you bought on
	var/turf/bought_stuff_turf
	var/balance = 0
	var/rating = 0
	var/switches = BUY_STUFF
	var/real_assorment = list()
	var/list/special_factions = list(FACTION_LONERS, FACTION_BANDITS, FACTION_DUTY, FACTION_FREEDOM, FACTION_MERC, FACTION_MONOLITH, FACTION_CLEARSKY, FACTION_ECOLOGIST, FACTION_RENEGATE, FACTION_MILITARY)

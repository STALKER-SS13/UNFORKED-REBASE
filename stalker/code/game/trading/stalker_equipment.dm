/datum/data/stalker_equipment
	name = "generic"
	var/equipment_path = null
	var/cost = 0
	var/rating = 0
	var/faction = "Everyone"
	var/sale_price = 0
	var/assortment_level = 0

/datum/data/stalker_equipment/New(name, path, cost, rating, faction = "Everyone", sale_price = 0, assortment_level = 0)
	src.name = name
	src.equipment_path = path
	src.cost = cost
	src.rating = rating
	src.faction = faction
	if(sale_price)
		src.sale_price = sale_price
	else
		src.sale_price = cost/2
	src.assortment_level = assortment_level

	switch(cost)
		if(0 to TRASH_TIER_COST)
			GLOB.trash_tier_sidormat_items += src

		if(0 to LOW_TIER_COST)
			GLOB.low_tier_sidormat_items += src

		if(0 to MEDIUM_TIER_COST)
			GLOB.medium_tier_sidormat_items += src

		if(LOW_TIER_COST to HIGH_TIER_COST)
			GLOB.high_tier_sidormat_items += src

	GLOB.real_sidormat_items += src

/datum/data/stalker_equipment/proc/GetCost()
	return sale_price

/datum/data/stalker_equipment/stalker_pda/GetCost() //obj/item/stalker_pda/KPK
	return
	/*
	var/cost_ = sale_price
	if(KPK.owner && (KPK.owner.stat == DEAD))
		var/rank_ = CLAMP(KPK.profile.fields["rating"], RANK_ROOKIE, RANK_LEGEND)
		cost_ += GetCostBasedOnReputation(KPK.profile.fields["reputation"])
		cost_ += rank_*2
	return cost_
	*/

/proc/GetCostBasedOnReputation(rep_)
	switch(rep_)
		if(REP_AMAZING to INFINITY)
			return ((REP_NEUTRAL - rep_) * 20)
		if(REP_VERYGOOD to REP_AMAZING)
			return ((REP_NEUTRAL - rep_) * 10)
		if(REP_GOOD to REP_VERYGOOD)
			return ((REP_NEUTRAL - rep_) * 5)
		if(REP_BAD to REP_GOOD)
			return 0
		if(REP_VERYBAD to REP_BAD)
			return ((REP_NEUTRAL - rep_) * 5)
		if(REP_DISGUSTING to REP_VERYBAD)
			return ((REP_NEUTRAL - rep_) * 10)
		if(-INFINITY to REP_DISGUSTING)
			return ((REP_NEUTRAL - rep_) * 20)

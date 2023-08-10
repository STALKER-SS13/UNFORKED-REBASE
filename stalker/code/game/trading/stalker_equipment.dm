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
			GLOB.trash_tier_sidormatitems += src

		if(0 to LOW_TIER_COST)
			GLOB.low_tier_sidormatitems += src

		if(0 to MEDIUM_TIER_COST)
			GLOB.medium_tier_sidormatitems += src

		if(LOW_TIER_COST to HIGH_TIER_COST)
			GLOB.high_tier_sidormatitems += src

	GLOB.real_sidormat_items += src

/datum/data/stalker_equipment/proc/GetCost()
	return sale_price

/datum/data/stalker_equipment/stalker_pda/GetCost(var/obj/item/stalker_pda/KPK)
	var/cost_ = sale_price
	if(KPK.owner && (KPK.owner.stat == DEAD))
		var/rank_ = CLAMP(KPK.profile.fields["rating"], ROOKIE, ZONE_LEGEND)
		cost_ += GetCostBasedOnReputation(KPK.profile.fields["reputation"])
		cost_ += rank_*2
	return cost_

/proc/GetCostBasedOnReputation(var/rep_)
	switch(rep_)
		if(AMAZING to INFINITY)
			return ((NEUTRAL - rep_) * 20)
		if(VERYGOOD to AMAZING)
			return ((NEUTRAL - rep_) * 10)
		if(GOOD to VERYGOOD)
			return ((NEUTRAL - rep_) * 5)
		if(BAD to GOOD)
			return 0
		if(VERYBAD to BAD)
			return ((NEUTRAL - rep_) * 5)
		if(DISGUSTING to VERYBAD)
			return ((NEUTRAL - rep_) * 10)
		if(-INFINITY to DISGUSTING)
			return ((NEUTRAL - rep_) * 20)

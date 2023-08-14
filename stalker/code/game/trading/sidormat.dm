GLOBAL_LIST_EMPTY(sidor_cache)

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
	var/balance = 10000
	var/rating = 10000
	var/switches = BUY_STUFF
	var/real_assorment = list()
	var/list/special_factions = list(FACTION_LONERS, FACTION_BANDITS, FACTION_DUTY, FACTION_FREEDOM, FACTION_MERC, FACTION_MONOLITH, FACTION_CLEARSKY, FACTION_ECOLOGIST, FACTION_RENEGATE, FACTION_MILITARY)

/obj/machinery/stalker/sidormat/Initialize(mapload)
	. = ..()
	items_to_sell_turf = get_step(src, WEST) // TODO: Add turn(src.dir, -90/90) later
	bought_stuff_turf = get_step(src, EAST)

/obj/machinery/stalker/sidormat/attack_hand(mob/user)
	if(..())
		return
	if(!ishuman(user))
		say("You are not a human.")
		return

	ui_interact(user)

/obj/machinery/stalker/sidormat/ui_interact(mob/living/carbon/human/H)
	H.set_machine(src)
	var/dat

	dat +="<div class='statusDisplay'>"
	dat += "Balance: [num2text(balance, 8)] RU<br>"
	dat += "<br><br>INSTRUCTION: Put loot for sale on the <b>left</b> table.<br>"
	if(switches & BUY_STUFF)
		dat +="<A href='?src=[REF(src)];choice=take'><b>Sell loot</b></A><br>"
	dat += "</div>"
	dat += "<div class='lenta_scroll'>"
	dat += "<BR><table border='0' width='400'>" //<b>Item list:</b>
	for(var/L in GLOB.global_sidormat_list)
		if(L == "Unbuyable" && !(switches & SELL_UNBUYABLE))
			continue
		dat += "<tr><td><center><big><b>[L]</b></big></center></td><td></td><td></td></tr>"
		for(var/datum/data/stalker_equipment/prize in GLOB.global_sidormat_list[L])
			//if((pda_record.fields["faction_s"] == prize.faction && ((pda_record.fields["faction_s"] in special_factions) || (switches & SHOW_FACTION_EQUIPMENT))) || prize.faction == "Everyone")
				//if(rating >= prize.rating)
			dat += "<tr><td><img src='data:image/jpeg;base64,[GetIconForProduct(prize)]'/></td><td>[prize.name]</td><td>[prize.cost]</td><td><A href='?src=[REF(src)];purchase=[REF(prize)]'>Buy</A></td></tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup = new(H, "sidormat", "SIDORMAT 3023", 450, 700)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/stalker/sidormat/Topic(href, href_list)
	if(..())
		return

	if(href_list["choice"])
		if(href_list["choice"] == "take")
			SellItems()

	if(href_list["purchase"])
		var/datum/data/stalker_equipment/prize = locate(href_list["purchase"])
		if(!prize)
			updateUsrDialog()
			return
		if(prize.cost > balance)
			say("You don't have  enough money to buy [prize.name].")
			updateUsrDialog()
			return

		balance -= prize.cost
		new prize.equipment_path(bought_stuff_turf)

	updateUsrDialog()
	return


/obj/machinery/stalker/sidormat/proc/GetIconForProduct(datum/data/stalker_equipment/P)
	if(GLOB.sidor_cache[P.equipment_path])
		return GLOB.sidor_cache[P.equipment_path]

	var/product = new P.equipment_path()
	GLOB.sidor_cache[P.equipment_path] = icon2base64(getFlatIcon(product, no_anim = TRUE))
	qdel(product)
	return GLOB.sidor_cache[P.equipment_path]

/obj/machinery/stalker/sidormat/proc/SellItems()
	var/list/atom/movable/ontable = GetItemsOnTable()
	var/total_cost = GetOnTableCost(ontable)

	if(total_cost < 100)
		say("What is this shit?")
		return

	for(var/atom/movable/I in ontable)
		if(I.loc != items_to_sell_turf)
			continue

		balance += GetCost(I)
		say("[I] was sold for [GetCost(I)].")
		qdel(I)

		CHECK_TICK

	if(total_cost)
		say("<b>Habar was successfully sold for [total_cost].</b>")

	updateUsrDialog()
	return

/obj/machinery/stalker/sidormat/proc/GetItemsOnTable()
	var/list/ontable = list()
	for(var/atom/movable/AM in items_to_sell_turf)
		if(GetCost(AM) <= 0)
			continue

		/*if(istype(AM, /obj/item/clothing))
			var/obj/item/clothing/C = AM
			if((C.durability / initial(C.durability)) * 100 < 80)
				say("[AM] is too broken for sale.")
				continue*/

		if(istype(AM, /obj/item/storage/backpack) && AM.contents.len)
			say("Empty [AM] before selling.")
			continue

		if(istype(AM, /obj/item/ammo_box))
			var/obj/item/ammo_box/AB = AM
			if(AB.stored_ammo.len < AB.max_ammo)
				say("Fill [AB] before selling.")
				continue

		ontable += AM

	return ontable

/obj/machinery/stalker/sidormat/proc/GetOnTableCost()
	var/list/ontable = GetItemsOnTable()
	var/total_cost = 0

	for(var/atom/movable/item_on_table in ontable)
		total_cost += GetCost(item_on_table)
	return total_cost

/obj/machinery/stalker/sidormat/proc/GetCost(obj/item/I)
	for(var/datum/data/stalker_equipment/se in GLOB.real_sidormat_items)
		if(I.type == se.equipment_path)
			return se.GetCost(I)
	return 0

/obj/machinery/stalker/sidormat/ex_act(severity, target)
	return

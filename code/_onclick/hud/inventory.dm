/atom/movable/screen/inventory
	/// The identifier for the slot. It has nothing to do with ID cards.
	var/slot_id
	/// Icon when empty. For now used only by humans.
	var/icon_empty
	/// Icon when contains an item. For now used only by humans.
	var/icon_full
	/// The overlay when hovering over with an item in your hand
	var/image/object_overlay
	plane = HUD_PLANE

/atom/movable/screen/inventory/Click(location, control, params)
	// At this point in client Click() code we have passed the 1/10 sec check and little else
	// We don't even know if it's a middle click
	if(world.time <= usr.next_move)
		return TRUE

	if(usr.incapacitated(IGNORE_STASIS))
		return TRUE
	if(ismecha(usr.loc)) // stops inventory actions in a mech
		return TRUE

	if(hud?.mymob && slot_id)
		var/obj/item/inv_item = hud.mymob.get_item_by_slot(slot_id)
		if(inv_item)
			return inv_item.Click(location, control, params)

	if(usr.attack_ui(slot_id, params))
		usr.update_held_items()
	return TRUE

/atom/movable/screen/inventory/MouseEntered(location, control, params)
	. = ..()
	add_overlays()

/atom/movable/screen/inventory/MouseExited()
	..()
	cut_overlay(object_overlay)
	QDEL_NULL(object_overlay)

/atom/movable/screen/inventory/update_icon_state()
	if(!icon_empty)
		icon_empty = icon_state

	if(hud?.mymob && slot_id && icon_full)
		icon_state = hud.mymob.get_item_by_slot(slot_id) ? icon_full : icon_empty
	return ..()

/atom/movable/screen/inventory/proc/add_overlays()
	var/mob/user = hud?.mymob

	if(!user || !slot_id)
		return

	var/obj/item/holding = user.get_active_held_item()

	if(!holding || user.get_item_by_slot(slot_id))
		return

	var/image/item_overlay = image(holding)
	item_overlay.alpha = 92

	if(!holding.mob_can_equip(user, slot_id, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
		item_overlay.color = "#FF0000"
	else
		item_overlay.color = "#00ff00"

	cut_overlay(object_overlay)
	object_overlay = item_overlay
	add_overlay(object_overlay)

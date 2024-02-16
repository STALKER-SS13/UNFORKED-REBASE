/obj/item/gun/ballistic
	var/is_jammed = FALSE
	var/durability = 100
	var/is_unique = FALSE
	var/can_scope = FALSE
	var/list/modifications = list() // TODO
	var/automatic = FALSE
	var/autofire_delay = 0.2 SECONDS
	/// Distance in turfs to move the user's screen forward (the "zoom" effect)
	var/zoomed = FALSE
	var/zoom_amt = 0
	var/zoom_out_amt = 0
	var/scoped = FALSE
	var/datum/action/toggle_scope_zoom/zoom_action

	var/list/obj/item/attachment/addons = list()

	// Overlay shit
	var/image/mag_overlay = null
	var/image/mag_overlay_inhands = null
	var/image/silencer_overlay = null
	var/image/scope_overlay = null
	var/image/colored_overlay = null
	var/colored = null

	var/draw_sound
	suppressed_sound = 'stalker/sound/weapons/silencer.ogg'


/obj/item/gun/ballistic/Initialize(mapload)
	. = ..()
	if(automatic)
		AddComponent(/datum/component/automatic_fire, autofire_delay)
		actions_types.Remove(/datum/action/item_action/toggle_firemode)

	init_zoom()

	RegisterSignal(src, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(src, COMSIG_GUN_FIRED, PROC_REF(on_fire))

	if(!istype(src, /obj/item/gun/ballistic/automatic/stalker/pistol))
		mag_overlay = image('stalker/icons/projectile_overlays32x32.dmi', "[initial(icon_state)]-mag", layer = FLOAT_LAYER)

	if(can_suppress)
		silencer_overlay = image('stalker/icons/projectile_overlays48x48.dmi', "[initial(icon_state)]-silencer", layer = FLOAT_LAYER)

	if(can_scope)
		scope_overlay = image('stalker/icons/projectile_overlays32x32.dmi', "[initial(icon_state)]-scope", layer = FLOAT_LAYER)

	if(colored)
		colored_overlay = image('stalker/icons/projectile_overlays32x32.dmi', "[initial(icon_state)]-[colored]", layer = FLOAT_LAYER)

	update_icon()



/obj/item/gun/ballistic/Destroy()
	UnregisterSignal(src, COMSIG_ITEM_PICKUP)
	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	UnregisterSignal(src, COMSIG_GUN_FIRED)
	return ..()


/obj/item/gun/ballistic/proc/on_pickup(obj/item/source, mob/user)
	SIGNAL_HANDLER

	playsound(src, draw_sound, 30, 1)
	if(zoom_action)
		zoom_action.Grant(user)


/obj/item/gun/ballistic/proc/on_drop(obj/item/source, mob/user)
	SIGNAL_HANDLER

	if(zoom_action)
		zoom_action.Remove(user)

/obj/item/gun/ballistic/proc/on_fire(obj/item/source, mob/user)
	SIGNAL_HANDLER

	durability_check(user)



/obj/item/gun/ballistic/update_overlays()
	. = ..()
	if(is_unique)
		. += image('stalker/icons/projectile_overlays32x32.dmi', "unique", layer = FLOAT_LAYER)

	if(colored)
		. += colored_overlay

	if(magazine && mag_overlay)
		. += mag_overlay

	if(suppressed && silencer_overlay)
		. += silencer_overlay

	if(scoped && scope_overlay)
		. += scope_overlay

/obj/item/gun/ballistic/proc/durability_check(mob/user)   //Gun durability
	if(is_jammed)
		return
	if(durability < 0)
		return

	var/durability_percentage = (durability/(initial(durability)))*100
	switch(durability_percentage)
		if(0 to 20)
			if(prob(60))
				shake_camera(user, 4, 2)
				explosion(get_turf(src), -2, -2, 2, flame_range = 0)
				qdel(src)
				to_chat(user, span_userdanger("The weapon exploded right in your hands!"))
				return
			else
				if(prob(40))
					is_jammed = TRUE
		if(20 to 45)
			if(prob(10))
				user.dropItemToGround(src)
				shake_camera(user, 4, 2)
				to_chat(user, "<span class='userdanger'It seems like a good time to fix this stuff or throw it away before it shoots you in the face..</span>")
				is_jammed = TRUE
			else
				if(prob(20))
					is_jammed = TRUE
		if(45 to 60)
			if(prob(5))
				is_jammed = TRUE
		if(60 to 75)
			if(prob(2.5))
				is_jammed = TRUE
	durability -= 0.075

/obj/item/gun/ballistic/attack_self(mob/living/user)
	if(is_jammed)
		to_chat(user, "You unjam the [src].")
		is_jammed = FALSE
		return
	return ..()



/datum/action/toggle_scope_zoom
	name = "Toggle Scope"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED|AB_CHECK_LYING|AB_CHECK_HANDS_BLOCKED
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	var/datum/weakref/gun_ref = null

/datum/action/toggle_scope_zoom/Trigger(trigger_flags)
	var/obj/item/gun/ballistic/gun = gun_ref.resolve()
	if(istype(gun))
		gun.zoom(owner)

/datum/action/toggle_scope_zoom/IsAvailable(feedback)
	. = ..()
	var/obj/item/gun/ballistic/gun = gun_ref.resolve()
	if(!. && istype(gun))
		gun.zoom(owner, FALSE)

/datum/action/toggle_scope_zoom/Remove(mob/living/L)
	var/obj/item/gun/ballistic/gun = gun_ref.resolve()
	if(istype(gun))
		gun.zoom(L, FALSE)
	..()

/obj/item/gun/ballistic/proc/zoom(mob/living/user, forced_zoom = -1)
	if(!user || !user.client)
		return
	if(forced_zoom != -1)
		zoomed = forced_zoom
	else
		zoomed = !zoomed

	if(zoomed)
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_zoom_walk))
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, PROC_REF(zoom_rotate))
		user.visible_message(span_notice("[user] looks into [src]'s scope."), span_notice("You look into [src]'s scope."))
		user.client.view_size.zoomOut(zoom_out_amt, zoom_amt, user.dir)
	else
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		user.visible_message(span_notice("[user] lowers [src]."), span_notice("You lower [src]."))
		user.client.view_size.zoomIn()

/obj/item/gun/ballistic/proc/on_zoom_walk(atom/movable/source)
	SIGNAL_HANDLER

	if(ismob(source))
		zoom(source, FALSE)

/obj/item/gun/ballistic/proc/zoom_rotate(atom/movable/source, old_dir, new_dir)
	SIGNAL_HANDLER

	if(ismob(source))
		var/mob/mob = source
		mob.client.view_size.zoomOut(zoom_out_amt, zoom_amt, new_dir)

/obj/item/gun/ballistic/proc/init_zoom()
	if(zoom_action)
		return

	if(scoped)
		for(var/obj/item/attachment/scope/S in addons)
			zoom_amt += S.zoom_add
			zoom_out_amt += (5 + S.zoom_add)
		zoom_action = new()
		zoom_action.gun_ref = WEAKREF(src)
		if(ismob(loc))
			zoom_action.Grant(loc)

/obj/item/gun/ballistic/proc/reset_zoom()
	if(!zoom_action)
		return

	if(ismob(loc))
		zoom_action.Remove(loc)
	QDEL_NULL(zoom_action)


/obj/item/gun/ballistic/automatic/stalker
	modifications = list("barrel_automatic" = 0, "frame_automatic" = 0, "grip_automatic" = 0, "compensator_automatic" = 0)
	icon = 'stalker/icons/obj/projectile.dmi'
	lefthand_file = 'stalker/icons/obj/guns_lefthand.dmi'
	righthand_file = 'stalker/icons/obj/guns_righthand.dmi'
	burst_size = 1
	can_suppress = FALSE
	can_unsuppress = FALSE

/obj/item/gun/ballistic/automatic/stalker/pistol
	modifications = list("barrel_pistol" = 0, "frame_pistol" = 0, "grip_pistol" = 0)

/obj/item/gun/ballistic/shotgun/stalker
	modifications = list("barrel_shotgun" = 0, "frame_shotgun" = 0, "grip_shotgun" = 0)
	icon = 'stalker/icons/obj/projectile.dmi'
	lefthand_file = 'stalker/icons/obj/guns_lefthand.dmi'
	righthand_file = 'stalker/icons/obj/guns_righthand.dmi'
	can_suppress = FALSE
	can_unsuppress = FALSE

/obj/item/gun/ballistic/rifle/boltaction/stalker
	icon = 'stalker/icons/obj/projectile.dmi'
	lefthand_file = 'stalker/icons/obj/guns_lefthand.dmi'
	righthand_file = 'stalker/icons/obj/guns_righthand.dmi'
	can_suppress = FALSE
	can_unsuppress = FALSE

/obj/item/gun/ballistic/semiauto/stalker
	icon = 'stalker/icons/obj/projectile.dmi'
	lefthand_file = 'stalker/icons/obj/guns_lefthand.dmi'
	righthand_file = 'stalker/icons/obj/guns_righthand.dmi'
	can_suppress = FALSE
	can_unsuppress = FALSE

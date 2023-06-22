/atom/movable/screen/zone_sel
	name = "damage zone"
	icon = 'icons/stalker/hud/screen_stalker_zone_sel.dmi'
	icon_state = "zone_sel"
	screen_loc = ui_zonesel
	/// Whether or not we also behave as a health doll
	var/healthdoll = TRUE
	/// Stored healthdoll overlays
	var/list/healthdoll_overlays
	/// Icon that the hover overlay should use
	var/overlay_icon = 'icons/stalker/hud/screen_stalker_zone_sel.dmi'
	/// Cache of hover overlay objects
	var/static/list/hover_overlays_cache = list()
	/// Zone we are currently hovering over
	var/hovering

/obj/effect/overlay/zone_sel
	icon = 'icons/hud/screen_gen.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 128
	anchored = TRUE
	plane = ABOVE_HUD_PLANE

/atom/movable/screen/zone_sel/Click(location, control,params)
	if(isobserver(usr))
		return

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(iscarbon(usr))
			var/mob/living/carbon/carbon_user = usr
			carbon_user.check_self_for_injuries()
		return TRUE

	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/choice = get_zone_at(icon_x, icon_y)
	if(!choice)
		return TRUE

	return set_selected_zone(choice, usr)

/atom/movable/screen/zone_sel/MouseEntered(location, control, params)
	. = ..()
	MouseMove(location, control, params)

/atom/movable/screen/zone_sel/MouseMove(location, control, params)
	if(isobserver(usr))
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/choice = get_zone_at(icon_x, icon_y)

	if(hovering == choice)
		return

	for(var/cached_overlay in hover_overlays_cache)
		vis_contents -= hover_overlays_cache[cached_overlay]
	hovering = choice
	// Don't need to account for turf cause we're on the hud babyyy
	var/obj/effect/overlay/zone_sel/overlay_object = hover_overlays_cache["[overlay_icon]-[choice]"]
	if(!overlay_object)
		overlay_object = new
		overlay_object.icon = overlay_icon
		overlay_object.icon_state = "[choice]"
		hover_overlays_cache[choice] = overlay_object
	vis_contents += overlay_object

/atom/movable/screen/zone_sel/MouseExited(location, control, params)
	if(!isobserver(usr) && hovering)
		vis_contents -= hover_overlays_cache["[overlay_icon]-[hovering]"]
		hovering = null

/atom/movable/screen/zone_sel/proc/get_zone_at(icon_x, icon_y)
	switch(icon_y)
		if(6) //Legs
			switch(icon_x)
				if(8 to 14)
					return BODY_ZONE_R_LEG
				if(18 to 24)
					return BODY_ZONE_L_LEG
		if(7) //Legs
			switch(icon_x)
				if(9 to 14)
					return BODY_ZONE_R_LEG
				if(18 to 23)
					return BODY_ZONE_L_LEG
		if(8) //Legs
			switch(icon_x)
				if(11 to 13)
					return BODY_ZONE_R_LEG
				if(19 to 21)
					return BODY_ZONE_L_LEG
		if(9 to 12) //Legs
			switch(icon_x)
				if(12, 13)
					return BODY_ZONE_R_LEG
				if(19, 20)
					return BODY_ZONE_L_LEG
		if(13 to 15) //Legs
			switch(icon_x)
				if(12 to 14)
					return BODY_ZONE_R_LEG
				if(18 to 20)
					return BODY_ZONE_L_LEG
		if(16, 17) //Legs
			switch(icon_x)
				if(11 to 14)
					return BODY_ZONE_R_LEG
				if(18 to 21)
					return BODY_ZONE_L_LEG
		if(18, 19) //Legs
			switch(icon_x)
				if(11 to 13)
					return BODY_ZONE_R_LEG
				if(19 to 21)
					return BODY_ZONE_L_LEG
		if(20 to 24) //Legs
			switch(icon_x)
				if(11 to 14)
					return BODY_ZONE_R_LEG
				if(18 to 21)
					return BODY_ZONE_L_LEG
		if(25) //Legs
			switch(icon_x)
				if(11 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 21)
					return BODY_ZONE_L_LEG
		if(26) //Legs, arms
			switch(icon_x)
				if(7, 8)
					return BODY_ZONE_R_ARM
				if(11 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 21)
					return BODY_ZONE_L_LEG
				if(24, 25)
					return BODY_ZONE_L_ARM
		if(27) //Legs, arms
			switch(icon_x)
				if(7)
					return BODY_ZONE_R_ARM
				if(11 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 21)
					return BODY_ZONE_L_LEG
				if(25)
					return BODY_ZONE_L_ARM
		if(28) //Legs, arms
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_R_ARM
				if(11 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 21)
					return BODY_ZONE_L_LEG
				if(23 to 26)
					return BODY_ZONE_L_ARM
		if(29) //Legs, arms
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_R_ARM
				if(10 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 22)
					return BODY_ZONE_L_LEG
				if(23 to 26)
					return BODY_ZONE_L_ARM
		if(30) //Legs, arms
			switch(icon_x)
				if(6 to 8)
					return BODY_ZONE_R_ARM
				if(10 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 22)
					return BODY_ZONE_L_LEG
				if(24 to 26)
					return BODY_ZONE_L_ARM
		if(31) //Legs, groin, arms
			switch(icon_x)
				if(6 to 8)
					return BODY_ZONE_R_ARM
				if(10, 11)
					return BODY_ZONE_R_LEG
				if(12 to 20)
					return BODY_ZONE_PRECISE_GROIN
				if(21, 22)
					return BODY_ZONE_L_LEG
				if(24 to 26)
					return BODY_ZONE_L_ARM
		if(32 to 34) //Groin, arms
			switch(icon_x)
				if(6 to 8)
					return BODY_ZONE_R_ARM
				if(10 to 22)
					return BODY_ZONE_PRECISE_GROIN
				if(24 to 26)
					return BODY_ZONE_L_ARM
		if(35) //Groin, arms
			switch(icon_x)
				if(6 to 8)
					return BODY_ZONE_R_ARM
				if(11 to 21)
					return BODY_ZONE_PRECISE_GROIN
				if(24 to 26)
					return BODY_ZONE_L_ARM
		if(36 to 38) //Chest, arms
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_R_ARM
				if(11 to 21)
					return BODY_ZONE_CHEST
				if(23 to 26)
					return BODY_ZONE_L_ARM
		if(39, 40) //Chest, arms
			switch(icon_x)
				if(6 to 10)
					return BODY_ZONE_R_ARM
				if(11 to 21)
					return BODY_ZONE_CHEST
				if(22 to 26)
					return BODY_ZONE_L_ARM
		if(41, 42) //Chest, arms
			switch(icon_x)
				if(7 to 10)
					return BODY_ZONE_R_ARM
				if(11 to 21)
					return BODY_ZONE_CHEST
				if(22 to 25)
					return BODY_ZONE_L_ARM
		if(43 to 45) //Chest, arms
			switch(icon_x)
				if(7 to 9)
					return BODY_ZONE_R_ARM
				if(10 to 22)
					return BODY_ZONE_CHEST
				if(23 to 25)
					return BODY_ZONE_L_ARM
		if(46, 47) //Chest, arms
			switch(icon_x)
				if(8, 9)
					return BODY_ZONE_R_ARM
				if(10 to 22)
					return BODY_ZONE_CHEST
				if(23, 24)
					return BODY_ZONE_L_ARM
		if(48) //Chest, head
			switch(icon_x)
				if(10 to 14)
					return BODY_ZONE_CHEST
				if(15 to 17)
					return BODY_ZONE_HEAD
				if(18 to 24)
					return BODY_ZONE_CHEST
		if(49 to 51) //Head
			switch(icon_x)
				if(14 to 18)
					return BODY_ZONE_HEAD
		if(52) //Health, mouth
			switch(icon_x)
				if(6 to 8)
					return "health"
				if(14 to 18)
					return BODY_ZONE_PRECISE_MOUTH
		if(53) //Health, head, mouth
			switch(icon_x)
				if(6 to 8)
					return "health"
				if(13)
					return BODY_ZONE_HEAD
				if(14 to 18)
					return BODY_ZONE_PRECISE_MOUTH
				if(19)
					return BODY_ZONE_HEAD
		if(54) //Health, head, mouth
			switch(icon_x)
				if(4 to 10)
					return "health"
				if(13)
					return BODY_ZONE_HEAD
				if(14 to 18)
					return BODY_ZONE_PRECISE_MOUTH
				if(19)
					return BODY_ZONE_HEAD
		if(55, 56) //Health, head, eyes
			switch(icon_x)
				if(4 to 10)
					return "health"
				if(13)
					return BODY_ZONE_HEAD
				if(14 to 18)
					return BODY_ZONE_PRECISE_EYES
				if(19)
					return BODY_ZONE_HEAD
		if(57, 58) //Health, head
			switch(icon_x)
				if(6 to 8)
					return "health"
				if(13 to 19)
					return BODY_ZONE_HEAD
		if(59) //Head
			switch(icon_x)
				if(14 to 18)
					return BODY_ZONE_HEAD

/atom/movable/screen/zone_sel/proc/set_selected_zone(choice, mob/user, should_log = TRUE)
	if(user != hud?.mymob)
		return

	if(choice == "health")
		if(iscarbon(usr))
			var/mob/living/carbon/carbon_user = usr
			carbon_user.check_self_for_injuries()
		return TRUE

	if(choice != hud.mymob.zone_selected)
		if(should_log)
			hud.mymob.log_manual_zone_selected_update("screen_hud", new_target = choice)
		hud.mymob.zone_selected = choice
		SEND_SIGNAL(user, COMSIG_MOB_SELECTED_ZONE_SET, choice)
		update_appearance()

	return TRUE

/atom/movable/screen/zone_sel/update_overlays()
	. = ..()
	if(!hud?.mymob)
		return
	if(length(healthdoll_overlays))
		. += healthdoll_overlays
	. += mutable_appearance(overlay_icon, "[hud.mymob.zone_selected]")

/atom/movable/screen/zone_sel/alien
	icon = 'icons/hud/screen_alien.dmi'
	overlay_icon = 'icons/hud/screen_alien.dmi'

/atom/movable/screen/zone_sel/alien/get_zone_at(icon_x, icon_y)
	switch(icon_y)
		if(1 to 9) //Legs
			switch(icon_x)
				if(10 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 22)
					return BODY_ZONE_L_LEG
		if(10 to 13) //Hands and groin
			switch(icon_x)
				if(8 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_PRECISE_GROIN
				if(21 to 24)
					return BODY_ZONE_L_ARM
		if(14 to 22) //Chest and arms to shoulders
			switch(icon_x)
				if(8 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_CHEST
				if(21 to 24)
					return BODY_ZONE_L_ARM
		if(23 to 30) //Head, but we need to check for eye or mouth
			if(icon_x in 12 to 20)
				switch(icon_y)
					if(23 to 24)
						if(icon_x in 15 to 17)
							return BODY_ZONE_PRECISE_MOUTH
					if(26) //Eyeline, eyes are on 15 and 17
						if(icon_x in 14 to 18)
							return BODY_ZONE_PRECISE_EYES
					if(25 to 27)
						if(icon_x in 15 to 17)
							return BODY_ZONE_PRECISE_EYES
				return BODY_ZONE_HEAD

/atom/movable/screen/zone_sel/robot
	icon = 'icons/hud/screen_cyborg.dmi'

/atom/movable/screen/zone_sel/robot/get_zone_at(icon_x, icon_y)
	switch(icon_y)
		if(1 to 9) //Legs
			switch(icon_x)
				if(10 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 22)
					return BODY_ZONE_L_LEG
		if(10 to 13) //Hands and groin
			switch(icon_x)
				if(8 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_PRECISE_GROIN
				if(21 to 24)
					return BODY_ZONE_L_ARM
		if(14 to 22) //Chest and arms to shoulders
			switch(icon_x)
				if(8 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_CHEST
				if(21 to 24)
					return BODY_ZONE_L_ARM
		if(23 to 30) //Head, but we need to check for eye or mouth
			if(icon_x in 12 to 20)
				switch(icon_y)
					if(23 to 24)
						if(icon_x in 15 to 17)
							return BODY_ZONE_PRECISE_MOUTH
					if(26) //Eyeline, eyes are on 15 and 17
						if(icon_x in 14 to 18)
							return BODY_ZONE_PRECISE_EYES
					if(25 to 27)
						if(icon_x in 15 to 17)
							return BODY_ZONE_PRECISE_EYES
				return BODY_ZONE_HEAD

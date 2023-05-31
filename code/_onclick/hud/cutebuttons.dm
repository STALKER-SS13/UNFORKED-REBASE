/atom/movable/screen/cutedecor
	name = "cute decor"
	icon = 'icons/stalker/hud/screen_stalker.dmi'
	icon_state = "cutedecor"
	screen_loc = ui_cutedecor

/atom/movable/screen/craft
	name = "crafting menu"
	icon = 'icons/stalker/hud/screen_stalker.dmi'
	icon_state = "craft"
	screen_loc = ui_crafting

/atom/movable/screen/area_creator
	name = "create new area"
	icon = 'icons/stalker/hud/screen_stalker.dmi'
	icon_state = "area_edit"
	screen_loc = ui_building

/atom/movable/screen/area_creator/Click(location, control, params)
	if(usr.incapacitated() || (isobserver(usr) && !isAdminGhostAI(usr)))
		return TRUE
	var/area/A = get_area(usr)
	if(!A.outdoors)
		to_chat(usr, span_warning("There is already a defined structure here."))
		return TRUE
	create_area(usr)

/atom/movable/screen/language_menu
	name = "language menu"
	icon = 'icons/stalker/hud/screen_stalker.dmi'
	icon_state = "talk_wheel"
	screen_loc = ui_language_menu

/atom/movable/screen/language_menu/Click(location, control, params)
	var/mob/M = usr
	var/datum/language_holder/H = M.get_language_holder()
	H.open_language_menu(usr)

/atom/movable/screen/lookup
	name = "look up"
	icon = 'icons/stalker/hud/screen_stalker.dmi'
	icon_state = "level"
	screen_loc = ui_lookup

/atom/movable/screen/lookup/Click(location, control, params)
	var/mob/living/user = usr
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		user.look_down()
	else
		user.look_up()

/atom/movable/screen/navigate
	name = "navigate"
	icon = 'icons/hud/screen_midnight.dmi'
	icon_state = "navigate"
	screen_loc = ui_navigate_menu

/atom/movable/screen/navigate/Click()
	if(!isliving(usr))
		return TRUE
	var/mob/living/navigator = usr
	navigator.navigate()

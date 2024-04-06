/atom/movable/screen/cutedecor
	name = "cute decor"
	icon = 'stalker/icons/hud/screen_stalker.dmi'
	icon_state = "cutedecor"
	screen_loc = ui_cutedecor

/atom/movable/screen/craft
	name = "crafting menu"
	icon = 'stalker/icons/hud/screen_stalker.dmi'
	icon_state = "craft"
	screen_loc = ui_crafting

/atom/movable/screen/area_creator
	name = "create new area"
	icon = 'stalker/icons/hud/screen_stalker.dmi'
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
	icon = 'stalker/icons/hud/screen_stalker.dmi'
	icon_state = "talk_wheel"
	screen_loc = ui_language_menu

/atom/movable/screen/language_menu/Click(location, control, params)
	var/mob/M = usr
	var/datum/language_holder/H = M.get_language_holder()
	H.open_language_menu(usr)

/atom/movable/screen/floor_menu
	name = "look up/down"
	icon = 'stalker/icons/hud/screen_stalker.dmi'
	icon_state = "level"
	screen_loc = ui_floor_menu

/atom/movable/screen/floor_menu/Initialize(mapload)
	. = ..()
	register_context()

/atom/movable/screen/floor_menu/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_LMB] = "Go up a floor"
	context[SCREENTIP_CONTEXT_RMB] = "Go down a floor"
	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/floor_menu/Click(location,control,params)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK))
		usr.down()
		return

	usr.up()
	return

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

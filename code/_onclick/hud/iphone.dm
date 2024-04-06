/atom/movable/screen/iphone
	name = "iphone"
	icon = 'stalker/icons/hud/screen_stalker.dmi'
	icon_state = "iphone"
	screen_loc = ui_iphone
	COOLDOWN_DECLARE(ding)

/atom/movable/screen/iphone/Click(location, control, params)
	. = ..()
	if(!COOLDOWN_FINISHED(src, ding))
		return
	COOLDOWN_START(src, ding, 2 SECONDS)
	
	//Ding!
	to_chat(usr, span_nicegreen("Ding!"))
	usr.playsound_local(get_turf(usr), 'sound/stalker/autism/iphone_ding.ogg', 60, vary = FALSE)

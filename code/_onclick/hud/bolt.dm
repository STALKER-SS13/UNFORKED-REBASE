/atom/movable/screen/bolt
	name = "bolt"
	icon = 'icons/hud/screen_midnight.dmi'
	icon_state = "bolt"
	COOLDOWN_DECLARE(cooldown)

/atom/movable/screen/bolt/Click(location, control, params)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	if(!iscarbon(usr))
		return
	var/mob/living/carbon/user = usr
	if(user.incapacitated())
		return
	var/obj/item/bolt/bolt = new(get_turf(user), TRUE)
	if(!user.put_in_hands(bolt))
		qdel(bolt)
	else
		user.throw_mode_on()

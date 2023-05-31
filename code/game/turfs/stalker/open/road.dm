/turf/open/misc/road
	name = "road"
	desc = "An old road."
	icon = 'icons/stalker/turfs/road.dmi'
	icon_state = "road"
	base_icon_state = "road"
	var/random_icon_states = 5

/turf/open/misc/road/Initialize(mapload)
	. = ..()
	if(!random_icon_states)
		return
	icon_state = "[base_icon_state][rand(1, random_icon_states)]"

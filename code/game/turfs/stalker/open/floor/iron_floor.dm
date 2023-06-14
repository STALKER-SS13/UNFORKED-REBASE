/turf/open/floor/iron
	// used by subtypes
	var/random_icon_states = 0

/turf/open/floor/iron/Initialize(mapload)
	. = ..()
	if(!random_icon_states)
		return
	icon_state = "[base_icon_state][rand(1, random_icon_states)]"

/turf/open/floor/iron/plita
	icon = 'icons/stalker/turf/floor.dmi'
	icon_state = "plita"
	base_icon_state = "plita"
	random_icon_states = 4

/turf/open/floor/iron/plita/orange
	icon = 'icons/stalker/turf/floor.dmi'
	icon_state = "plita_or"
	base_icon_state = "plita_or"
	random_icon_states = 9

/turf/open/floor/iron/plitka
	icon = 'icons/stalker/turf/floor.dmi'
	icon_state = "plitka"
	base_icon_state = "plitka"
	random_icon_states = 8

/turf/open/floor/iron/plitka/old
	icon = 'icons/stalker/turf/floor.dmi'
	icon_state = "plitka_old"
	base_icon_state = "plitka_old"
	random_icon_states = 8

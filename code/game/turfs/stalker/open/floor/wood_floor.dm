/turf/open/floor/wood/stalker
	icon = 'icons/stalker/turf/floor.dmi'
	icon_state = "wooden_floor1"
	base_icon_state = "wooden_floor1"

/turf/open/floor/wood/stalker/grey
	icon_state = "wooden_floor2"
	base_icon_state = "wooden_floor2"

/turf/open/floor/wood/stalker/black
	icon_state = "wooden_floor3"
	base_icon_state = "wooden_floor3"

/turf/open/floor/wood/stalker/fucked
	icon = 'icons/stalker/turf/floor.dmi'
	icon_state = "wood"
	base_icon_state = "wood"

/turf/open/floor/wood/stalker/fucked/Initialize(mapload)
	. = ..()
	if(prob(50))
		return
	icon_state = "[base_icon_state][rand(1, 12)]"

/turf/open/floor/wood/stalker/fucked/vertical
	icon_state = "woodd"
	base_icon_state = "woodd"

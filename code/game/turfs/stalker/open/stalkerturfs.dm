#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"

/turf/open/floor/plating/asteroid/snow/lite
	name = "snow"
	desc = "Looks cold."
	icon = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/snow
	icon_state = "snow"
	//icon_plating = "snow"
	temperature = 293
	slowdown = 4


/obj/structure/grille/stalker
	desc = "Strong iron fence."
	name = "fence"
	icon = 'stalker/icons/structure.dmi'
	icon_state = "fence1"
	density = 1
	anchored = 1
	flags_1 = CONDUCT_1
	layer = CLOSED_DOOR_LAYER
	max_integrity = 10000000

/obj/structure/grille/stalker/wood
	desc = "Old wooden fence."
	icon_state = "zabor_horizontal1"
	density = 1
	opacity = 1

/obj/structure/grille/stalker/beton
	icon = 'stalker/icons/beton_zabor.dmi'
	desc = "Too strong."
	icon_state = "1"
	density = 1
	opacity = 1

/obj/structure/grille/stalker/beton/green
	icon = 'stalker/icons/green_zabor.dmi'
	desc = "Green fence. Better than gray."
	icon_state = "1"

/turf/open/stalker
	name = "stalker turf"
	icon = 'stalker/icons/grass.dmi'
	planetary_atmos = TRUE


	//light_range = 3

/turf/open/stalker/floor
	name = "grass"
	icon = 'stalker/icons/grass.dmi'
	icon_state = "grass1"
	layer = TURF_LAYER
	//overlay_priority = 0


/turf/open/stalker/floor/digable/grass
	icon = 'stalker/icons/zemlya.dmi'
	icon_state = "grass1"

/turf/open/stalker/floor/digable/grass/dump
	icon = 'stalker/icons/zemlya.dmi'
	icon_state = "dump_grass1"

/turf/open/stalker/floor/digable/grass/dump/New()
	icon_state = "dump_grass[rand(1, 3)]"

/turf/open/stalker/floor/digable/gryaz_rocky
	name = "rocky dirt"
	icon = 'stalker/icons/zemlya.dmi'
	icon_state = "gryaz_rocky1"

/turf/open/stalker/floor/sidor
	name = "floor"
	icon = 'stalker/icons/beton.dmi'
	icon_state = "sidorpol"

/obj/machinery/door/unpowered/stalker
	icon = 'stalker/icons/beton.dmi'

/turf/open/stalker/floor/asphalt
	name = "road"
	icon = 'stalker/icons/Prishtina/asphalt.dmi'
	icon_state = "road1"
	layer = MID_TURF_LAYER
	//overlay_priority = 1

/turf/open/stalker/floor/digable/swamp
	icon = 'stalker/icons/zemlya.dmi'
	icon_state = "swamp_grass1"

/turf/open/stalker/floor/tropa
	name = "road"
	icon = 'stalker/icons/tropa.dmi'
	icon_state = "tropa"

	//overlay_priority = 2

/turf/open/stalker/floor/road
	name = "road"
	icon = 'stalker/icons/building_road.dmi'
	icon_state = "road2"
	layer = MID_TURF_LAYER
	//overlay_priority = 3

var/global/list/WhiteRoadCache

/turf/open/stalker/floor/road/New()
	switch(rand(1, 100))
		if(1 to 65)
			icon_state = "road2"
		if(66 to 85)
			icon_state = "road1"
		if(86 to 90)
			icon_state = "road3"
		if(91 to 95)
			icon_state = "road4"
		if(96 to 100)
			icon_state = "road5"

	if(!WhiteRoadCache || !WhiteRoadCache.len)
		WhiteRoadCache = list()
		WhiteRoadCache.len = 10
		WhiteRoadCache[NORTH] = image('stalker/icons/warning_stripes.dmi', "road_b5", layer = HIGH_TURF_LAYER)
		WhiteRoadCache[SOUTH] = image('stalker/icons/warning_stripes.dmi', "road_b6", layer = HIGH_TURF_LAYER)
		WhiteRoadCache[EAST] = image('stalker/icons/warning_stripes.dmi', "road_b8", layer = HIGH_TURF_LAYER)
		WhiteRoadCache[WEST] = image('stalker/icons/warning_stripes.dmi', "road_b7", layer = HIGH_TURF_LAYER)

	spawn(1)
		for(var/i = 0, i <= 3, i++)
			if(!get_step(src, 2**i) || (!istype(get_step(src, 2**i), src.type) && (src.layer > get_step(src, 2**i).layer)))
				src.overlays += WhiteRoadCache[2**i]

	return

/turf/open/stalker/floor/gryaz
	name = "dirt"
	icon = 'stalker/icons/zemlya.dmi'
	icon_state = "gryaz1"
	//overlay_priority = 4

/turf/open/stalker/floor/gryaz/gryaz2
	icon_state = "gryaz2"

/turf/open/stalker/floor/gryaz/gryaz3
	icon_state = "gryaz3"

/obj/structure/stalker/rails
	name = "rails"
	icon = 'stalker/icons/rails.dmi'
	icon_state = "sp"
	layer = MID_TURF_LAYER
	anchored = 1
	density = 0
	opacity = 0

/turf/open/stalker/floor/plasteel
	name = "floor"
	icon = 'stalker/icons/floor.dmi'

/turf/open/stalker/floor/plasteel/plita
	icon_state = "plita1"

/turf/open/stalker/floor/plasteel/plita/New()
	icon_state = "plita[rand(1, 4)]"

/turf/open/stalker/floor/plasteel/plitochka
	icon_state = "plitka1"

/turf/open/stalker/floor/plasteel/plitochka/New()
	icon_state = "plitka[rand(1, 7)]"

/turf/open/stalker/floor/plasteel/plitka
	icon_state = "plitka_old1"

/turf/open/stalker/floor/plasteel/plitka/New()
	icon_state = "plitka_old[rand(1, 8)]"

/turf/open/stalker/floor/water
	name = "water"
	icon = 'stalker/icons/water.dmi'

	var/smooth_icon = 'stalker/icons/smoothwater.dmi'
	icon_state = "water"
	layer = HIGH_TURF_LAYER
	var/busy = 0
	slowdown = 2

/turf/open/stalker/floor/wood
	icon = 'stalker/icons/floor.dmi'
	name = "floor"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD
	clawfootstep = FOOTSTEP_WOOD_CLAW

/turf/open/stalker/floor/wood/brown
	icon_state = "wooden_floor"

/turf/open/stalker/floor/wood/grey
	icon_state = "wooden_floor2"

/turf/open/stalker/floor/wood/black
	icon_state = "wooden_floor3"

/turf/open/stalker/floor/wood/oldgor
	icon_state = "wood1"

/turf/open/stalker/floor/wood/oldgor/New()
	switch(rand(1, 100))
		if(1 to 5)
			icon_state = "wood1"
		if(6 to 11)
			icon_state = "wood2"
		if(12 to 17)
			icon_state = "wood13"
		if(18 to 23)
			icon_state = "wood14"
		if(24 to 29)
			icon_state = "wood15"
		if(30 to 35)
			icon_state = "wood16"
		if(36 to 41)
			icon_state = "wood17"
		if(42 to 47)
			icon_state = "wood18"
		if(48 to 53)
			icon_state = "wood19"
		if(54 to 54)
			icon_state = "wood20"
		if(55 to 57)
			icon_state = "wood21"
		if(58 to 60)
			icon_state = "wood22"
		if(61 to 63)
			icon_state = "wood23"
		if(64 to 66)
			icon_state = "wood24"
		if(67 to 69)
			icon_state = "wood25"
		if(70 to 82)
			icon_state = "wood3"
		if(83 to 84)
			icon_state = "wood4"
		if(85 to 86)
			icon_state = "wood5"
		if(87 to 88)
			icon_state = "wood6"
		if(89 to 90)
			icon_state = "wood7"
		if(91 to 92)
			icon_state = "wood8"
		if(93 to 94)
			icon_state = "wood9"
		if(95 to 96)
			icon_state = "wood10"
		if(97 to 98)
			icon_state = "wood11"
		if(99 to 100)
			icon_state = "wood12"

/turf/open/stalker/floor/wood/oldvert
	icon_state = "woodd1"

/turf/open/stalker/floor/wood/oldvert/New()
	icon_state = "woodd[rand(1, 70)]"

/turf/open/stalker/floor/agroprom/beton
	name = "floor"
	icon = 'stalker/icons/pol_agroprom.dmi'
	icon_state = "beton1"

/turf/open/stalker/floor/agroprom/beton/New()
	icon_state = "beton[rand(1, 4)]"

/turf/open/stalker/floor/agroprom/gryaz
	name = "dirt"
	icon = 'stalker/icons/pol_agroprom.dmi'
	icon_state = "gryaz1"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS

/turf/open/stalker/floor/agroprom/gryaz/New()
	icon_state = "gryaz[rand(1, 11)]"

/turf/open/stalker/floor/lattice
	name = "lattice"
	icon = 'stalker/icons/floor.dmi'
	icon_state = "lattice_new1"


/turf/open/stalker/floor/lattice/New()
	icon_state = "lattice_new[rand(1, 21)]"

/turf/open/stalker/floor/lattice/brokeone
	name = "lattice"
	icon = 'stalker/icons/floor.dmi'
	icon_state = "lattice1"

/turf/open/stalker/floor/lattice/brokeone/New()
	icon_state = "lattice[rand(1, 4)]"

/turf/open/stalker/floor/lattice/broketwo
	name = "lattice"
	icon = 'stalker/icons/floor.dmi'
	icon_state = "lattice2_1"

/turf/open/stalker/floor/lattice/broketwo/New()
	icon_state = "lattice2_[rand(1, 7)]"

/turf/open/stalker/floor/plasteel/plita/orange
	icon_state = "plita_or1"

/turf/open/stalker/floor/plasteel/plita/orange/New()
	icon_state = "plita_or[rand(1, 9)]"
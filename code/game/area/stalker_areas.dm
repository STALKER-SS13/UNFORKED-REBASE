/area/stalker
	name = "Strange Location"
	icon = 'icons/stalker/areas/areas.dmi'
	icon_state = "away"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	sound_environment = SOUND_ENVIRONMENT_CITY
	/// If this is a safezone, mobs will get the pacifist trait upon entering
	var/safezone = FALSE

/area/stalker/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	if(isliving(arrived))
		ADD_TRAIT(arrived, TRAIT_PACIFISM, AREA_TRAIT)
		to_chat(arrived, span_notice("You are now in a safe zone. You will not be able to attack other stalkers."))

/area/stalker/Exited(atom/movable/gone, direction)
	. = ..()
	if(isliving(gone))
		REMOVE_TRAIT(gone, TRAIT_PACIFISM, AREA_TRAIT)
		to_chat(gone, span_notice("You are out of the safe zone. You will be able to attack other stalkers."))

/area/stalker/blowout

/area/stalker/blowout/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	if(isliving(arrived))
		if(!HAS_TRAIT(arrived, TRAIT_BLOWOUT_SUSCEPTIBLE))
			if(SSblowouts.blowout_stage)
				to_chat(arrived, span_danger(span_big("You are being affected by the emission!")))
			else
				to_chat(arrived, span_warning("You are now susceptible to emissions."))
		ADD_TRAIT(arrived, TRAIT_BLOWOUT_SUSCEPTIBLE, AREA_TRAIT)

/area/stalker/blowout/Exited(atom/movable/gone, direction)
	. = ..()
	if(isliving(gone))
		REMOVE_TRAIT(gone, TRAIT_BLOWOUT_SUSCEPTIBLE, AREA_TRAIT)
		if(!HAS_TRAIT(gone, TRAIT_BLOWOUT_SUSCEPTIBLE))
			if(SSblowouts.blowout_stage)
				to_chat(gone, span_notice(span_big("You are now safe from emissions.")))
			else
				to_chat(gone, span_notice("You are now safe from emissions."))

/area/stalker/blowout/outdoors
	name = "Outdoors"
	icon = 'icons/stalker/areas/areas_outdoor_blowout.dmi'
	icon_state = "outdoor"

/area/stalker/blowout/buildings
	name = "Buildings"
	icon = 'icons/stalker/areas/areas_buildings_blowout.dmi'
	icon_state = "buildings"
	requires_power = TRUE

/area/stalker/buildings
	name = "Buildings"
	icon = 'icons/stalker/areas/areas_buildings.dmi'
	icon_state = "buildings"
	requires_power = TRUE

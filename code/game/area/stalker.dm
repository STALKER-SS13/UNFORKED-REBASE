/area/stalker

/area/stalker/blowout/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	if(isliving(arrived))
		if(!HAS_TRAIT(arrived, TRAIT_BLOWOUT_SUSCEPTIBLE))
			if(SSblowouts.blowout_stage)
				to_chat(arrived, span_danger(span_big("You are now being affected by the emission!")))
			else
				to_chat(arrived, span_warning(span_big("You are now susceptible to emissions.")))
		ADD_TRAIT(arrived, TRAIT_BLOWOUT_SUSCEPTIBLE, AREA_TRAIT)

/area/stalker/blowout/Exited(atom/movable/gone, direction)
	. = ..()
	if(isliving(gone))
		REMOVE_TRAIT(gone, TRAIT_BLOWOUT_SUSCEPTIBLE, AREA_TRAIT)
		if(!HAS_TRAIT(gone, TRAIT_BLOWOUT_SUSCEPTIBLE))
			to_chat(gone, span_notice(span_big("You are now safe from emissions.")))

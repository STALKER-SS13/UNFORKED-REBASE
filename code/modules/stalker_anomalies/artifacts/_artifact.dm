GLOBAL_LIST_EMPTY(all_artifacts)

/obj/item/artifact
	name = "artifact"
	desc = "Simple artifact."
	icon = 'icons/stalker/artifacts.dmi'
	w_class = WEIGHT_CLASS_SMALL
	invisibility = INVISIBILITY_ARTIFACT
	/// Current charge
	var/charge = 0
	/// Maximum charge
	var/maxcharge = 1000
	/// Amounts of rads we apply to user on process
	var/rads_amount = 2
	/// Artifact level, higher = better
	var/artifact_level = 1
	/// Effect used for detectors to detect us
	var/obj/effect/abstract/artifact/phantom
	/// Artifact armor we apply to the user when worn
	var/datum/armor/artifact_armor

/obj/item/artifact/Initialize(mapload)
	. = ..()
	GLOB.all_artifacts += src
	maxcharge = rand(1000, 10000)
	charge = maxcharge
	phantom = new(src)
	if(artifact_armor)
		artifact_armor = get_armor_by_type(artifact_armor)

/obj/item/artifact/Destroy(force)
	. = ..()
	GLOB.all_artifacts -= src
	artifact_armor = null
	if(phantom)
		QDEL_NULL(phantom)

/obj/item/artifact/proc/handle_user(mob/living/user, seconds_per_tick = 2)
	if(!charge)
		return FALSE
	return TRUE

/* radiation unfuckening pending, i hate you tg
/obj/item/artifact/proc/Think(mob/user)
	if(!charge)
		return 0
	if(istype(user, /mob/living/carbon))
		var/mob/living/carbon/mob = user
		if(istype(loc, user))
			mob.radiation = max(0, mob.radiation + radiation)

		else if(istype(loc, /obj/item/storage))
			mob.radiation = max(0, mob.radiation + radiation)

		return art_armor
	return 0
*/

/obj/effect/abstract/artifact
	name = "artifact"
	desc = "An artifact, must have been created by an anomaly."
	density = FALSE
	anchored = TRUE
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	layer = ABOVE_ALL_MOB_LAYER
	/// Artifact we belong to
	var/obj/item/artifact/owner
	/// Image copying our owner
	var/image/owner_image

/obj/effect/abstract/artifact/Initialize(mapload, obj/item/artifact/new_owner)
	. = ..()
	if(!new_owner)
		return INITIALIZE_HINT_QDEL
	owner = new_owner
	owner_image = image(owner)
	owner_image.loc = src
	owner_image.override = TRUE

/obj/effect/abstract/artifact/Destroy(force)
	. = ..()
	owner = null
	owner_image = null

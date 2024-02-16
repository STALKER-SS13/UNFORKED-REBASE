/obj/item/attachment
	icon = 'stalker/icons/weapon_mods.dmi'
	var/list/types = list()
	w_class = WEIGHT_CLASS_SMALL

/obj/item/attachment/proc/attach(obj/item/gun/ballistic/gun)
	var/mob/living/carbon/human/user = usr
	if(!istype(user) || !istype(gun))
		return
	if(!(gun.type in types))
		to_chat(user, span_warning("You don't know how to set [src] to [gun]!"))
		return
	if(loc != user)
		to_chat(user, span_warning("You need to hold in your hands [src]!"))
		return
	if(!user.transferItemToLoc(src, gun))
		to_chat(user, span_warning("\The [src] is stuck to your hand, you cannot put it in the [gun]!"))
		return

	to_chat(user, span_notice("You have screwed [src] onto [gun]."))
	playsound (src.loc, 'stalker/sound/weapons/attach_addon.ogg', 50, 1, 0)
	gun.update_icon()
	gun.addons |= src
	return TRUE


/obj/item/attachment/proc/detach(obj/item/gun/ballistic/gun)
	var/mob/living/carbon/human/user = usr
	if(!istype(user) || !istype(gun))
		return
	if(gun.loc != user)
		to_chat(user, "You need to hold [gun] in your hands to detach addons from it.")
		return

	to_chat(user, span_notice("You detach [src] from [gun]."))
	playsound(gun, 'stalker/sound/weapons/detach_addon.ogg', 50, 1, 0)
	user.put_in_hands(src)
	gun.addons.Remove(src)
	return TRUE


/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/attachment))
		var/obj/item/attachment/addon = A
		addon.attach(src)
		return
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/attachment))
		var/obj/item/attachment/addon = A
		addon.attach(src)
		return
	return ..()

/obj/item/gun/ballistic/verb/remove_attachment()
	set src in usr
	set category = "Object"
	set name = "Remove Addon"

	if(usr.stat || usr.incapacitated() || loc != usr || !length(addons))
		return

	if(length(addons) > 1)
		var/obj/item/attachment/A = tgui_input_list(usr, "Choose what you want to remove.", "Remove addon", addons)
		A.detach(src)
	else
		var/obj/item/attachment/A = addons[1]
		A.detach(src)
	update_icon()
	return

/obj/item/attachment/suppressor
	name = "suppressor"
	desc = "A universal suppressor."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "suppressor"
	types = list(/obj/item/gun/ballistic/automatic/stalker/pistol/pm,
				/obj/item/gun/ballistic/automatic/stalker/pistol/fort12,
				/obj/item/gun/ballistic/automatic/stalker/pistol/marta,
				/obj/item/gun/ballistic/automatic/stalker/pistol/sip,
				/obj/item/gun/ballistic/automatic/stalker/pistol/cora,
				/obj/item/gun/ballistic/automatic/stalker/pistol/usp_match,
				/obj/item/gun/ballistic/automatic/stalker/mp5,
				/obj/item/gun/ballistic/automatic/stalker/groza,
				/obj/item/gun/ballistic/automatic/stalker/ak74,
				/obj/item/gun/ballistic/automatic/stalker/aksu74,
				/obj/item/gun/ballistic/automatic/stalker/abakan,
				/obj/item/gun/ballistic/automatic/stalker/tpc301,
				/obj/item/gun/ballistic/automatic/stalker/kiparis,
				/obj/item/gun/ballistic/automatic/stalker/p90,
				/obj/item/gun/ballistic/automatic/stalker/m16,
				/obj/item/gun/ballistic/automatic/stalker/m16a4,
				/obj/item/gun/ballistic/automatic/stalker/m4)

/obj/item/attachment/suppressor/attach(obj/item/gun/gun)
	if(gun.suppressed)
		to_chat(usr, span_warning("Silencer is already installed on [gun]!"))
		return
	. = ..()
	if(!.)
		return

	gun.suppressed = src
	gun.update_icon()

/obj/item/attachment/suppressor/detach(obj/item/gun/gun)

	. = ..()
	if(!.)
		return

	gun.suppressed = FALSE
	gun.update_icon()

/obj/item/attachment/scope
	name = "scope"
	desc = "A universal scope."
	icon = 'stalker/icons/weapon_mods.dmi'
	icon_state = "susat"
	var/zoom_add = 2

/obj/item/attachment/scope/attach(obj/item/gun/ballistic/gun)
	if(gun.scoped)
		to_chat(usr, span_warning("Scope is already installed on [gun]!"))
		return
	. = ..()
	if(!.)
		return

	gun.scoped = TRUE
	gun.init_zoom()
	gun.update_icon()


/obj/item/attachment/scope/detach(obj/item/gun/ballistic/gun)
	. = ..()

	gun.scoped = FALSE
	gun.reset_zoom()
	gun.update_icon()

/obj/item/attachment/scope/susat
	name = "SUSAT"
	desc = "A 4x fixed zoom scope produced primarily in Western countries. Attached to weapons by means of the NATO-standard Picatinny rail. Often used for accurate fire from small arms at medium to long range."
	icon = 'stalker/icons/weapon_mods.dmi'
	icon_state = "susat"
	types = list(/obj/item/gun/ballistic/automatic/stalker/tpc301,
				/obj/item/gun/ballistic/automatic/stalker/mp5,
				/obj/item/gun/ballistic/automatic/stalker/sigsg550,
				/obj/item/gun/ballistic/automatic/stalker/p90)
	zoom_add = 4

/obj/item/attachment/scope/psu
	name = "PSU-1"
	desc = "Fixed magnification optical sight (2.7 diopters). Optimized for mid-range combat as well as urban use. For installation on the weapon, the dovetail mount, standard in the Warsaw Pact countries, is used."
	icon_state = "PSU1"
	types = list(/obj/item/gun/ballistic/automatic/stalker/aksu74,
				/obj/item/gun/ballistic/automatic/stalker/ak74,
				/obj/item/gun/ballistic/automatic/stalker/akm,
				/obj/item/gun/ballistic/automatic/stalker/abakan,
				/obj/item/gun/ballistic/automatic/stalker/val,
				/obj/item/gun/ballistic/automatic/stalker/groza)
	zoom_add = 3

/obj/item/attachment/scope/pso
	name = "PSO-1"
	desc = "A widespread Soviet-made fixed-magnification optical sight (5). Equipped with a scale for determining the range to the target. For installation on the weapon, the dovetail mount, standard in the Warsaw Pact countries, is used."
	icon_state = "PSO1"
	types = list(/obj/item/gun/ballistic/automatic/stalker/aksu74,
				/obj/item/gun/ballistic/automatic/stalker/ak74,
				/obj/item/gun/ballistic/automatic/stalker/akm,
				/obj/item/gun/ballistic/automatic/stalker/abakan,
				/obj/item/gun/ballistic/automatic/stalker/val,
				/obj/item/gun/ballistic/automatic/stalker/groza)
	zoom_add = 5

/obj/item/attachment/scope/rifle
	name = "rifle scope"
	desc = "A rifle scope designed some time around the advent of WWII."
	icon_state = "rifle"
	types = list(/obj/item/gun/ballistic/rifle/boltaction/stalker/enfield,
				/obj/item/gun/ballistic/rifle/boltaction/stalker/mosin,
				/obj/item/gun/ballistic/shotgun/stalker/bm16,
				/obj/item/gun/ballistic/shotgun/stalker/bm16/toz34,
				/obj/item/gun/ballistic/automatic/stalker/fnfal,
				/obj/item/gun/ballistic/automatic/stalker/woodfnfal,
				/obj/item/gun/ballistic/automatic/stalker/m14)
	zoom_add = 6

/obj/item/attachment/scope/fnf2000
	name = "FN-F2000 scope"
	desc = "Sight for the FN-F2000 rifle."
	icon_state = "fnf2000-scope"
	types = list(/obj/item/gun/ballistic/automatic/stalker/fnf2000)


/*
/obj/item/attachment/grenadelauncher
	name = "grenade launcher"
	desc = "A grenade launcher to be mounted on an underslung rail or other mounting system."
	icon_state = ""
	types = list()

/obj/item/attachment/grenadelauncher/fnf2000
	name = "fn-f2000 grenade launcher"
	desc = "A grenade launcher to be mounted on the FN-F2000's mounting system."
	icon_state = "fnf2000-gl"
*/

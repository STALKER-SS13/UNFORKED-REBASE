/obj/item/t_scanner/artifact_detector
	name = "artifact detector"
	desc = "The cheapest and least effective detector."
	icon = 'icons/stalker/device.dmi'
	icon_state = "echo_off"
	worn_icon_state = "electronic"
	w_class = WEIGHT_CLASS_SMALL
	var/icon_state_active = "echo_on"
	var/icon_state_target = "echo_target"
	var/range = 7
	var/artifact_level = 0
	COOLDOWN_DECLARE(cooldown)
	var/cooldown_duration = 4 SECONDS
	var/list/active_images

/obj/item/t_scanner/artifact_detector/attack_self(mob/user)
	. = ..()
	playsound(src, "sound/stalker/detector/detector_draw.ogg", vol = 50, vary = FALSE)

/obj/item/t_scanner/artifact_detector/toggle_on()
	on = !on
	if(on)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/t_scanner/artifact_detector/update_icon_state()
	. = ..()
	icon_state = (on ? icon_state_active : initial(icon_state))

/obj/item/t_scanner/artifact_detector/equipped(mob/user, slot, initial)
	. = ..()
	user.client?.images += active_images

/obj/item/t_scanner/artifact_detector/dropped(mob/user, silent)
	. = ..()
	user.client?.images -= active_images

/obj/item/t_scanner/artifact_detector/scan()
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, cooldown_duration)
	var/mob/user
	if(ismob(loc))
		user = loc
		if(!user.client)
			user = null
		else
			user.client.images -= active_images
	active_images = list()
	var/smallest_artifact_distance
	var/dir_to_artifact
	for(var/obj/item/artifact/artifact in range(range, src))
		if(artifact.artifact_level > artifact_level)
			continue
		var/dist = get_dist(src, artifact)
		if(isnull(smallest_artifact_distance) || (dist < smallest_artifact_distance))
			smallest_artifact_distance = get_dist(src, artifact)
			dir_to_artifact = get_dir(src, artifact)
		active_images += artifact.detector_appearance
	if(user)
		user.client.images += active_images
	if(isnull(smallest_artifact_distance))
		icon_state = icon_state_active
	else
		playsound(user, "sound/stalker/detector/contact_1.ogg", vol = 50, vary = FALSE)
		icon_state = icon_state_target
		dir = dir_to_artifact

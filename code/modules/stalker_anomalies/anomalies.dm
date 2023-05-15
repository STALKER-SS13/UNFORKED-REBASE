/obj/effect/zona_anomaly/electro
	name = "electro anomaly"
	icon_state = "electra0"
	active_icon_state = "electra1"
	light_range = 1
	active_light_range = 3
	light_color = "#7ac8e2"
	active_light_color = "#7ac8e2"
	activation_sound = 'stalker/sound/anomalies/electra_blast1.ogg'
	damage = 40
	damage_type = BURN
	armor_check = ENERGY
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS
	// this loot table seems very wrong
	loot = list(
		NO_LOOT = 90,
		/obj/item/stalker_artifact/flash = 2.5,
		/obj/item/stalker_artifact/moonlight = 1.75,
		/obj/item/stalker_artifact/battery = 0.75,
		/obj/item/stalker_artifact/pustishka = 0.25,
	)

/obj/effect/zona_anomaly/vortex
	name = "vortex anomaly"
	icon_state = "karusel0"
	active_icon_state = "karusel1"
	light_range = 0
	active_light_range = 0
	activation_sound = 'stalker/sound/anomalies/gravi_blowout1.ogg'
	damage = 30
	damage_type = BRUTE
	armor_check = BOMB
	gibbing = TRUE
	affect_mob_delay = 1 SECONDS
	affect_cooldown_duration = 4 SECONDS
	loot = list(
		NO_LOOT = 76,
		/obj/item/stalker_artifact/meduza = 10,
		/obj/item/stalker_artifact/stoneflower_depleted = 8,
		/obj/item/stalker_artifact/nightstar_depleted = 4,
		/obj/item/stalker_artifact/soul = 2,
	)

/obj/effect/zona_anomaly/vortex/Initialize()
	. = ..()
	AddComponent(/datum/component/move_towards_unanchored)

/obj/effect/zona_anomaly/springboard
	name = "springboard anomaly"
	icon_state = "tramplin0"
	active_icon_state = "tramplin1"
	light_range = 0
	active_light_range = 0
	activation_sound = 'stalker/sound/anomalies/gravi_blowout1.ogg'
	damage = 15
	damage_type = BRUTE
	armor_check = BOMB
	gibbing = TRUE
	affect_mob_delay = 0.5 SECONDS
	affect_cooldown_duration = 2 SECONDS
	loot = list(
		NO_LOOT = 80,
		/obj/item/stalker_artifact/meduza = 12,
		/obj/item/stalker_artifact/stoneflower_depleted = 5.5,
		/obj/item/stalker_artifact/nightstar_depleted = 2,
		/obj/item/stalker_artifact/soul = 0.5,
	)

/obj/effect/zona_anomaly/springboard/fuck_mob_up(mob/living/affected)
	. = ..()
	if(QDELETED(affected))
		return

	var/turf/target_turf = get_turf_in_angle(rand(0, 360), src, rand(1, 6))
	affected.throw_at(target_turf)

/obj/effect/zona_anomaly/burner
	name = "burner anomaly"
	icon_state = "jarka0"
	active_icon_state = "jarka1"
	activation_sound = 'stalker/sound/anomalies/zharka1.ogg'
	light_range = 3
	active_light_range = 4
	light_color = "#FFAA33"
	active_light_color = "#FFAA33"
	damage = 20
	damage_type = BURN
	armor_check = FIRE
	igniting = TRUE
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS
	loot = list(
		NO_LOOT = 90,
		/obj/item/stalker_artifact/droplet = 5,
		/obj/item/stalker_artifact/fireball = 3,
		/obj/item/stalker_artifact/crystal = 1.5,
		/obj/item/stalker_artifact/maminibusi = 0.5,
	)

/obj/effect/zona_anomaly/burner/comet
	name = "comet anomaly"
	icon_state = "jarka0"
	active_icon_state = "jarka1"
	damage = 40
	loot = list(
		/obj/item/stalker_artifact/droplet = 45,
		/obj/item/stalker_artifact/fireball = 40,
		/obj/item/stalker_artifact/crystal = 10,
		/obj/item/stalker_artifact/maminibusi = 5
	)
	loot_amount = 2

/obj/effect/zona_anomaly/burner/comet/Initialize()
	. = ..()
	AddComponent(/datum/component/circular_movement, get_turf(src))

/obj/effect/zona_anomaly/fruit_punch
	name = "fruit punch anomaly"
	icon_state = "holodec"
	active_icon_state = "holodec" //needs activate icon
	light_range = 3
	activated_light_range = 4
	light_color = "#70cc33"
	activated_light_color = "#70cc33"
	activation_sound = 'stalker/sound/anomalies/buzz_hit.ogg'
	damage = 60
	damage_type = BURN
	armor_check = ACID
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS
	loot = list(
		NO_LOOT = 80,
		/obj/item/stalker_artifact/stone_blood = 10,
		/obj/item/stalker_artifact/bubble = 5.5,
		/obj/item/stalker_artifact/mica = 3,
		/obj/item/stalker_artifact/firefly = 1.5,
	)
	constant_processing = TRUE
	var/obj/effect/zona_anomaly/fruit_punch/splash/son

/obj/effect/zona_anomaly/fruit_punch/process()
	. = ..()
	if(son)
		return
	var/mob/living/my_enemy = locate(/mob/living) in oview(1, src)
	if(my_enemy)
		son = new /obj/effect/zona_anomaly/fruit_punch/splash(my_enemy.loc)
		son.prepare_affect_mob(my_enemy)
		do_attack_animation(son)
		QDEL_IN(son, 2 SECONDS)
	else
		for(var/obj/item/my_item in oview(1, src))
			if(istype(my_item, /obj/item/stalker_artifact))
				continue
			son = new /obj/effect/zona_anomaly/fruit_punch/splash(my_item.loc)
			son.affect_item(my_item)
			do_attack_animation(son)
			QDEL_IN(son, 2 SECONDS)

/obj/effect/zona_anomaly/fruit_punch/splash
	icon_state = "holodec_splash"
	active_icon_state = "holodec_splash" //needs active icon
	light_range = 0
	active_light_range = 1
	damage = 30
	loot = null

/obj/effect/zona_anomaly/fruit_punch/splash/Initialize(mapload)
	. = ..()
	flick("holodec_splash_creation", src)

/obj/effect/zona_anomaly/burnt_fuzz
	name = "burnt fuzz"
	icon_state = "puh"
	active_icon_state = "puh" //needs active icon
	activation_sound = 'stalker/sound/anomalies/buzz_hit.ogg'
	damage = 65
	armor_check = BIO
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS

/obj/effect/zona_anomaly/burnt_fuzz/Initialize(mapload)
	. = ..()
	icon_state = pick("puh","puh2")
	active_icon_state = icon_state

/** This is fucking retarded
/obj/effect/radiation // Only does rad damage
	name = "radiation"
	icon = 'stalker/icons/anomalies.dmi'
	icon_state = "rad_low"
	var/damage = 0 				//How much damage
	var/damage_type = DMG_TYPE_RADIATION	//Damage type
	var/activated_icon_state = null 	//Sprite upon activation
	var/cooldown = 2.5					//Cooldown
	var/lasttime = 0
	var/list/mob/living/carbon/human/trapped = new/list()
	var/idle_light_range = 0
	var/activated_light_range = 0
	var/sound = null
	var/delay = 0
	var/attachedSpawner = null
	var/active_icon_state = null
	var/inactive_icon_state = null
	var/rt = 0
	invisibility = 101
	icon = 'stalker/icons/anomalies.dmi'
	resistance_flags = UNACIDABLE
	anchored = 1
	pass_flags = PASSTABLE | PASSGRILLE

/obj/effect/radiation/rad_low
	damage = 15
	sound = 'stalker/sound/pda/geiger_1.ogg'
	icon_state = "rad_low"

/obj/effect/radiation/rad_medium
	damage = 25
	sound = 'stalker/sound/pda/geiger_4.ogg'
	icon_state = "rad_medium"

/obj/effect/radiation/rad_high
	damage = 40
	sound = 'stalker/sound/pda/geiger_6.ogg'
	icon_state = "rad_high"

/obj/effect/radiation/Initialize()
	..()
	SSobj.processing += (src)

/obj/effect/radiation/Destroy()
	..()
	SSobj.processing -= (src)

/obj/effect/radiation/Crossed(atom/A)
	..()

	if(istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		src.trapped += H

		if(lasttime + cooldown < world.time)
			H.rad_act(src.damage)

		if(istype(H.wear_id,/obj/item/stalker_pda))
			H << sound(src.sound, repeat = 0, wait = 0, volume = 50, channel = 3)

		if(src.trapped.len >= 1)
			SSobj.processing -= src

/obj/effect/radiation/Uncrossed(atom/A)
	..()
	if (istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		src.trapped -= H
		SSobj.processing -= (src)

/obj/effect/radiation/process()
	if(src.trapped.len < 1)
		SSobj.processing -= (src)
		return

	if(lasttime + cooldown > world.time)
		return

	if(rt >= 3)
		src.trapped = null
		return

	for(var/atom/A in src.trapped)

		if(!istype(A, /mob/living/carbon/human))
			trapped -= A
			continue

		var/mob/living/carbon/human/H = A

		if(H.stat == 2)
			trapped -= H
			continue

		H.rad_act(src.damage)

		if(istype(H.wear_id,/obj/item/stalker_pda))
			H << sound(src.sound, repeat = 0, wait = 0, volume = 50, channel = 3)

		rt++

	src.lasttime = world.time
*/

#undef NO_LOOT

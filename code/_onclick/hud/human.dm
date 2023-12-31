/atom/movable/screen/human
	icon = 'icons/hud/screen_midnight.dmi'

/atom/movable/screen/ling
	icon = 'icons/hud/screen_changeling.dmi'

/atom/movable/screen/ling/chems
	name = "chemical storage"
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay

/atom/movable/screen/ling/sting
	name = "current sting"
	screen_loc = ui_lingstingdisplay
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling/sting/Click()
	if(isobserver(usr))
		return
	var/mob/living/carbon/carbon_user = usr
	carbon_user.unset_sting()

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()

	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	using = new/atom/movable/screen/cutedecor
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/language_menu
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/lookup
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/area_creator
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/iphone
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	action_intent = new /atom/movable/screen/combattoggle()
	action_intent.hud = src
	action_intent.icon = ui_style
	action_intent.screen_loc = ui_combat_toggle
	static_inventory += action_intent

	using = new /atom/movable/screen/mov_intent
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_above_intent
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/inventory_decor()
	using.screen_loc = ui_autism
	using.hud = src
	toggleable_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "uniform"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_ICLOTHING
	inv_box.icon_state = "uniform"
	inv_box.icon_full = "uniform_full"
	inv_box.screen_loc = ui_iclothing
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "suit"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_OCLOTHING
	inv_box.icon_state = "suit"
	inv_box.icon_full = "suit_full"
	inv_box.screen_loc = ui_oclothing
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.icon_full = "id_full"
	inv_box.icon_decor = "id_decor"
	inv_box.decor_pixel_x = 32
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	inv_box.hud = src
	inv_box.update_appearance()
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.icon_full = "mask_full"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.icon_full = "neck_full"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.icon_full = "back_full"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = ITEM_SLOT_BACK
	inv_box.hud = src
	inv_box.update_appearance()
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket_l"
	inv_box.icon_full = "pocket_l_full"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	inv_box.hud = src
	inv_box.update_appearance()
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket_r"
	inv_box.icon_full = "pocket_r_full"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	inv_box.hud = src
	inv_box.update_appearance()
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.icon_full = "suit_storage_full"
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = ITEM_SLOT_SUITSTORE
	inv_box.hud = src
	inv_box.update_appearance()
	static_inventory += inv_box

	using = new /atom/movable/screen/bolt()
	using.icon = ui_style
	using.screen_loc = ui_bolt
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_above_bolt
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	using.hud = src
	using.update_appearance()
	static_inventory += using

	using = new /atom/movable/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.icon_full = "gloves_full"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.icon_full = "glasses_full"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = ITEM_SLOT_EYES
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.icon_full = "ears_full"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = ITEM_SLOT_EARS
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.icon_full = "head_full"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.icon_full = "shoes_full"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = ITEM_SLOT_FEET
	inv_box.hud = src
	inv_box.update_appearance()
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
	inv_box.icon_full = "belt_full"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	inv_box.hud = src
	inv_box.update_appearance()
	static_inventory += inv_box

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_above_movement
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	rest_icon = new /atom/movable/screen/rest()
	rest_icon.icon = ui_style
	rest_icon.screen_loc = ui_above_intent
	rest_icon.hud = src
	rest_icon.update_appearance()
	static_inventory += rest_icon

	spacesuit = new /atom/movable/screen/spacesuit
	spacesuit.hud = src
	infodisplay += spacesuit

	healths = new /atom/movable/screen/healths()
	healths.hud = src
	infodisplay += healths

	stamina = new /atom/movable/screen/stamina()
	stamina.hud = src
	infodisplay += stamina

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.screen_loc = ui_above_movement
	pull_icon.hud = src
	pull_icon.update_appearance()
	static_inventory += pull_icon

	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.hud = src
	zone_select.update_appearance()
	static_inventory += zone_select

	combo_display = new /atom/movable/screen/combo()
	infodisplay += combo_display

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

	update_locked_slots()

/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(S.no_equip_flags & inv.slot_id)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			screenmob.client.screen += H.gloves
		if(H.ears)
			H.ears.screen_loc = ui_ears
			screenmob.client.screen += H.ears
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			screenmob.client.screen += H.glasses
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			screenmob.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			screenmob.client.screen += H.wear_suit
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			screenmob.client.screen += H.wear_mask
		if(H.wear_neck)
			H.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += H.wear_neck
		if(H.head)
			H.head.screen_loc = ui_head
			screenmob.client.screen += H.head
	else
		if(H.shoes)
			screenmob.client.screen -= H.shoes
		if(H.gloves)
			screenmob.client.screen -= H.gloves
		if(H.ears)
			screenmob.client.screen -= H.ears
		if(H.glasses)
			screenmob.client.screen -= H.glasses
		if(H.w_uniform)
			screenmob.client.screen -= H.w_uniform
		if(H.wear_suit)
			screenmob.client.screen -= H.wear_suit
		if(H.wear_mask)
			screenmob.client.screen -= H.wear_mask
		if(H.wear_neck)
			screenmob.client.screen -= H.wear_neck
		if(H.head)
			screenmob.client.screen -= H.head



/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.s_store)
				H.s_store.screen_loc = ui_sstore1
				screenmob.client.screen += H.s_store
			if(H.wear_id)
				H.wear_id.screen_loc = ui_id
				screenmob.client.screen += H.wear_id
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
			if(H.back)
				H.back.screen_loc = ui_back
				screenmob.client.screen += H.back
			if(H.l_store)
				H.l_store.screen_loc = ui_storage1
				screenmob.client.screen += H.l_store
			if(H.r_store)
				H.r_store.screen_loc = ui_storage2
				screenmob.client.screen += H.r_store
		else
			if(H.s_store)
				screenmob.client.screen -= H.s_store
			if(H.wear_id)
				screenmob.client.screen -= H.wear_id
			if(H.belt)
				screenmob.client.screen -= H.belt
			if(H.back)
				screenmob.client.screen -= H.back
			if(H.l_store)
				screenmob.client.screen -= H.l_store
			if(H.r_store)
				screenmob.client.screen -= H.r_store

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle hotkey buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE

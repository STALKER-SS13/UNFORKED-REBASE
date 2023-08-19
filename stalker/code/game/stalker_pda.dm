#define FLAG_FEED_SOUND (1<<0)
#define FLAG_FEED_IMAGES (1<<1)
#define FLAG_RANKING_IMAGES (1<<2)

#define PDA_WINDOW_PROFILE "profile"
#define PDA_WINDOW_ENCYCLOPEDIA "encyclopedia"
#define PDA_WINDOW_RANKING "ranking"
#define PDA_WINDOW_STALKER_FEED "stalker_feed"
#define PDA_WINDOW_MAP "map"

#define FEED_MESSAGE_COOLDOWN 10 SECONDS
#define FEED_FACTION_MESSAGE_COOLDOWN 5 SECONDS
#define LEADER_INVITE_COOLDOWN 10 SECONDS

#define RATING_REMOVE_TIMER 30 MINUTES

GLOBAL_LIST_EMPTY(PDA_list)


/obj/item/stalker_pda
	name = "PDA"
	desc = "A portable device, used to communicate with other stalkers."
	icon = 'stalker/icons/device_new.dmi'
	icon_state = "kpk_off"
	inhand_icon_state = "kpk"
	w_class = 1

	var/selected_window = PDA_WINDOW_PROFILE
	var/show_title = 0
	var/switches = FLAG_FEED_SOUND | FLAG_FEED_IMAGES | FLAG_RANKING_IMAGES

	// Profile
	var/datum/record/stalker/profile = null

	// Feed
	var/last_sent_message = 0
	var/last_sent_faction_message = 0

	slot_flags = ITEM_SLOT_ID

	// Faction shit
	var/last_invite = 0

/datum/asset/simple/encyclopedia
	assets = list(
		"zone"					= 'stalker/icons/images/zone.png',
		"backwater"				= 'stalker/icons/images/backwater.jpg',
		"nodata.gif"			= 'stalker/icons/images/nodata.gif'
	)

/datum/asset/simple/basics
	assets = list(
		"kpk_background.png"	= 'stalker/icons/images/KPK_blackbg.png',
		"nodata.png"			= 'stalker/icons/images/nodata.png',
		"photo_0"				= 'stalker/icons/images/sidor.png'
	)
	keep_local_name = TRUE

/datum/asset/simple/cursors
	assets = list(
		"cursor_normal.ani"		= 'stalker/html/cursors/arrow.ani',
		"cursor_red.ani"		= 'stalker/html/cursors/wait.ani',
		"cursor_green.ani"		= 'stalker/html/cursors/appstarting.ani',
		"cursor_busy.ani"		= 'stalker/html/cursors/busy.ani'
	)
	keep_local_name = TRUE

/obj/item/stalker_pda/Initialize()
	. = ..()
	GLOB.PDA_list += src
	RegisterSignal(SSdcs, COMSIG_STALKER_FEED_NEW_MESSAGE, PROC_REF(on_new_feed_message))

/obj/item/stalker_pda/Destroy()
	GLOB.PDA_list -= src
	return ..()

/obj/item/stalker_pda/attack_hand(mob/living/user)
	if(loc == user)
		attack_self(user)
	else
		..()

/obj/item/stalker_pda/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(user.client)
		var/datum/asset/asset = get_asset_datum(/datum/asset/simple/basics)
		asset.send(user.client)
		asset = get_asset_datum(/datum/asset/simple/cursors)
		asset.send(user.client)

	if(profile)
		user << browse_rsc(profile.front_photo, "PDA_front.png")
		user << browse_rsc(profile.side_photo, "PDA_side.png")
		profile.lastlogin = world.time

	icon_state = "kpk_on"
	user.set_machine(src)

	var/navbar_data = ""
	var/data = {"<html><style>
	a:link {color: #607D8B;}
	a:visited {color: #607D8B;}
	a:active {color: #607D8B;}
	a:hover {background-color: #9E9E9E;cursor: url('cursor_green.ani');}
	a {text-decoration: none;}
	html {cursor: url('cursor_normal.ani');}
	body {background-image: url('kpk_background.png');padding-top: 18px;padding-left: 35px; background-color: transparent; background-size: cover; border-radius: 50%;}
	table {background: #131416;padding: 15px;margin-bottom: 10px;color: #afb2a1;}
	#table-bottom1 {background: #2e2e38;padding-top: 5px;padding-bottom: 5px;}
	#table-center1 {position: relative;background: #2e2e38;padding-top: 5px;padding-bottom: 5px;bottom: 100px;}
	#table-center2 {position: relative;background: #2e2e38;bottom: 0px;}
	#table-lenta {background: #9E9E9E;}
	div.relative {position: relative;width: 250px;height: 200px;top: 70px;}
	#lenta {background: #2e2e38;color: white;padding: 5px;width: 449px;height: 228px;overflow: auto;border: 1px solid #ccc;word-wrap: break-word;}
	p.lentamsg {margin: 0px;word-wrap: break-word;}
	#navbar {overflow: hidden;background-color: #099;position: fixed;top: 0;width: 100%;padding-top: 3px;padding-bottom: 3px;padding-left: 20px;}
	#navbar a {float: left;display: block;color: #666;text-align: center;padding-right: 20px;text-decoration: none;font-size: 17px;}
	#navbar a:hover {background-color: #ddd;color: black;}
	#navbar a.active {background-color: #4CAF50;color: white;}
	#ratingimg {vertical-align:middle;}
	.main {}
	.main img {height: auto;}
	.button {width: 300px;height: 60px;}
	#encyclopedia_table {background: #131416;padding: 0px;margin-bottom: 0px;color: #afb2a1;margin-left: 0px;}
	#encyclopedia_list {background: #2e2e38;color: #afb2a1;padding: 5px;width: 160px;height: 228px;overflow: auto;border: 1px solid #ccc;word-wrap: break-word;margin-left: 3px;}
	#encyclopedia_list li{list-style-type: none;height: 0em;margin-left : 0px;}
	#encyclopedia_list li ul{visibility: hidden;height: 0em;margin-left : 0px;}
	#encyclopedia_list li ul li{height: 0em;margin-left : 0px;}
	#encyclopedia_info {background: #2e2e38;color: #afb2a1;padding: 0px;padding-left: 5px;width: 273px;height: 228px;overflow: auto;border: 1px solid #ccc;word-wrap: break-word;margin-right : 0px;}
	</style><body>"}

	if(!profile)
		data += {"<table border=0 height='314' width='455'><tr><td valign='top' align='center'>
		<div align='right'><a href='byond://?src=[REF(src)];choice=title'>\[-\]</a> <a href='byond://?src=[REF(src)];choice=close'>\[X\]</a></div><br>
		<div class='relative' align='center'>ENTER THE PASSWORD</div></td></tr>
		<tr><td colspan='2' align='center' id='table-center1' height=60>
				| <a style='color:#c10000;' href='byond://?src=[REF(src)];choice=password_input'>_______________</a> |<br>
		<div align='center'></div></td></tr>"}
	else
		switch(selected_window)
			if(PDA_WINDOW_PROFILE)
				navbar_data = "| <a>Profile</a> | <a href='byond://?src=[REF(src)];choice=[PDA_WINDOW_RANKING]'>Rating</a> | <a href='byond://?src=[REF(src)];choice=[PDA_WINDOW_STALKER_FEED]'>Feed</a> |<br>"

				data += {"
				<table border=0 height='314' width='455'><tr><td valign='top' align='left'>
				<div align='right'><a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=load_cache'>\[LOAD CACHE\]</a><a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=exit'>\[EXIT\]</a><a href='byond://?src=[REF(src)];choice=title'>\[-\]</a> <a href='byond://?src=[REF(src)];choice=close'>\[X\]</a></div></td</tr>
				<tr valign='top'><td><table><tr>
				<td style='text-align: center;' valign='top' align='left' width=90 height=90>
				<img style='margin-left: auto; margin-right: auto;' height=80 width=80 border=4 style='-ms-interpolation-mode: nearest-neighbor' src=PDA_front.png><br></td>"}
				data += {"<td>
				<b>Name:</b> [profile.name]<br>
				<b>Faction:</b> [profile.stalker_faction][profile.invited_to_faction ? "<a href='byond://?src=[REF(src)];changefaction=[profile.invited_to_faction]'> (CHANGE FACTION)</a>" : ""]<br>
				<b>Rank:</b> [get_rank_name(profile.rank_score)] ([profile.rank_score])<br>
				<b>Reputation:</b> <font color='[get_rep_color(profile.reputation)]'>[get_rep_name(profile.reputation)] ([profile.reputation])</font><br>
				<b>Balance:</b> [num2text(profile.money, 8)] RU<br>
				</td></tr></table></td></tr>"} // TODO: Add encyclopedia back here

			if(PDA_WINDOW_RANKING)
				navbar_data = "| <a href='byond://?src=[REF(src)];choice=[PDA_WINDOW_PROFILE]'>Profile</a> | <a>Rating</a> | <a href='byond://?src=[REF(src)];choice=[PDA_WINDOW_STALKER_FEED]'>Feed</a> |<br>"

				data += {"<table border=0 height='314' width='455'><tr><td valign='top' align='left'><div align='right'>
				<a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=RANKING_IMAGES'>\[IMAGES\] </a>
				<a href='byond://?src=[REF(src)];choice=title'>\[-\] </a>
				<a href='byond://?src=[REF(src)];choice=close'>\[X\] </a></div>"}
				data += "<div align = 'center' > | <a href='byond://?src=[REF(src)];choice=refresh_rating'>Refresh stalker list</a> | </div></td>"
				data += "</tr><tr valign='top'><td><div id= 'lenta'>[generate_ranking_html(user)]</div></td></tr>"

			if(PDA_WINDOW_STALKER_FEED)
				navbar_data = "| <a href='byond://?src=[REF(src)];choice=[PDA_WINDOW_PROFILE]'>Profile</a> | <a href='byond://?src=[REF(src)];choice=[PDA_WINDOW_RANKING]'>Rating</a> | <a>Feed</a> |<br>"

				data += {"<table border=0 height='314' width='455'><tr><td valign='top' align='left'><div align='right'>
				<a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=lenta_images'>\[IMAGES\] </a>
				<a href='byond://?src=[REF(src)];choice=title'>\[-\] </a>
				<a href='byond://?src=[REF(src)];choice=close'>\[X\] </a></div>"}
				data += "<div align = 'center' > | <a href='byond://?src=[REF(src)];choice=lenta_add'>Send feed message</a> | <a href='byond://?src=[REF(src)];choice=lenta_faction_add'>Send faction message</a> | <a href='byond://?src=[REF(src)];choice=lenta_sound'>Turn on/off sound</a> |</div></td>"
				data += "</tr><tr style='border: 0px;' valign='top'><td style='border: 0px;'><div id='lenta'>[generate_feed_html()]</div></td></tr>"
				// TODO: Add map here
		data += "<tr><td colspan='1' align='center' id='table-bottom1' height=30>[navbar_data]</td></tr>"
		// TODO: Map script goes here
	data += "<table></body></html>"

	user << browse(data, "window=mainhtml;size=568x388;border=0;can_resize=0;can_close=0;can_minimize=0;titlebar=[show_title]")

/obj/item/stalker_pda/Topic(href, href_list)
	..()

	var/mob/living/carbon/human/user = usr
	if(user.incapacitated() || loc != user)
		user.unset_machine()
		user << browse(null, "window=mainhtml")
		return
	user.set_machine(src)
	add_fingerprint(user)

	switch(href_list["choice"])
		if("title")
			show_title = !show_title

		if("close")
			turn_off(user)
			return

		if("password_input")
			if(!user.stalker_id) // Not registered in network
				var/reg_pass = tgui_input_text(user, "Register into network", "Enter Password", max_length = 10)
				if(!reg_pass)
					return
				if(length(reg_pass) < 6)
					to_chat(user, span_warning("Password needs to be at least 6 symbols long."))
					return
				register_stalker(user, reg_pass)
				updateSelfDialog()
				return

			var/pass = tgui_input_text(user, title = "Enter Password", max_length = 10)
			if(!pass)
				if(!pass)
					return
				if(length(pass) < 6)
					to_chat(user, span_warning("Password needs to be at least 6 symbols long."))
					return

			var/datum/record/stalker/stalker_record = find_stalker_record_by_pass(pass)
			if(!stalker_record)
				to_chat(user, span_warning("Wrong password."))
				return
			profile = stalker_record.connect_PDA(src)

		if("load_cache")
			var/datum/asset/asset = get_asset_datum(/datum/asset/simple/basics)
			asset.send(user.client)
			asset = get_asset_datum(/datum/asset/simple/cursors)
			asset.send(user.client)

		if("exit")
			profile.disconnect_PDA(src)
			turn_off(user)
			return

		if("lenta_add")
			var/text = tgui_input_text(user, title = "Enter Message", max_length = 250)
			if(!text)
				to_chat(user, span_warning("Type a message!"))
			else
				if(!(last_sent_message && world.time < last_sent_message + FEED_MESSAGE_COOLDOWN))
					last_sent_message = world.time
					add_stalker_feed_message(profile, text)
				else
					to_chat(user, span_warning("You can't send messages in next [round((FEED_MESSAGE_COOLDOWN + last_sent_message - world.time)/10)] sec."))

		if("lenta_faction_add")
			var/text = tgui_input_text(user, title = "Enter Message", max_length = 500)
			if(!text)
				to_chat(user, span_warning("Type a message!"))
			else
				if( !(last_sent_faction_message && world.time < last_sent_faction_message + FEED_FACTION_MESSAGE_COOLDOWN))
					last_sent_faction_message = world.time
					add_stalker_feed_message(profile, text, profile.stalker_faction)
				else
					to_chat(user, span_warning("You can't send messages in next [round((FEED_FACTION_MESSAGE_COOLDOWN + last_sent_faction_message - world.time)/10)] sec."))

		if("lenta_sound")
			if(switches & FLAG_FEED_SOUND)
				switches &= ~FLAG_FEED_SOUND
				to_chat(user, span_notice("Feed sound turned off."))
			else
				switches |= FLAG_FEED_SOUND
				to_chat(user, span_notice("Feed sound turned on."))

		if("lenta_images")
			if(switches & FLAG_FEED_IMAGES)
				switches &= ~FLAG_FEED_IMAGES
				to_chat(user, span_notice("Stalker avatars in the feed now will not be downloaded."))
			else
				switches |= FLAG_FEED_IMAGES
				to_chat(user, span_notice("Stalker avatars in the feed now will be downloaded."))

		if("ranking_images")
			if(switches & FLAG_RANKING_IMAGES)
				switches &= ~FLAG_RANKING_IMAGES
				to_chat(user, span_notice("Stalker avatars in the rating now will not be downloaded."))
			else
				switches |= FLAG_RANKING_IMAGES
				to_chat(user, span_notice("Stalker avatars in the rating now will be downloaded."))

		if("refresh_rating")
			updateSelfDialog()

		if("zoom")
			return

		if(PDA_WINDOW_PROFILE)
			selected_window = PDA_WINDOW_PROFILE

		if(PDA_WINDOW_RANKING)
			if(switches & FLAG_RANKING_IMAGES)
				for(var/datum/record/stalker/record in GLOB.manifest.stalkers)
					user << browse_rsc(record.front_photo, "photo_[record.stalker_id].png")
			selected_window = PDA_WINDOW_RANKING

		if(PDA_WINDOW_STALKER_FEED)
			if(switches & FLAG_FEED_IMAGES)
				for(var/datum/record/stalker/record in GLOB.manifest.stalkers)
					user << browse_rsc(record.front_photo, "photo_[record.stalker_id].png")
			selected_window = PDA_WINDOW_STALKER_FEED

	if(href_list["invite"])
		var/stalker_id = text2num(href_list["invite"])
		if(last_invite + LEADER_INVITE_COOLDOWN > world.time)
			return

		last_invite = world.time
		var/datum/record/stalker/stalker_record = find_stalker_record_by_id(stalker_id)
		if(stalker_record)
			var/obj/item/stalker_pda/invitee_pda = stalker_record.connected_pda_ref?.resolve()
			if(invitee_pda && ismob(invitee_pda.loc))
				invitee_pda.play_feed_sound()
				to_chat(invitee_pda.loc, "You have been invited to [profile.stalker_faction] faction. Check PDA profile for more info.")
			stalker_record.invited_to_faction = profile.stalker_faction

	if(href_list["remove"])
		var/stalker_id = text2num(href_list["remove"])
		var/datum/record/stalker/stalker_record = find_stalker_record_by_id(stalker_id)

		if(stalker_record && stalker_record.stalker_faction != FACTION_LONERS)
			var/obj/item/stalker_pda/kickee_pda = stalker_record.connected_pda_ref?.resolve()
			if(kickee_pda && ismob(kickee_pda.loc))
				kickee_pda.play_feed_sound()
				to_chat(kickee_pda.loc, "You have been kicked out of [stalker_record.stalker_faction] faction. Check PDA profile for more info.")
			stalker_record.stalker_faction = FACTION_LONERS

	if(href_list["changefaction"])
		if(!profile.invited_to_faction)
			return
		var/confirm = tgui_alert(user, "Do you want to change your faction from [profile.stalker_faction] to [profile.invited_to_faction]?", "PDA", list("Yes", "No"))
		if(confirm == "Yes")
			profile.stalker_faction = profile.invited_to_faction
			profile.invited_to_faction = null

	if(href_list["transfer_money"])
		var/stalker_id = text2num(href_list["transfer_money"])
		var/datum/record/stalker/stalker_record = find_stalker_record_by_id(stalker_id)
		if(!stalker_record)
			return
		var/trans_amount = tgui_input_number(user, "Enter the amount of money to transfer", "Transfer money", 0, profile.money, 0)
		trans_amount = clamp(trans_amount, 0, profile.money)
		if(!trans_amount)
			return
		profile.money -= trans_amount
		stalker_record.money += trans_amount
		var/obj/item/stalker_pda/receiever_pda = stalker_record.connected_pda_ref?.resolve()
		if(receiever_pda && ismob(receiever_pda.loc))
			receiever_pda.play_feed_sound()
			to_chat(receiever_pda.loc, "[profile.name] has transfered [trans_amount] RUB to your account! New balance: [stalker_record.money].")


	updateSelfDialog()
	return


/obj/item/stalker_pda/proc/register_stalker(mob/living/carbon/human/stalker, password)
	var/datum/record/stalker/existing_record = find_stalker_record_by_id(stalker.stalker_id)
	if(!existing_record)
		existing_record = GLOB.manifest.inject(stalker)
		profile = existing_record.connect_PDA(src)
		existing_record.PDA_password = password
		to_chat(stalker, "<B>PDA password</B>: [span_danger("[password]")]")

/obj/item/stalker_pda/proc/turn_off(mob/user)
	icon_state = "kpk_off"
	user.unset_machine()
	user << browse(null, "window=mainhtml")

/obj/item/stalker_pda/proc/generate_feed_html(mob/user)
	var/data = ""
	for(var/datum/data/stalker_feed_message/message in GLOB.stalker_feed)
		if(message.faction_chat && message.faction_chat != profile.stalker_faction)
			continue
		data = format_stalker_feed_message(message) + data
	return data

/obj/item/stalker_pda/proc/generate_ranking_html(mob/user)
	var/count = 0
	var/data = ""

	for(var/datum/record/stalker/R in sort_records_by_rank(GLOB.manifest.stalkers))
		count++
		data += {"<table style='margin-top: 0px; margin-bottom: 5px;'>
		<tr style='border: 1px solid black;'>
		<td width=64 height=64 align='top'>
		<img id='ratingbox' height=64 width=64 style='-ms-interpolation-mode: nearest-neighbor' src=photo_[R.stalker_id].png>
		</td>
		<td height=64 width=354 align='top' style='text-align:left;vertical-align: top;'>
		<b>\[[count]\]</b> [R.name] <font color='[get_faction_color(R.stalker_faction)]'>([R.stalker_faction])[R.is_faction_leader ?  "<b>\[LEADER\]</b>" : ""]</font>"}

		if(profile.money > 0 && R != profile)
			data += " <a href='byond://?src=[REF(src)];transfer_money=[R.stalker_id]'>\[send money\]</a>"

		if(profile.is_faction_leader)
			if(!R.is_faction_leader)
				if(profile.stalker_faction == R.stalker_faction)
					data += "<a style='color:#c10000;' href='byond://?src=[REF(src)];remove=[R.stalker_id]'>\[kick out\]</a>"
				else
					if(R.stalker_faction == FACTION_LONERS)
						data += "<a style='color:#7ac100;' href='byond://?src=[REF(src)];invite=[R.stalker_id]'>\[invite\]</a>"
		data += {"<br><b>Rating</b> [get_rank_name(R.rank_score)] ([R.rank_score])<br>
		<b>Reputation:</b> <font color='[get_rep_color(R.reputation)]'>[get_rep_name(R.reputation)]</font><br>
		</td>
		</tr>
		</table>"}

	return data

/obj/item/stalker_pda/proc/sort_records_by_rank(list/record_list)
	return sortTim(record_list, GLOBAL_PROC_REF(cmp_stalker_rank_dsc))

/proc/cmp_stalker_rank_dsc(datum/record/stalker/a, datum/record/stalker/b)
	return cmp_numeric_dsc(a.rank_score, b.rank_score)

/obj/item/stalker_pda/proc/play_feed_sound()
	if(switches & FLAG_FEED_SOUND)
		playsound(src, 'stalker/sound/pda/sms.ogg', 30)

/obj/item/stalker_pda/proc/on_new_feed_message(SSdcs, datum/data/stalker_feed_message/message)
	if(!profile)
		return
	if(message.faction_chat && message.faction_chat != message.sender.stalker_faction)
		return
	play_feed_sound()
	if(!ismob(loc))
		return
	show_pda_message_to_owner(message)

/obj/item/stalker_pda/proc/show_pda_message_to_owner(datum/data/stalker_feed_message/message)
	var/mob/living/carbon/human/owner = loc
	if(!istype(owner))
		return
	if(message.sender == profile)
		return
	if(owner.stat)
		return
	if(message.faction_chat && message.faction_chat != message.sender.stalker_faction)
		return

	to_chat(owner, "[icon2base64html(src)] STALKER FEED: <font color='[get_faction_color(message.sender.stalker_faction)]'>[message.sender.name]\[[message.sender.stalker_faction]\][message.faction_chat ? "(faction chat)" : ""]:</font>[message.message]")

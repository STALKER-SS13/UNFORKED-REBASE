#define FLAG_FEED_SOUND (1<<0)
#define FLAG_FEED_IMAGES (1<<1)
#define FLAG_RATING_IMAGES (1<<2)

#define PDA_WINDOW_PROFILE 1
#define PDA_WINDOW_ENCYCLOPEDIA 2
#define PDA_WINDOW_RANKING 3
#define PDA_WINDOW_STALKER_FEED 4
#define PDA_WINDOW_MAP 5

#define FEED_MESSAGE_COOLDOWN 45 SECONDS
#define FEED_FACTION_MESSAGE_COOLDOWN 10 SECONDS
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
	var/switches = FLAG_FEED_SOUND | FLAG_FEED_IMAGES | FLAG_RATING_IMAGES
	var/ratinghtml = ""

	// Profile
	var/datum/weakref/owner_ref
	var/datum/record/stalker/profile = null

	var/rotation = "front"

	var/obj/item/photo/photo_owner_front = new()
	var/obj/item/photo/photo_owner_west = new()
	var/obj/item/photo/photo_owner_back = new()
	var/obj/item/photo/photo_owner_east = new()
	var/hacked = 0
	var/rep_color_s = "#ffe100"
	var/rep_name_s = "Neutral"

	// Feed
	var/lentahtml = ""
	var/last_lenta = 0
	var/lenta_id = 0

	var/last_faction_lenta = 0
	var/lenta_faction_id = 0

	var/msg_name = "message"
	var/max_length = 10
	slot_flags = ITEM_SLOT_ID

	// Faction shit
	var/last_invite = 0

	// Ranking
	var/sortBy = "rating"
	var/order = 1
	var/lastlogin = 0

/datum/asset/simple/encyclopedia
	assets = list(
		"zone"					= 'stalker/icons/images/zone.png',
		"backwater"				= 'stalker/icons/images/backwater.jpg',
		"nodata.gif"			= 'stalker/icons/images/nodata.gif'
	)

/datum/asset/simple/basics
	assets = list(
		"kpk_background.png"	= 'stalker/icons/images/kpk.png',
		"nodata.png"			= 'stalker/icons/images/nodata.png',
		"photo_0"				= 'stalker/icons/images/sidor.png'
	)

/datum/asset/simple/cursors
	assets = list(
		"cursor_normal.ani"		= 'stalker/html/cursors/arrow.ani',
		"cursor_red.ani"		= 'stalker/html/cursors/wait.ani',
		"cursor_green.ani"		= 'stalker/html/cursors/appstarting.ani',
		"cursor_busy.ani"		= 'stalker/html/cursors/busy.ani'
	)

/obj/item/stalker_pda/Initialize()
	. = ..()
	GLOB.PDA_list += src

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
	body {background-image: url('kpk_background.png');padding-top: 18px;padding-left: 35px;}
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
		data +={"<table border=0 height='314' width='455'><tr><td valign='top' align='center'>
		<div align='right'><a href='byond://?src=[REF(src)];choice=title'>\[-\]</a> <a href='byond://?src=[REF(src)];choice=close'>\[X\]</a></div><br>
		<div class='relative' align='center'>ENTER THE PASSWORD</div></td></tr>
		<tr><td colspan='2' align='center' id='table-center1' height=60>
				| <a style='color:#c10000;' href='byond://?src=[REF(src)];choice=password_input'>_______________</a> |<br>
		<div align='center'></div></td></tr>"}
	else
		switch(selected_window)
			if(PDA_WINDOW_PROFILE)
				navbar_data ="| <a>Profile</a> | <a href='byond://?src=[REF(src)];choice=3'>Rating</a> | <a href='byond://?src=[REF(src)];choice=4'>Feed</a> |<br>"

				data += {"
				<table border=0 height='314' width='455'><tr><td valign='top' align='left'>
				<div align='right'><a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=load_cache'>\[LOAD CACHE\]</a><a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=exit'>\[EXIT\]</a><a href='byond://?src=[REF(src)];choice=title'>\[-\]</a> <a href='byond://?src=[REF(src)];choice=close'>\[X\]</a></div></td</tr>
				<tr valign='top'><td><table><tr>
				<td style='text-align: center;' valign='top' align='left' width=90 height=90>
				<img style='margin-left: auto; margin-right: auto;' height=80 width=80 border=4 style='-ms-interpolation-mode: nearest-neighbor' src=PDA_front.png><br></td>"}
				data += {"<td>
				<b>Name:</b> [profile.name]<br>
				<b>Faction:</b> [profile.stalker_faction]<br>
				<b>Rank:</b> [get_rank_name(profile.rank_score)] ([profile.rank_score])<br>
				<b>Reputation:</b> <font color='[get_rep_color(profile.reputation)]'>[get_rep_name(profile.reputation)] ([profile.reputation])</font><br>
				<b>Balance:</b> [num2text(profile.money, 8)] RU<br>
				</td></tr></table></td></tr>"}
				// TODO: Add encyclopedia back here
			if(PDA_WINDOW_RANKING)
				navbar_data ="| <a href='byond://?src=[REF(src)];choice=1'>Profile</a> | <a>Rating</a> | <a href='byond://?src=[REF(src)];choice=4'>Feed</a> |<br>"

				data += {"<table border=0 height='314' width='455'><tr><td valign='top' align='left'><div align='right'>
				<a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=rating_images'>\[IMAGES\] </a>
				<a href='byond://?src=[REF(src)];choice=title'>\[-\] </a>
				<a href='byond://?src=[REF(src)];choice=close'>\[X\] </a></div>"}
				data += "<div align = 'center' > | <a href='byond://?src=[REF(src)];choice=refresh_rating'>Refresh stalker list</a> | </div></td>"
				data += "</tr><tr valign='top'><td><div id= 'lenta'>[ratinghtml]</div></td></tr>"
			if(PDA_WINDOW_STALKER_FEED)
				navbar_data ="| <a href='byond://?src=[REF(src)];choice=1'>Profile</a> | <a href='byond://?src=[REF(src)];choice=3'>Rating</a> | <a>Feed</a> |<br>"

				data += {"<table border=0 height='314' width='455'><tr><td valign='top' align='left'><div align='right'>
				<a style='color:#c10000;' align='center' href='byond://?src=[REF(src)];choice=lenta_images'>\[IMAGES\] </a>
				<a href='byond://?src=[REF(src)];choice=title'>\[-\] </a>
				<a href='byond://?src=[REF(src)];choice=close'>\[X\] </a></div>"}
				data += "<div align = 'center' > | <a href='byond://?src=[REF(src)];choice=lenta_add'>Send feed message</a> | <a href='byond://?src=[REF(src)];choice=lenta_faction_add'>Send faction message</a> | <a href='byond://?src=[REF(src)];choice=lenta_sound'>Turn on/off sound</a> |</div></td>"
				data += "</tr><tr style='border: 0px;' valign='top'><td style='border: 0px;'><div id='lenta'>[lentahtml]</div></td></tr>"
				// TODO: Add map here
		data += "<tr><td colspan='1' align='center' id='table-bottom1' height=30>[navbar_data]</td></tr>"
		// TODO: Map script goes here
	data +="<table></body></html>"

	user << browse(data, "window=mainhtml;size=568x388;border=0;can_resize=0;can_close=0;can_minimize=0;titlebar=[show_title]")

/obj/item/stalker_pda/Topic(href, href_list)
	..()

	var/mob/living/carbon/human/user = usr
	if(user.incapacitated() || loc != user)
		hacked = 0
		user.unset_machine()
		user << browse(null, "window=mainhtml")
		return
	user.set_machine(src)
	//add_fingerprint(user)
	//get_asset_datum(/datum/asset/simple/basics).send(user)

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
					to_chat(user, "<span class='warning'>You've entered no password.</span>")
					return
				register_stalker(user, reg_pass)
				updateSelfDialog()
				return

			var/pass = tgui_input_text(user, title = "Enter Password", max_length = 10)
			if(!pass)
				to_chat(user, "<span class='warning'>You've entered no password.</span>")
				return

			var/datum/record/stalker/stalker_record = find_stalker_record_by_pass(pass)

			if(!stalker_record)
				to_chat(user, "<span class='warning'>Wrong password.</span>")
				return

			profile = stalker_record
		if("load_cache")
			//get_asset_datum(/datum/asset/simple/basics).send(H)

		if("exit")
			profile = null
			turn_off(user)
			return
		/*
		if("lenta_add")
			var/text = tgui_input_text(H, title = "Enter Message", max_length = 250)
			if(!text)
				to_chat(H, "<span class='warning'>Type a message!</span>")
			else
				if( !(last_lenta && world.time < last_lenta + LENTA_MESSAGE_COOLDOWN) )
					last_lenta = world.time

					add_lenta_message(src, sid, owner.real_name, eng_faction_s, t)

				else
					to_chat(H, "<span class='warning'>You can't send messages in next [round((LENTA_MESSAGE_COOLDOWN + last_lenta - world.time)/10)] sec.</span>")

		if("lenta_faction_add")
			var/t = tgui_input_text(H, title = "Enter Message", max_length = 500)
			if(!t)
				to_chat(H, "<span class='warning'>Type a message!</span>")
			else
				if( !(last_faction_lenta && world.time < last_faction_lenta + LENTA_FACTION_MESSAGE_COOLDOWN) )
					last_faction_lenta = world.time
					add_faction_lenta_message(src, sid, owner.real_name, eng_faction_s, t)

				else
					to_chat(H, "<span class='warning'>You can't send messages in next [round((LENTA_FACTION_MESSAGE_COOLDOWN + last_faction_lenta - world.time)/10)] sec.</span>")

		if("lenta_sound")
			if(switches & FEED_SOUND)
				switches &= ~FEED_SOUND
				to_chat(H, "<span class='notice'>Feed sound turned off.</span>")
			else
				switches |= FEED_SOUND
				to_chat(H, "<span class='notice'>Feed sound turned on.</span>")

		if("lenta_images")
			if(switches & FEED_IMAGES)
				switches &= ~FEED_IMAGES
				to_chat(H, "<span class='notice'>Stalker avatars in the feed now will not be downloaded.</span>")
			else
				switches |= FEED_IMAGES
				to_chat(H, "<span class='notice'>Stalker avatars in the feed now will be downloaded.</span>")

		if("rating_images")
			if(switches & RATING_IMAGES)
				switches &= ~RATING_IMAGES
				to_chat(H, "<span class='notice'>Stalker avatars in the rating now will not be downloaded.</span>")
			else
				switches |= RATING_IMAGES
				to_chat(H, "<span class='notice'>Stalker avatars in the rating now will be downloaded.</span>")

		if("refresh_rating")
			ratinghtml = ""
			if(GLOB.data_core.stalkers.len)
				refresh_rating(H)

		if("zoom")
			return
		*/

		if(PDA_WINDOW_PROFILE)
			selected_window = PDA_WINDOW_PROFILE
/*
		if("[PDA_WINDOW_RANKING]")
			if(GLOB.data_core.stalkers.len)
				refresh_rating(H)
			selected_window = PDA_WINDOW_RANKING

		if("[PDA_WINDOW_STALKER_FEED]")
			if(switches & FEED_IMAGES)
				for(var/datum/data/record/R in GLOB.data_core.stalkers)
					if(R.fields["lastlogin"] + RATING_REMOVE_TIMER > world.time)
						continue
					var/sid_p = R.fields["sid"]
					var/obj/item/photo/P1 = R.fields["photo_front"]
					H << browse_rsc(P1.picture.picture_image, "photo_[sid_p]")
			selected_window = PDA_WINDOW_STALKER_FEED
*/
		/*if("5")			//КАРТА
			SSminimap.sendMinimaps(H)
			mode = 5*/
/*
	if(href_list["invite"])

		var/sid_ = text2num(href_list["invite"])
		var/datum/job/J = SSjob.GetJob(get_job_title(eng_faction_s))

		if(!J)
			return

		if((J.current_positions >= J.total_positions) && J.total_positions != -1)
			return

		if(last_invite + LEADER_INVITE_COOLDOWN > world.time)
			return

		last_invite = world.time
		for(var/obj/item/stalker_pda/KPK_invited in GLOB.KPKs)
			if(KPK_invited.stalker_id == sid_)
				show_lenta_message(src, KPK_invited, sid, owner.real_name, eng_faction_s, "You have been invited to [eng_faction_s] faction. Check feed for more info.")
				add_local_lenta_message(src, KPK_invited, sid, owner.real_name, eng_faction_s,"You have been invited to [eng_faction_s] faction. <a style=\"color:#c10000;\" href='byond://?src=[REF(KPK_invited)];changefaction=[J.title]'>\[Accept invitation\]</a>")

	if(href_list["remove"])

		var/sid_ = text2num(href_list["remove"])
		var/datum/job/J = SSjob.GetJob(get_job_title(eng_faction_s))

		var/datum/data/record/sk_removed = find_record("sid", sid_, GLOB.data_core.stalkers)
		if(!sk_removed)
			return

		SSjob.AssignRole(owner, "Loner", 1)
		sk_removed.fields["faction_s"] = "Loners"
		J.current_positions--

		for(var/obj/item/stalker_pda/KPK_removed in GLOB.KPKs)
			if(KPK_removed.stalker_id == sid_)
				show_lenta_message(src, KPK_removed, sid, owner.real_name, eng_faction_s, "You have been kicked out of [eng_faction_s] faction.")
				add_local_lenta_message(src, KPK_removed, sid, owner.real_name, eng_faction_s,"You have been kicked out of [eng_faction_s] faction.")

				KPK_removed.set_owner_info(KPK_removed.profile)

	if(href_list["changefaction"])

		var/new_eng_faction_s =  SSjob.GetJob(href_list["changefaction"]).faction_s
		var/confirm = alert(H, "Do you want to change your faction from [eng_faction_s] to [new_eng_faction_s]?", "PDA", "Yes", "No")
		if(confirm == "Yes")
			var/datum/job/J =  SSjob.GetJob(href_list["changefaction"])

			if(!J)
				return

			if((J.current_positions >= J.total_positions) && J.total_positions != -1)
				return

			SSjob.AssignRole(owner, href_list["changefaction"], 1)

			profile.fields["faction_s"] = J.faction_s
			set_owner_info(profile)
*/
	updateSelfDialog()
	return


/obj/item/stalker_pda/proc/register_stalker(mob/living/carbon/human/stalker, password)
	var/datum/record/stalker/existing_record = find_stalker_record_by_id(stalker.stalker_id)
	if(!existing_record)
		profile = GLOB.manifest.inject(stalker)
		profile.PDA_password = password
		to_chat(stalker, "<B>PDA password</B>: <span class='danger'>\"[password]\"</span>")

/obj/item/stalker_pda/proc/turn_off(mob/user)
	icon_state = "kpk_off"
	user.unset_machine()
	hacked = 0
	user << browse(null, "window=mainhtml")

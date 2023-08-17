GLOBAL_LIST_EMPTY_TYPED(stalker_feed, /datum/data/stalker_feed_message)

/datum/data/stalker_feed_message
	var/datum/record/stalker/sender
	var/message
	/// Stores faction name
	var/faction_chat

/datum/data/stalker_feed_message/New(datum/record/stalker/sender, message, faction_chat)
	src.sender = sender
	src.message = message
	src.faction_chat = faction_chat

/proc/add_stalker_feed_message(datum/record/stalker/sender, message, faction_chat)
	ASSERT(istype(sender))
	var/datum/data/stalker_feed_message/new_message = new(sender, message, faction_chat)
	GLOB.stalker_feed += new_message
	show_dead_lenta_message(message)
	SEND_GLOBAL_SIGNAL(COMSIG_STALKER_FEED_NEW_MESSAGE, new_message)

/proc/format_stalker_feed_message(datum/data/stalker_feed_message/message)
	var/datum/record/stalker/sender = message.sender
	var/data = {"<table style='margin-top: 0px; margin-bottom: 5px; border: 0px; background: #2e2e38;'>
	<tr style='border: 0px solid black;'>
	<td style='border: 0px solid black; vertical-align: top; background: #2e2e38;' width=32 height=32>
	<img id='ratingbox' style='background: #2e2e38; border: 1px solid black; -ms-interpolation-mode: nearest-neighbor;' height=32 width=32 src=photo_[sender.stalker_id].png></td>
	<td width=386 height=32 align='top' style='background: #131416; border: 0px; text-align:left; vertical-align: top;'>
	<p class='lentamsg'><b><font color = '[get_faction_color(message.sender.stalker_faction)]'>[sender.name]\[[sender.stalker_faction][sender.is_faction_leader ? " - leader" : ""]\][message.faction_chat ? "(faction chat)" : ""]</font></b> : <br>
	<font color = '#afb2a1'>[message.message]</font></p>
	</td></tr></table>"}
	return data


/proc/show_dead_lenta_message(datum/data/stalker_feed_message/message)
	for(var/mob/dead/observer/M in GLOB.player_list)
		to_chat(M, "STALKER FEED: <font color='[get_faction_color(message.sender.stalker_faction)]'>[message.sender.name]\[[message.sender.stalker_faction]\][message.faction_chat ? "(faction chat)" : ""]:</font>[message.message]")


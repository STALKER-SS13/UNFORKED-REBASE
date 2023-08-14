/// Factions

#define FACTION_LONERS "Loners"
#define FACTION_BANDITS "Bandits"
#define FACTION_DUTY "Duty"
#define FACTION_FREEDOM "Freedom"
#define FACTION_MERC "Mercenaries"
#define FACTION_MONOLITH "Monolith"
#define FACTION_CLEARSKY "Clear Sky"
#define FACTION_ECOLOGIST "Ecologist"
#define FACTION_RENEGATE "Renegades"
#define FACTION_MILITARY "Security Service of Ukraine"

/// Stalker experience ranks

#define RANK_ROOKIE 0
#define RANK_EXPERIENCED 8000
#define RANK_VETERAN 10000
#define RANK_EXPERT 20000
#define RANK_LEGEND 40000

/// Reputation levels

#define REP_COLOR_DISGUSTING "#7c0000"
#define REP_COLOR_VERYBAD "#db2b00"
#define REP_COLOR_BAD "#ff6b3a"
#define REP_COLOR_NEUTRAL "#ffe100"
#define REP_COLOR_GOOD "#daff21"
#define REP_COLOR_VERYGOOD "#b6ff38"
#define REP_COLOR_AMAZING "#00abdb"


#define REP_DISGUSTING 0
#define REP_VERYBAD 500
#define REP_BAD 1250
#define REP_NEUTRAL 1500
#define REP_GOOD 1750
#define REP_VERYGOOD 2500
#define REP_AMAZING 3000

/proc/get_rep_name(rep)
	switch(rep)
		if(REP_AMAZING to INFINITY)
			return
		if(REP_VERYGOOD to REP_AMAZING)
			return
		if(REP_GOOD to REP_VERYGOOD)
			return
		if(REP_BAD to REP_GOOD)
			return
		if(REP_VERYBAD to REP_BAD)
			return
		if(REP_DISGUSTING to REP_VERYBAD)
			return
		if(-INFINITY to REP_DISGUSTING)
			return
	return "#ffffff"

/proc/get_rep_color(rep)
	switch(rep)
		if(REP_AMAZING to INFINITY)
			return REP_COLOR_AMAZING
		if(REP_VERYGOOD to REP_AMAZING)
			return REP_COLOR_VERYGOOD
		if(REP_GOOD to REP_VERYGOOD)
			return REP_COLOR_GOOD
		if(REP_BAD to REP_GOOD)
			return REP_COLOR_NEUTRAL
		if(REP_VERYBAD to REP_BAD)
			return REP_COLOR_YBAD
		if(REP_DISGUSTING to REP_VERYBAD)
			return REP_COLOR_VERYBAD
		if(-INFINITY to REP_DISGUSTING)
			return REP_COLOR_DISGUSTING
	return "#ffffff"







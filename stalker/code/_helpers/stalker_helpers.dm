
/proc/get_rank_name(exp)
	switch(exp)
		if(-INFINITY to RANK_EXPERIENCED - 1)
			return "Rookie"
		if(RANK_EXPERIENCED to RANK_VETERAN - 1)
			return "Experienced"
		if(RANK_VETERAN to RANK_EXPERT - 1)
			return "Veteran"
		if(RANK_EXPERT to RANK_LEGEND - 1)
			return "Expert"
		if(RANK_LEGEND to INFINITY)
			return "Legend"
	return "Undefined"

/proc/get_rep_name(rep)
	switch(rep)
		if(REP_AMAZING to INFINITY)
			return "Amazing"
		if(REP_VERYGOOD to REP_AMAZING)
			return "Very Good"
		if(REP_GOOD to REP_VERYGOOD)
			return "Good"
		if(REP_BAD to REP_GOOD)
			return "Neutral"
		if(REP_VERYBAD to REP_BAD)
			return "Bad"
		if(REP_DISGUSTING to REP_VERYBAD)
			return "Very Bad"
		if(-INFINITY to REP_DISGUSTING)
			return "Disgusting"
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
			return REP_COLOR_VERYBAD
		if(REP_DISGUSTING to REP_VERYBAD)
			return REP_COLOR_VERYBAD
		if(-INFINITY to REP_DISGUSTING)
			return REP_COLOR_DISGUSTING
	return "#ffffff"


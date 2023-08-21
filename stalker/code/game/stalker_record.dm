
/mob/living/carbon/human
	var/stalker_id
	var/stalker_faction

/datum/manifest
	/// Keeps all stalker records
	var/list/stalkers = list()
	var/stalker_id_counter = 0

/datum/manifest/New()
	. = ..()
	stalker_id_counter = rand(1000, 5000)

/datum/manifest/build()
	return

/datum/manifest/inject(mob/living/carbon/human/person)
	set waitfor = FALSE
	if(!(person.mind?.assigned_role.job_flags & JOB_CREW_MANIFEST))
		return

	stalker_id_counter += rand(5, 25)
	person.stalker_id = stalker_id_counter

	var/assignment = person.mind.assigned_role.title
	var/mutable_appearance/character_appearance = new(person.appearance)
	var/person_gender = "Other"
	if(person.gender == "male")
		person_gender = "Male"
	if(person.gender == "female")
		person_gender = "Female"

	var/datum/record/stalker/record = new /datum/record/stalker(
		age = person.age,
		blood_type = person.dna.blood_type,
		character_appearance = character_appearance,
		dna_string = person.dna.unique_enzymes,
		fingerprint = md5(person.dna.unique_identity),
		gender = person_gender,
		initial_rank = assignment,
		name = person.real_name,
		rank = assignment,
		species = person.dna.species.name,
		trim = assignment,
		// Stalker specific
		stalker_id = stalker_id_counter,
		PDA_password = 0,
		rank_score = rand(RANK_ROOKIE, RANK_ROOKIE + 200),
		reputation = REP_NEUTRAL,
		stalker_faction = FACTION_LONERS,
		money = rand(50, 100),
		is_faction_leader = FALSE,
		lastlogin = world.time,
	)

	return record

/datum/record/stalker
	var/stalker_id = 0
	var/PDA_password = 0
	var/rank_score = RANK_ROOKIE
	var/reputation = REP_NEUTRAL
	var/stalker_faction = FACTION_LONERS
	var/money = 0
	var/is_faction_leader = FALSE
	var/lastlogin = 0
	var/icon/front_photo
	var/icon/side_photo
	var/datum/weakref/connected_pda_ref = null
	var/invited_to_faction = null

/datum/record/stalker/New(
	age = 18,
	blood_type = "?",
	character_appearance,
	dna_string = "Unknown",
	fingerprint = "?????",
	gender = "Other",
	initial_rank = "Unassigned",
	name = "Unknown",
	rank = "Unassigned",
	species = "Human",
	trim = "Unassigned",
	/// Stalker specific
	stalker_id = 0,
	PDA_password = null,
	rank_score = RANK_ROOKIE,
	reputation = REP_NEUTRAL,
	stalker_faction = FACTION_LONERS,
	money = 0,
	is_faction_leader = FALSE,
	lastlogin = world.time,
)
	. = ..()
	src.stalker_id = stalker_id
	src.PDA_password = PDA_password
	src.rank_score = rank_score
	src.reputation = reputation
	src.stalker_faction = stalker_faction
	src.money = money
	src.is_faction_leader = is_faction_leader
	src.lastlogin = lastlogin
	set_photos(character_appearance)

	GLOB.manifest.stalkers += src

/datum/record/stalker/Destroy()
	GLOB.manifest.stalkers -= src
	return ..()

/datum/record/stalker/proc/set_photos(mutable_appearance/appearance)
	appearance.setDir(SOUTH)
	front_photo = getFlatIcon(appearance)
	front_photo.Crop(9, 18, 23, 32)
	appearance.setDir(WEST)
	side_photo = getFlatIcon(appearance)
	side_photo.Crop(9, 18, 23, 32)

/datum/record/stalker/proc/connect_PDA(obj/item/stalker_pda/pda)
	if(connected_pda_ref)
		var/obj/item/stalker_pda/connected_pda = connected_pda_ref.resolve()
		if(ismob(connected_pda.loc) && connected_pda.profile == src)
			to_chat(connected_pda.loc, "[icon2base64html(src)] STALKER NETWORK: Another login attempt into your account was made!")
		return
	connected_pda_ref = WEAKREF(pda)
	pda.connected_profile = src
	return src

/datum/record/stalker/proc/disconnect_PDA()
	if(!connected_pda_ref)
		return
	var/obj/item/stalker_pda/connected_pda = connected_pda_ref.resolve()
	connected_pda.connected_profile = null
	connected_pda.profile = null
	return


/proc/find_stalker_record_by_id(stalker_id)
	for(var/datum/record/stalker/target in GLOB.manifest.stalkers)
		if(target.stalker_id != stalker_id)
			continue
		return target
	return

/proc/find_stalker_record_by_pass(pass)
	for(var/datum/record/stalker/target in GLOB.manifest.stalkers)
		if(target.PDA_password != pass)
			continue
		return target
	return

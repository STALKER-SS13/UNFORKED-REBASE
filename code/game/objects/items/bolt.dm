/obj/item/bolt
	name = "bolt"
	desc = "Old soviet bolt affected by corrosion."
	icon = 'icons/stalker/obj/bolt.dmi'
	icon_state = "bolt"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 1

/obj/item/bolt/Initialize(mapload, should_delete = FALSE)
	. = ..()
	if(should_delete)
		QDEL_IN(src, 5 SECONDS)

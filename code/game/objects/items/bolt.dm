/obj/item/bolt
	name = "bolt"
	desc = "Old soviet bolt affected by corrosion."
	icon = 'icons/stalker/obj/bolt.dmi'
	icon_state = "bolt"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	/// Whether or not we get deleted after dropping
	var/delete_on_drop = TRUE

/obj/item/bolt/Initialize(mapload, delete_on_drop = FALSE)
	. = ..()
	src.delete_on_drop = delete_on_drop

/obj/item/bolt/dropped(mob/user, silent)
	. = ..()
	if(delete_on_drop && !QDELING(src))
		interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP
		QDEL_IN(src, 3 SECONDS)

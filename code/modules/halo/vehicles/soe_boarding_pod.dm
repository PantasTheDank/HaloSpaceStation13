
/obj/vehicles/drop_pod/overmap/boarding_pod
	name = "Sons of Eridanus Boarding Pod"
	desc = "Someone decided it was a good idea to cut a Bumblebee boarding pod in half,paint it grey, put a loudspeaker and a flashbang detonator on top and call it a "unique" boarding pod. Well...what can go wrong?"."
	density = 1
	anchored = 1
	launch_arm_time = 1 SECONDS
	drop_accuracy = 5
	occupants = list(4,0)
	pod_range = 8

	vehicle_size = 64

	light_color = "#E1FDFF"

/obj/vehicles/drop_pod/overmap/boarding_pod/update_object_sprites()
	//Enclosed, we don't need to care about the person-sprites.

/obj/vehicles/drop_pod/overmap/boarding_pod/is_on_launchbay()
	return 1

/obj/vehicles/drop_pod/overmap/boarding_pod/get_drop_turf(var/turf/drop_point)
	if(isnull(drop_point))
		visible_message("<span class = 'warning'>[src] blurts a warning: ERROR: NO AVAILABLE DROP-TARGETS.</span>")
		return
	var/list/valid_points = list()
	for(var/turf/t in range(drop_point,drop_accuracy))
		if(istype(t,/turf/unsimulated/floor/rock2)) //No spawning in rock walls, even if they are subtypes of /floor/
			continue
		if(istype(t,/turf/simulated/floor))
			valid_points += t
			continue
		if(istype(t,/turf/unsimulated/floor))
			valid_points += t
			continue
	if(isnull(valid_points))
		error("DROP POD FAILED TO LAUNCH: COULD NOT FIND ANY VALID DROP-POINTS")
		return
	return pick(valid_points)

/obj/vehicles/drop_pod/overmap/boarding_pod/post_drop_effects(var/turf/drop_turf)
	explosion(drop_turf,0,0,0,7)
	playsound(flashbangsoe.ogg)
	playsound(soe_boardingpod_entrance.ogg)

	var/obj/effect/overmap/om_obj = map_sectors["[drop_turf.z]"]
	if(istype(om_obj,/obj/effect/overmap/sector)) //Let's not send a message if we're dropping onto a planet.
		return
	for(var/mob/living/m in GLOB.player_list)
		if(m.z in om_obj.map_z)
			to_chat(m,"<span class = 'danger'>EXTERNAL INCURSION WARNING: BOARDING POD COLLISION DETECTED. LOCATION: [drop_turf.loc.name]</span>")

/obj/vehicles/drop_pod/overmap/boarding_pod
	name = "Son of Eridanus Boarding Pod"
	desc = "Someone decided it was a good idea to cut a Bumblebee boarding pod in half,paint it grey, put a loudspeaker and a flashbang detonator on top and call it a "unique" boarding pod. Well...what can go wrong?"
	icon = 'code/modules/halo/vehicles/soe_pod.dmi'
	icon_state = "soe_boarding_pod"

	bound_width = 32
	bound_height = 48

/obj/vehicles/drop_pod/overmap/boarding_pod/north
	bound_width = 32
	bound_height = 48
	dir = 1

/obj/vehicles/drop_pod/overmap/boarding_pod/south
	bound_width = 32
	bound_height = 48
	dir = 2

/obj/vehicles/drop_pod/overmap/boarding_pod/east
	bound_width = 48
	bound_height = 32
	dir = 4

/obj/vehicles/drop_pod/overmap/boarding_pod/west
	bound_width = 48
	bound_height = 32
	dir = 8

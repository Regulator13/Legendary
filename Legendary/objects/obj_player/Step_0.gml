#region Get Input
if player_num = 0{
	var left = keyboard_check(ord("A"))
	var right = keyboard_check(ord("D"))
	var up = keyboard_check(ord("W"))
	var down = keyboard_check(ord("S"))
	var primary = keyboard_check(ord("G"))
	var secondary = keyboard_check(ord("Y"))
	var tertiary = keyboard_check(ord("U"))
	var quaternary = keyboard_check(ord("T"))
}
else if player_num = 1{
	var left = keyboard_check(vk_left)
	var right = keyboard_check(vk_right)
	var up = keyboard_check(vk_up)
	var down = keyboard_check(vk_down)
	var primary = keyboard_check(vk_numpad0)
	var secondary = keyboard_check(vk_numpad2)
	var tertiary = keyboard_check(vk_numpad3)
	var quaternary = keyboard_check(vk_numpad1)
}


#endregion

#region Moving
hspeed = 0
vspeed = 0
if left{
	hspeed = -1
}
if right{
	hspeed = 1
}
if up{
	vspeed = -1
}
if down{
	vspeed = 1
}

//Collisions with solid
if not place_free(x + hspeed, y){
	hspeed = 0
}
if not place_free(x, y + vspeed){
	vspeed = 0
}

//Keep in room bounds
if x < 0 x = 0
if y < 0 y = 0
if x > room_width x = room_width
if y > room_height y = room_height
#endregion

#region Attack
if attack_buffer < 1{
	if primary{
		create_punch()
	}
	if secondary{
		create_dart()
	}
}
else if attack_buffer > 0{
	attack_buffer -= 1
}

//Find current target every few steps
if target_search_buffer < 1{
	Target = instance_nth_nearest(x, y, obj_player, 2)
	if Target == self{
		Target = noone
	}
	target_search_buffer = target_search_buffer_max
}
else{
	target_search_buffer -= 1
}

#endregion

//Die
if hp <= 0{
	instance_destroy(self)
}

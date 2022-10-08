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
hspeed = sign(hspeed)*(max(abs(hspeed)-(deceleration_speed), 0))
vspeed = sign(vspeed)*(max(abs(vspeed)-(deceleration_speed), 0))
var mod_speed = player_speed * speed_multiplier

//Knockback
if abs(h_knockback) > 0 or abs(v_knockback) > 0{
	knockback_buffer -= 1
}

if knockback_buffer < 1{
	hspeed += h_knockback
	vspeed += v_knockback
	h_knockback = 0
	v_knockback = 0
	knockback_buffer = knockback_buffer_max
}

if x_force == 0 and y_force == 0{ //Moving only allowed if not flying into a wall
	if left{
		if hspeed > -mod_speed{
			hspeed -= mod_speed/acceleration_steps + deceleration_speed
		}
	}
	if right{
		if hspeed < mod_speed{
			hspeed += mod_speed/acceleration_steps + deceleration_speed
		}
	}
	if up{
		if vspeed > -mod_speed{
			vspeed -= mod_speed/acceleration_steps + deceleration_speed
		}
	}
	if down{
		if vspeed < mod_speed{
			vspeed += mod_speed/acceleration_steps + deceleration_speed
		}
	}
}

if abs(x_force) > 0 or abs(y_force) > 0{
	direction = 0
	direction = (arctan2(-y_force,x_force)*180)/pi
}

//If smashing against a solid object
if abs(x_force) > 0{
	if not place_free(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction)){
		//If a big wall is present, break it into small walls
		var BigInst = instance_place(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), par_wall)
		if BigInst != noone{
			with BigInst{
				//Create 4x4 of small walls in place
				for (var i=0; i<4; i++){
					for (var j=0; j<4; j++){
						instance_create_layer(x + i*8,y + j*8, "lay_instances", Small)
					}
				}
				instance_destroy(self)
			}
		}
		//If a small wall is present deal damage to it
		var Inst = instance_place(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), par_small_wall)
		if Inst != noone{
			var hp_lost = min(Inst.hp, abs(x_force)*(weight/100)) //how much damage the wall is taking
			Inst.hp -= hp_lost
			if Inst.hp <= 0{
				instance_destroy(Inst)
			}
			hp -= hp_lost //Deal damage to the player equal to the amount the wall took
			x_force -= sign(x_force) //Absorb some of the force
			if abs(x_force) <= 1 x_force = 0
		}
	}
	//If the player can move again, change x_force to h_speed
	else{
		hspeed = x_force
		x_force = 0
	}
}

//If smashing against a solid object
if abs(y_force) > 0{
	if not place_free(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction)){
		//If a big wall is present, break it into small walls
		var BigInst = instance_place(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), par_wall)
		if BigInst != noone{
			with BigInst{
				//Create 4x4 of small walls in place
				for (var i=0; i<4; i++){
					for (var j=0; j<4; j++){
						instance_create_layer(x + i*8,y + j*8, "lay_instances", Small)
					}
				}
				instance_destroy(self)
			}
		}
		//If a small wall is present deal damage to it
		var Inst = instance_place(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), par_small_wall)
		if Inst != noone{
			var hp_lost = min(Inst.hp, abs(y_force)*(weight/100)) //how much damage the wall is taking
			Inst.hp -= hp_lost
			if Inst.hp <= 0{
				instance_destroy(Inst)
			}
			hp -= hp_lost //Deal damage to the player equal to the amount the wall took
			y_force -= sign(y_force) //Absorb some of the force
			if abs(y_force) <= 1 y_force = 0
		}
	}
	//If the player can move again, change x_force to h_speed
	else{
		vspeed = y_force
		y_force = 0
	}
}

//Collisions with solid
//var h_iterations = ceil(abs(hspeed)/P_SIZE)
//var v_iterations = ceil(abs(vspeed)/P_SIZE)

var distant_collision = collision_line(x, y, x+hspeed, y+vspeed, par_solid, false, true)
var close_collision = not place_free(x + hspeed, y + vspeed)

if distant_collision or close_collision{
	if distant_collision{
		while place_free(x + lengthdir_x(8, direction), y + lengthdir_y(8, direction)){
			x += lengthdir_x(8, direction)
			y += lengthdir_y(8, direction)
		}
	}
	var i = 0
	while place_free(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction)){
		x += lengthdir_x(1, direction)
		y += lengthdir_y(1, direction)
		i++
		//If no wall is detected nearby, the player has come around a corner and should stop moving forward.
		if i >= P_SIZE{
			x -= lengthdir_x(P_SIZE, direction)
			y -= lengthdir_y(P_SIZE, direction)
			break
		}
	}
	//Save speed as force if it would damage the player
	if abs(hspeed) > 1.2*mod_speed{
		x_force = hspeed
	}
	//Save speed as force if it would damage the player
	if abs(vspeed) > 1.2*mod_speed{
		y_force = vspeed
	}
	if not distant_collision{
		if not place_free(x + hspeed, y) hspeed = 0
		if not place_free(x, y + vspeed) vspeed = 0
	}
	else{
		hspeed = 0
		vspeed = 0
	}
}
/*
for (var i=0;i<h_iterations;i++){
	if not place_free(x + sign(hspeed)*min(abs(hspeed),max(i*P_SIZE,P_SIZE)), y){
		while place_free(x + sign(hspeed), y){
			x += sign(hspeed)
		}
		//Save speed as force if it would damage the player
		if abs(hspeed) > 1.2*mod_speed{
			x_force = hspeed
		}
		hspeed = 0
		break
	}
}
for (var i=0;i<v_iterations;i++){
	if not place_free(x, y + sign(vspeed)*min(abs(vspeed),max(i*P_SIZE,P_SIZE))){
		while place_free(x, y + sign(vspeed)){
			y += sign(vspeed)
		}
		//Save speed as force if it would damage the player
		if abs(vspeed) > 1.2*mod_speed{
			y_force = vspeed
		}
		vspeed = 0
		break
	}
}
*/
/*
for (var i=0;i<h_iterations;i++){
	if not place_free(x + sign(hspeed)*min(abs(hspeed),max(i*P_SIZE,P_SIZE)), y){
		while place_free(x + x_inc + sign(hspeed), y){
			x_inc += sign(hspeed)
		}
		//Save speed as force if it would damage the player
		if abs(hspeed) > 1.2*mod_speed{
			x_force = hspeed
		}
		hspeed = 0
		break
	}
}
for (var i=0;i<v_iterations;i++){
	if not place_free(x + x_inc, y + sign(vspeed)*min(abs(vspeed),max(i*P_SIZE,P_SIZE))){
		while place_free(x + x_inc, y + y_inc + sign(vspeed)){
			y_inc += sign(vspeed)
		}
		//Save speed as force if it would damage the player
		if abs(vspeed) > 1.2*mod_speed{
			y_force = vspeed
		}
		vspeed = 0
		break
	}
}
//Add on stored increments
x += x_inc
y += y_inc
*/
//Keep in room bounds
if x < 0 x = 0
if y < 0 y = 0
if x > room_width x = room_width
if y > room_height y = room_height
#endregion

#region Attack
if switch_buffer < 1{
	if primary{
		var Inst = instance_place(x, y, par_attack_move)
		//If over an attack move, swap for it
		if Inst != noone{
			var temp_move = Inst.attack_move
			var temp_attack_type = Inst.attack_type
			var temp_sprite = Inst.sprite_index
			if primary_attack == 0 instance_destroy(Inst)
			else{
				Inst.attack_move = primary_attack
				Inst.attack_type = attack_types[0]
				Inst.sprite_index = obj_control.attack_sprites[0]
			}
			primary_attack = temp_move
			attack_types[0] = temp_attack_type
			obj_control.attack_sprites[0] = temp_sprite
			switch_buffer += 15
		}
		else if primary_attack != 0{
			//If move is an attack check attack buffer
			if attack_types[0] <= 2 and attack_buffer < 1{
				primary_attack()
			}
			//If move is a spell check cast buffer
			else if attack_types[0] == 3 and cast_buffer < 1{
				primary_attack()
			}
		}
	}
	if secondary{
		var Inst = instance_place(x, y, par_attack_move)
		//If over an attack move, swap for it
		if Inst != noone{
			var temp_move = Inst.attack_move
			var temp_attack_type = Inst.attack_type
			var temp_sprite = Inst.sprite_index
			if secondary_attack == 0 instance_destroy(Inst)
			else{
				Inst.attack_move = secondary_attack
				Inst.attack_type = attack_types[1]
				Inst.sprite_index = obj_control.attack_sprites[1]
			}
			secondary_attack = temp_move
			attack_types[1] = temp_attack_type
			obj_control.attack_sprites[1] = temp_sprite
			switch_buffer += 15
		}
		else if secondary_attack != 0{
			//If move is an attack check attack buffer
			if attack_types[1] <= 2 and attack_buffer < 1{
				secondary_attack()
			}
			//If move is a spell check cast buffer
			else if attack_types[1] == 3 and cast_buffer < 1{
				secondary_attack()
			}
		}
	}
	if tertiary{
		var Inst = instance_place(x, y, par_attack_move)
		//If over an attack move, swap for it
		if Inst != noone{
			var temp_move = Inst.attack_move
			var temp_attack_type = Inst.attack_type
			var temp_sprite = Inst.sprite_index
			if tertiary_attack == 0 instance_destroy(Inst)
			else{
				Inst.attack_move = tertiary_attack
				Inst.attack_type = attack_types[2]
				Inst.sprite_index = obj_control.attack_sprites[2]
			}
			tertiary_attack = temp_move
			attack_types[2] = temp_attack_type
			obj_control.attack_sprites[2] = temp_sprite
			switch_buffer += 15
		}
		else if tertiary_attack != 0{
			//If move is an attack check attack buffer
			if attack_types[2] <= 2 and attack_buffer < 1{
				tertiary_attack()
			}
			//If move is a spell check cast buffer
			else if attack_types[2] == 3 and cast_buffer < 1{
				tertiary_attack()
			}
		}
	}
	if quaternary{
		var Inst = instance_place(x, y, par_attack_move)
		//If over an attack move, swap for it
		if Inst != noone{
			var temp_move = Inst.attack_move
			var temp_attack_type = Inst.attack_type
			var temp_sprite = Inst.sprite_index
			if quaternary_attack == 0 instance_destroy(Inst)
			else{
				Inst.attack_move = quaternary_attack
				Inst.attack_type = attack_types[3]
				Inst.sprite_index = obj_control.attack_sprites[3]
			}
			quaternary_attack = temp_move
			attack_types[3] = temp_attack_type
			obj_control.attack_sprites[3] = temp_sprite
			switch_buffer += 15
		}
		else if quaternary_attack != 0{
			//If move is an attack check attack buffer
			if attack_types[3] <= 2 and attack_buffer < 1{
				quaternary_attack()
			}
			//If move is a spell check cast buffer
			else if attack_types[3] == 3 and cast_buffer < 1{
				quaternary_attack()
			}
		}
	}
}


#endregion

#region Buffers
if attack_buffer > 0{
	attack_buffer -= 1
}

if cast_buffer > 0{
	cast_buffer -= 1
}

if switch_buffer > 0{
	switch_buffer -= 1
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

//Regain staminas
if regen_buffer < 1{
	energy += energy_regen
	mp += mp_regen
	willpower += willpower_regen
	//if energy > energy_max energy = energy_max
	if energy > hp energy = hp
	//if mp > mp_max mp = mp_max
	if mp > mind mp = mind
	//if willpower > willpower_regen willpower = willpower_max
	if willpower > spirit willpower = spirit
	regen_buffer = regen_buffer_max
}
else{
	regen_buffer -= 1
}

//Trigger reversing of active spells
for (var i=0;i<max_active_spells;i++){
	if spell_effect_buffer[i] > 0{
		spell_effect_buffer[i]--
		if spell_effect_buffer[i] == 0{
			reverse_spell(spells_active[i])
			spells_active[i] = 0 //Remove spell from active list
		}
	}
}

#endregion

//Die
if hp <= 0{
	instance_destroy(self)
}

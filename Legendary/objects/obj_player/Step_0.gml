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

if x_force == 0 and y_force == 0{ //Moving only allowed if not flying into a wall
	if left{
		if hspeed > -player_speed{
			hspeed -= player_speed/acceleration_steps + deceleration_speed
		}
	}
	if right{
		if hspeed < player_speed{
			hspeed += player_speed/acceleration_steps + deceleration_speed
		}
	}
	if up{
		if vspeed > -player_speed{
			vspeed -= player_speed/acceleration_steps + deceleration_speed
		}
	}
	if down{
		if vspeed < player_speed{
			vspeed += player_speed/acceleration_steps + deceleration_speed
		}
	}
}

//If smashing against a solid object
if abs(x_force) > 0{
	if not place_free(x + sign(x_force), y){
		//If a big wall is present, break it into small walls
		var BigInst = instance_place(x + sign(x_force), y, par_wall)
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
		var Inst = instance_place(x + sign(x_force), y, par_small_wall)
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
	if not place_free(x, y + sign(y_force)){
		//If a big wall is present, break it into small walls
		var BigInst = instance_place(x, y + sign(y_force), par_wall)
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
		var Inst = instance_place(x, y + sign(y_force), par_small_wall)
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
var h_iterations = ceil(abs(hspeed)/P_SIZE)
var v_iterations = ceil(abs(vspeed)/P_SIZE)
var x_inc = 0 //store the number of pixels it takes to reach a collision
var y_inc = 0 //store the number of pixels it takes to reach a collision
for (var i=0;i<h_iterations;i++){
	if not place_free(x + sign(hspeed)*min(abs(hspeed),max(i*P_SIZE,P_SIZE)), y){
		while place_free(x + x_inc + sign(hspeed), y){
			x_inc += sign(hspeed)
		}
		//Save speed as force if it would damage the player
		if abs(hspeed) > 1.2*player_speed{
			x_force = hspeed
		}
		hspeed = 0
		break
	}
}
for (var i=0;i<v_iterations;i++){
	if not place_free(x, y + sign(vspeed)*min(abs(vspeed),max(i*P_SIZE,P_SIZE))){
		while place_free(x, y + y_inc + sign(vspeed)){
			y_inc += sign(vspeed)
		}
		//Save speed as force if it would damage the player
		if abs(vspeed) > 1.2*player_speed y_force = vspeed
		vspeed = 0
		break
	}
}
//Add on stored increments
x += x_inc
y += y_inc

/*
if collision_line(x, y, x+hspeed, y+vspeed, par_solid, false, true) != noone{ //If someone somewhere along the path to the next position
		//First move right up to the object
		while place_free(x + sign(hspeed), y) x += sign(hspeed)
		while place_free(x, y + sign(vspeed)) y += sign(vspeed)
		hspeed = 0
		vspeed = 0
}





while not place_free(x + min(hspeed,SMALLEST), y) or not place_free(x, y + min(vspeed, SMALLEST)){
	if not place_free(x + min(hspeed,SMALLEST), y){
		if speed > 2*player_speed{
			hp -= round(speed)
			var BigInst = instance_place(x + min(hspeed,SMALLEST), y, par_wall)
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
			var Inst = instance_place(x + min(hspeed, SMALLEST), y, par_small_wall)
			if Inst != noone{
				Inst.hp -= round(speed)*(weight/100)
				if Inst.hp <= 0{
					instance_destroy(Inst)
				}
			}
		}
		hspeed = reduce(hspeed)
	}
	if not place_free(x, y + min(vspeed, SMALLEST)){
		if speed > 2*player_speed{
			hp -= round(speed)
			var BigInst = instance_place(x, y + min(vspeed, SMALLEST), par_wall)
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
			var Inst = instance_place(x, y + min(vspeed, SMALLEST), par_small_wall)
			if Inst != noone{
				Inst.hp -= round(speed)*(weight/100)
				if Inst.hp <= 0{
					instance_destroy(Inst)
				}
			}
		}
		vspeed = reduce(vspeed)
	}
}
*/

//Keep in room bounds
if x < 0 x = 0
if y < 0 y = 0
if x > room_width x = room_width
if y > room_height y = room_height
#endregion

#region Attack
if attack_buffer < 1{
	var Inst = instance_place(x, y, par_attack_move)
	if primary{
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
			attack_buffer += 20
		}
		else if primary_attack != 0 primary_attack()
	}
	if secondary{
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
			attack_buffer += 20
		}
		else if secondary_attack != 0 secondary_attack()
	}
	if tertiary{
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
			attack_buffer += 20
		}
		else if tertiary_attack != 0 tertiary_attack()
	}
	if quaternary{
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
			attack_buffer += 20
		}
		else if quaternary_attack != 0 quaternary_attack()
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

//Die
if hp <= 0{
	instance_destroy(self)
}

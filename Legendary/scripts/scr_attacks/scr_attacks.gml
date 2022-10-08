function prepare_attack(attack){
	var energy_cost = attack.energy_cost
	var enough_energy = false //Does the player have enough energy to perform this move?
	if attack.attack_type <= 1 and energy >= energy_cost{
		enough_energy = true
		energy -= energy_cost
	}
	else if attack.attack_type == 2 and mp >= energy_cost{
		enough_energy = true
		mp -= energy_cost
	}
	
	var inaccuracy = attack.inaccuracy //attack's variance to right or left of target in pixels
	inaccuracy*= 100/(100+player_accuracy)
	
	if enough_energy{
		//Use same direction for all
		if instance_exists(Target){
			var dir = point_direction(x, y, Target.x, Target.y)
		}
		else{
			var dir = point_direction(x, y, room_width/2, room_height/2)
		}
		//Apply inaccuracy
		dir += irandom_range(-inaccuracy, inaccuracy)
		//Add on reload time after attacking
		reload = attack.reload //reload time of attack
		reload*= 100/(100+attack_speed)
		attack_buffer += reload
		
		//Set stats to return
		attack_stats = {
			attack_dir : dir
		}
	}
	else attack_stats = 0
	return attack_stats
}
function set_attack_stats(attack){
	//Set base attack stats
	damage = attack.damage*other.strength/100
	knockback = attack.knockback
	lifespan = attack.lifespan
	alarm[0] = lifespan
	team = other.player_num
	reload = other.reload
	attack_type = attack.attack_type
	speed = attack.move_speed
	direction = other.attack_stats.attack_dir
	sprite_index = attack.sprite
}

#region Melee Attacks
function create_punch(){ //Creates a 3X3 block of 3X3 punch particles
	var attack = obj_control.punch
	attack_stats = prepare_attack(attack)
	if attack_stats != 0{
		for (var i=-1; i<2; i++){
			for (var j=-1; j<=1; j++){
				with instance_create_layer(x + i*3, y + j*3, "lay_instances", par_attack){
					set_attack_stats(attack)
				}
			}
		}
	}
}

#endregion

#region Projectile Attacks					
function create_dart(){ //Creates a 1X5 line of 2X2 dart particles
	var attack = obj_control.dart
	attack_stats = prepare_attack(attack)
	if attack_stats != 0{
		for (var i=-2; i<=2; i++){
			with instance_create_layer(x + lengthdir_x(2*i, attack_stats.attack_dir), y + lengthdir_y(2*i, attack_stats.attack_dir), "lay_instances", par_attack){
				set_attack_stats(attack)
			}
		}
	}
}

function create_stonewall(){ //Creates a 10*2 horizontal line of 2X2 particles
	var attack = obj_control.stonewall
	attack_stats = prepare_attack(attack)
	var p = 2 //particle size
	if attack_stats != 0{
		for (var i=0; i<4; i++){
			for (var j=-10; j<=10; j++){
				var _x = x + lengthdir_x(p*j,90+ attack_stats.attack_dir) + lengthdir_x(p*i, attack_stats.attack_dir)
				var _y = y + lengthdir_y(p*j, 90+attack_stats.attack_dir) + lengthdir_y(p*i, attack_stats.attack_dir)
				with instance_create_layer(_x, _y, "lay_instances", par_attack){
					set_attack_stats(attack)
				}
			}
		}
	}
}
#endregion

#region Magic Attacks
function create_snowball(){ //Creates a single snowball that grows over time
	var attack = obj_control.snowball
	attack_stats = prepare_attack(attack)
	//If the player has enough energy
	if attack_stats != 0{
		with instance_create_layer(x, y, "lay_instances", obj_snowball){
			set_attack_stats(attack)
			//set size snowball can grow based on mind
			lifespan = min(max(round(log10(other.mind)*100), 100), 600)
			alarm[0] = lifespan
		}
	}
}
#endregion

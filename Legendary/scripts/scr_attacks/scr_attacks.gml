/// @function							create_punch()
/// @description						Creates a 3X3 block of 3X3 punch particles


function create_punch(){
	//Use same direction for all
	if instance_exists(Target){
		var dir = point_direction(x, y, Target.x, Target.y)
	}
	else{
		var dir = point_direction(x, y, room_width/2, room_height/2)
	}
	//Add on reload time after attacking
	reload = 30 //reload time of attack
	attack_buffer += reload
	for (var i=-1; i<2; i++){
		for (var j=-1; j<2; j++){
			with instance_create_layer(x + i*3, y + j*3, "lay_instances", par_attack){
				damage = 5
				lifespan = 60
				team = other.player_num
				reload = other.reload
				speed = 2
				direction = dir
				sprite_index = spr_punch
			}
		}
	}
}

/// @function							create_dart()
/// @description						Creates a 1X5 line of 2X2 dart particles
function create_dart(){
	//Use same direction for all
	if instance_exists(Target){
		var dir = point_direction(x, y, Target.x, Target.y)
	}
	else{
		var dir = point_direction(x, y, room_width/2, room_height/2)
	}
	//Add on reload time after attacking
	reload = 60 //reload time of attack
	attack_buffer += reload
	for (var i=-2; i<3; i++){
		with instance_create_layer(x + lengthdir_x(2*i, dir), y + lengthdir_y(2*i, dir), "lay_instances", par_attack){
			damage = 30
			lifespan = 80
			team = other.player_num
			reload = other.reload
			speed = 4
			direction = dir
			sprite_index = spr_dart
		}
	}
}
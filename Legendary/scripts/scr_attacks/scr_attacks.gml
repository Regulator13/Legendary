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
	for (var i=-1; i<2; i++){
		for (var j=-1; j<2; j++){
			with instance_create_layer(x + i*3, y + j*3, "lay_instances", par_attack){
				damage = 10
				lifespan = 60
				team = other.player_num
				speed = 2
				direction = dir
				sprite_index = spr_punch
			}
		}
	}
}
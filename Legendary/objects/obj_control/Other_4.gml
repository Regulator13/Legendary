/// @description Create attacks items

for (var i=0; i<4; i++){
	_x = irandom(room_width)
	_y = irandom(room_height)
	if place_empty(_x, _y){
		with instance_create_layer(_x, _y, "lay_instances", par_attack_move){
			var c = obj_control
			attack = choose(c.punch, c.dart, c.poison_arrow, c.stonewall, c.snowball, c.heavy_metal)
		}
	}
	else i++
}


/// @description Create attacks

for (var i=0; i<4; i++){
	_x = irandom(room_width)
	_y = irandom(room_height)
	if place_empty(_x, _y){
		with instance_create_layer(_x, _y, "lay_instances", par_attack_move){
			var c = obj_control
			attack = choose(c.punch, c.dart, c.stonewall)
			attack_move = attack.attack_move
			attack_type = attack.attack_type
			sprite_index = other.attack_sprites[attack_type]
		}
	}
	else i++
}


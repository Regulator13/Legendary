/// @description Create Players

with instance_create_layer(200, 200, "lay_instances", obj_player){
	player_num = 0
	sprite_index = spr_player
}

with instance_create_layer(400, 400, "lay_instances", obj_player){
	player_num = 1
	sprite_index = spr_player2
}

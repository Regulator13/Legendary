/// @description Create Players

randomize()

with instance_create_layer(300, 300, "lay_instances", obj_player){
	player_num = 0
	sprite_index = spr_player
	set_player_stats()
}

with instance_create_layer(400, 400, "lay_instances", obj_player){
	player_num = 1
	sprite_index = spr_player2
	set_player_stats()
}

attack_sprites = [spr_melee, spr_projectile, spr_melee, spr_melee] //sprite for each attack type

#region Attack Structures
#region Melee Attacks
punch = {
	attack_move : create_punch,
	attack_type : MELEE,
	energy_cost : 80,
	inaccuracy : 10,
	reload : 30,
	damage : 8, //72
	knockback : .2,
	move_speed : 2,
	lifespan : 20,
	sprite : spr_punch
}

#endregion

#region Projectile Attacks
dart = {
	attack_move : create_dart,
	attack_type : PROJECTILE,
	energy_cost : 50,
	inaccuracy : 15,
	reload : 60,
	damage : 20, //100
	knockback : 0,
	move_speed : 4,
	lifespan : 80,
	sprite : spr_dart
}

stonewall = {
	attack_move : create_stonewall,
	attack_type : PROJECTILE,
	energy_cost : 200,
	inaccuracy : 5,
	reload : 150,
	damage : 10, //800
	knockback : 10,
	move_speed : 1,
	lifespan : 300,
	sprite : spr_stonewall
}
#endregion

#endregion
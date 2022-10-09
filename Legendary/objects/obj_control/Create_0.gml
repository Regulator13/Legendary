/// @description Create Players

randomize()

attack_sprites = [spr_melee, spr_projectile, spr_magic, spr_spell] //sprite for each attack type

#region Attack Structures
#region Melee Attacks
punch = {
	attack_name : "Punch",
	attack_move : create_punch,
	attack_type : MELEE,
	energy_cost : 80,
	inaccuracy : 10,
	reload : 30,
	damage : 8, //72
	knockback : .2,
	move_speed : 2,
	lifespan : 20,
	effect : 0,
	sprite : spr_punch
}

stonewall = {
	attack_name : "Stonewall",
	attack_move : create_stonewall,
	attack_type : MELEE,
	energy_cost : 200,
	inaccuracy : 5,
	reload : 150,
	damage : 10, //800
	knockback : 1,
	move_speed : 1,
	lifespan : 70,
	effect : 0,
	sprite : spr_stonewall
}

#endregion

#region Projectile Attacks
dart = {
	attack_name : "Dart",
	attack_move : create_dart,
	attack_type : PROJECTILE,
	energy_cost : 50,
	inaccuracy : 15,
	reload : 60,
	damage : 20, //100
	knockback : 0,
	move_speed : 4,
	lifespan : 80,
	effect : 0,
	sprite : spr_dart
}

poison_arrow = {
	attack_name : "Poison Arrow",
	attack_move : create_poison_arrow,
	attack_type : PROJECTILE,
	energy_cost : 80,
	inaccuracy : 10,
	reload : 90,
	damage : 5, //100
	knockback : 0,
	move_speed : 5,
	lifespan : 80,
	effect : apply_dart_poison,
	sprite : spr_poison_arrow
}

#endregion

#region Magic Attacks
snowball = {
	attack_name : "Snowball",
	attack_move : create_snowball,
	attack_type : MAGIC_ATTACK,
	energy_cost : 200,
	inaccuracy : 5,
	reload : 300,
	damage : 4, //?
	knockback : 0,
	move_speed : 1,
	lifespan : 600,
	effect : 0,
	sprite : spr_snowball
}
#endregion

#region Magic Spells
heavy_metal = {
	attack_name : "Heavy Metal",
	attack_move : heavy_metal,
	attack_type : MAGIC_SPELL,
	can_stack : false,
	energy_cost : 100,
	physical_damage_multiplier : .1,
	knockback_multiplier : .1,
	speed_multiplier : .2,
	reload : 300,
	lifespan : 600,
}
#endregion
#endregion


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
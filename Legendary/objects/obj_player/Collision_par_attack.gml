/// @description Take damage

if other.team != player_num{
	//Reduce player health and attack damage by each other
	var temp = other.damage
	other.damage -= hp
	hp -= temp
	
	//knockback player
	hspeed += lengthdir_x(other.knockback/(weight/100), other.direction)
	vspeed += lengthdir_y(other.knockback/(weight/100), other.direction)

	//If either is less than 1, destroy them
	if other.damage <= 0{
		instance_destroy(other)
	}
	if hp <= 0{
		instance_destroy(self)
	}
}
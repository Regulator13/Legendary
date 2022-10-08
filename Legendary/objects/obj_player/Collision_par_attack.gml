/// @description Take damage

if other.team != player_num{
	//Reduce player health and attack damage by each other
	var temp = other.damage
	other.damage -= hp
	//Reduce health by attack damage
	if other.attack_type == MELEE or other.attack_type == PROJECTILE{
		hp -= temp*physical_damage_multiplier
	}
	else hp -= temp
	
	//knockback player
	var knockback_amt = (other.knockback/(weight/100))*knockback_multiplier
	h_knockback += lengthdir_x(knockback_amt, other.direction)
	v_knockback += lengthdir_y(knockback_amt, other.direction)

	//If either is less than 1, destroy them
	if other.damage <= 0{
		instance_destroy(other)
	}
	if hp <= 0{
		instance_destroy(self)
	}
}
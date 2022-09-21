/// @description Take damage

//Reduce wall health and attack damage by each other
var temp = other.damage
other.damage -= hp
hp -= temp

//If either is less than 1, destroy them
if other.damage <= 0{
	instance_destroy(other)
}
if hp <= 0{
	instance_destroy(self)
}
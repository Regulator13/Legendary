/// @description Grow
var _x = [0, -sprite_width, sprite_width, 0]
var _y = [-sprite_height, 0, 0, sprite_height]
if lifespan > grow_buffer + 2{
	for (var i=0;i<4;i++){
		if irandom(2){
			if not instance_place(x + _x[i], y + _y[i], obj_snowball){
				with instance_create_layer(x + _x[i], y + _y[i], "lay_instances", obj_snowball){
					//Reduce the lifespan of the snowball so it dies from the outside
					damage = other.damage
					knockback = other.knockback		
					team = other.team
					reload = other.reload
					attack_type = other.attack_type
					speed = other.speed
					direction = other.direction
					lifespan = other.lifespan - (grow_buffer + 2)
					alarm[0] = lifespan
				}
			}
		}
	}
}

/// @description Find Target

lifespan = 60 //The number of steps the attack lasts
damage = 10
reload = 30 //The number of steps the player must wait before attacking again
speed = 2
direction = point_direction(x, y, 0, 0)
alarm_set(0, lifespan)
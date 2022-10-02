/// @description Set Variables

player_num = 0
Target = noone
reload = 30 //Placeholder for attack reloads
regen_buffer_max = 10
regen_buffer = regen_buffer_max
acceleration_steps = 10 //number of steps it takes to get to full speed
deceleration_speed = .1 //speed players slow down
x_force = 0 //saved h_speed of a player during a collision
y_force = 0 //saved v_speed of a player during a collision

#region Player Stats
//Physical
hp_max = 1000 //Player's health
strength = 100 //Strength/100 = physical attack multiplier
energy_regen = 10 //Energy regained every 10 steps
hp = hp_max
energy = hp_max

//Mental (magic)
mind_max = 1000 //Player's mental health
magic = 100 //Magic/100 = magical attack multiplier
mp_regen = 10 //mp regained every 10 steps
mind = mind_max
mp = mind_max

//Spirit
spirit_max = 1000 //Player's spiritual health
will = 100 //Will/100 = spiritual attack multiplier
willpower_regen = 10 //willpower regained every 10 steps
spirit = spirit_max
willpower = spirit_max

//Other
player_speed = 1 //How fast the player moves
attack_speed = 0 //100/(100+attack_speed) = multiplier for reload times
player_accuracy = 0 //100/(100+player_accuracy) = multiplier for how accurate attacks are
weight = 100 //weight*knockback/100 = speed knocked back at
#endregion

#region Buffers
attack_buffer_max = 30
target_search_buffer_max = 10

attack_buffer = attack_buffer_max
target_search_buffer = target_search_buffer_max
#endregion

primary_attack = create_punch
secondary_attack = create_dart
tertiary_attack = create_stonewall
quaternary_attack = 0
attack_types = [MELEE, PROJECTILE, MELEE, MELEE] //attack_type of attacks in each slot
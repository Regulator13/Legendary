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
h_knockback = 0 //amount of horizontal knockback that will strike the player afted a delay.
v_knockback = 0 //amount of vertical knockback that will strike the player afted a delay
knockback_buffer_max = 3 //delay before knockback applies
knockback_buffer = knockback_buffer_max

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
max_active_spells = 10 //max number of spells player can have active at once
#endregion

#region Multipliers
physical_damage_multiplier = 1 //How much damage is taken by physical attacks
knockback_multiplier = 1 //How much knockback effects you
speed_multiplier = 1 //How fast you move
#endregion

#region Effects
poison_quantity = 0 //How much poison is in your body (or how long it will take to dissapate)
poison_toxicity = 0 //How damaging that poison is
#endregion

#region Buffers
attack_buffer_max = 30 //Time between using attaacks
target_search_buffer_max = 10 //Time between updating targets
cast_buffer = 0 //Time between casting spells
switch_buffer = 0 //Time between switching out for new attacks
spell_effect_buffer = array_create(max_active_spells, 0) //how long active spells are lasting
poison_check_buffer_max = 10 //number of steps between poison dealing damage/dissipating

attack_buffer = attack_buffer_max
target_search_buffer = target_search_buffer_max
poison_check_buffer = poison_check_buffer_max
#endregion

primary_attack = create_punch
secondary_attack = create_dart
tertiary_attack = create_stonewall
quaternary_attack = create_snowball
var c = obj_control
attacks_equipped = [c.punch, c.dart, c.stonewall, c.snowball]
//Put entire moves into an array so all pertinent stats can be transferred to items
spells_active = array_create(max_active_spells, 0) //Which spells are currently active (used with spell_effect_buffer)

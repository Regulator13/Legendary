/// @function			set_player_stats()
/// @description		Randomly sets all players stats

function set_player_stats(){
	//Physical
	hp_max = stat_chooser(100000) //Player's health
	strength = stat_chooser(100) //Strength/100 = physical attack multiplier
	energy_regen = stat_chooser(10) //Energy regained every 10 steps
	hp = hp_max
	energy = hp_max

	//Mental (magic)
	mind_max = stat_chooser(1000) //Player's mental health
	magic = stat_chooser(100) //Magic/100 = magical attack multiplier
	mp_regen = stat_chooser(10) //mp regained every 10 steps
	mind = mind_max
	mp = mind_max

	//Spirit
	spirit_max = stat_chooser(1000) //Player's spiritual health
	will = stat_chooser(100) //Will/100 = spiritual attack multiplier
	willpower_regen = stat_chooser(10) //willpower regained every 10 steps
	spirit = spirit_max
	willpower = spirit_max

	//Other
	player_speed = 1 + max(stat_chooser(1) - 1, 0) //How fast the player moves
	attack_speed = stat_chooser(20) //100/(100+attack_speed) = multiplier for reload times
	player_accuracy = stat_chooser(20) //100/(100+player_accuracy) = multiplier for how accurate attacks are
	weight = stat_chooser(100) //weight*knockback/100 = speed knocked back at
}
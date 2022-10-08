function check_stacking(spell){
	//If the spell cannot stack, do not cast it.
	if not spell.can_stack{
		for (var i=0;i<max_active_spells;i++){
			if spells_active[i] == spell{
				return false
			}
		}
		return true
	}
	return true
}

function prepare_spell(spell){
	var energy_cost = spell.energy_cost
	var enough_energy = false //Does the player have enough energy to perform this move?
	if spell.attack_type <= 1 and energy >= energy_cost{
		enough_energy = true
		energy -= energy_cost
	}
	else if spell.attack_type <= 3 and mp >= energy_cost{
		enough_energy = true
		mp -= energy_cost
	}
	
	if enough_energy{
		reload = spell.reload //reload time of spell
		reload*= 100/(100+attack_speed)
		cast_buffer += reload
		apply_spell(spell)
		
	}
	
}
function apply_spell(spell){
	//Modify character stats based on changes in spell
	physical_damage_multiplier *= spell.physical_damage_multiplier
	knockback_multiplier *= spell.knockback_multiplier
	speed_multiplier *= spell.speed_multiplier
	
	//Reverse the spell after the lifespan is up
	for (var i=0;i<max_active_spells;i++){
		if spell_effect_buffer[i] < 1{
			spell_effect_buffer[i] = spell.lifespan
			spells_active[i] = spell
			break
		}
	}
}

function reverse_spell(spell){
	//Revert character stats based on changes in spell
	physical_damage_multiplier /= spell.physical_damage_multiplier
	knockback_multiplier /= spell.knockback_multiplier
	speed_multiplier /= spell.speed_multiplier
}

#region Magic Spells
function heavy_metal(){ //Turns the player to metal reducing knockback and damage
	var spell = obj_control.heavy_metal
	if check_stacking(spell){
		prepare_spell(spell)
	}
}
#endregion
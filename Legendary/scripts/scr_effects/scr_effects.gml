//These are additional effects that occur when an attack strikes a player.

//Deal damage to the player over time
function apply_dart_poison(target){
	target.poison_quantity += 3
	target.poison_toxicity = max(target.poison_toxicity, 5)
}
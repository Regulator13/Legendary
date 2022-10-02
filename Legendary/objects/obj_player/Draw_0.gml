draw_self()
draw_healthbar(x-20, y+24, x+20, y+28, (hp/hp_max)*100, c_black, c_red, c_green, 0, false, true)
draw_healthbar(x-20, y+24, x+20, y+28, (energy/hp_max)*100, c_black, c_red, c_purple, 0, false, true)

if player_num == 0{
	draw_text(0, 0, hp)
	draw_text(0, 20, strength)
	draw_text(0, 40, energy_regen)
	draw_text(0, 80, x_force)
	draw_text(0, 100, y_force)
	
	draw_text(75, 0, mind)
	draw_text(75, 20, magic)
	draw_text(75, 40, mp_regen)
	
	draw_text(150, 0, spirit)
	draw_text(150, 20, will)
	draw_text(150, 40, willpower_regen)
	
	draw_text(225, 0, player_speed)
	draw_text(225, 20, attack_speed)
	draw_text(225, 40, player_accuracy)
	draw_text(225, 60, weight)
	draw_text(225, 80, speed)
}

if player_num == 1{
	draw_text(room_width - 300, 0, hp)
	draw_text(room_width - 300, 20, strength)
	draw_text(room_width - 300, 40, energy_regen)
	
	draw_text(room_width - 225, 0, mind)
	draw_text(room_width - 225, 20, magic)
	draw_text(room_width - 225, 40, mp_regen)
	
	draw_text(room_width - 150, 0, spirit)
	draw_text(room_width - 150, 20, will)
	draw_text(room_width - 150, 40, willpower_regen)
	
	draw_text(room_width - 75, 0, player_speed)
	draw_text(room_width - 75, 20, attack_speed)
	draw_text(room_width - 75, 40, player_accuracy)
	draw_text(room_width - 75, 60, weight)
}
extends PlayerActionSuperState
class_name PlayerJab

func _ready():
	state_name = "PlayerJab"
	animation = "jab"
	animation2 = "neutral_air"
	
	# Hitbox stats
	# Chose to put this here so there isn't a child of 'Hitbox.gd' for each 
	# type of hitbox, the hitbox can just pull from the current action 
	# which is hopefully always the correct one... 
	hitbox_priority = 0 # ? 
	damage = 10
	knockback_base = 1
	knockback_growth = 1
	angle = 0
	
func enter():
	player_action_setup()
	run_player_action()
	
func run_player_action():
	if player.current_condition == player.condition.GROUNDED:
		player.ap.play(animation)
	elif player.current_condition == player.condition.IN_AIR:
		player.ap.play(animation2)

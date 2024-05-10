extends PlayerActionSuperState
class_name PlayerForwardSmash

func _ready():
	state_name = "PlayerForwardSmash"
	animation = "forward_smash"
	animation2 = "neutral_air" # Needs to change 
	 
func enter():
	player_action_setup()
	run_player_action()
	
func player_action_setup():
	player.is_active = true
	
func run_player_action():
	if player.current_condition == player.condition.GROUNDED:
		player.ap.play(animation)
	elif player.current_condition == player.condition.IN_AIR:
		player.ap.play(animation2)

func on_animation_finished(_anim_name):
	transition.emit(self, "PlayerInactive")

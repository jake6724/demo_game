extends PlayerActionSuperState
class_name PlayerJab

func _ready():
	state_name = "PlayerJab"
	animation = "jab"
	animation2 = "neutral_air"
	 
func enter():
	get_player_ref()
	player_action_setup()
	run_player_action()
	
func player_action_setup():
	player.is_active = true
	player.ap.animation_finished.connect(on_animation_finished)
	
func run_player_action():
	if player.current_condition == player.condition.GROUNDED:
		player.ap.play(animation)
	elif player.current_condition == player.condition.IN_AIR:
		player.ap.play(animation2)

func on_animation_finished(anim_name):
	transition.emit(self, "PlayerInactive")

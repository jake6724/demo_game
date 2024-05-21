extends PlayerActionSuperState
class_name PlayerUpTilt

func _ready():
	state_name = "PlayerUpTilt"
	animation = "up_tilt"
	 
func enter():
	player_action_setup()
	run_player_action()
	
func player_action_setup():
	player.is_active = true
	
func run_player_action():
	player.ap.play(animation)

func on_animation_finished(_anim_name):
	transition.emit(self, "PlayerInactive")

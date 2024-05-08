extends PlayerActionSuperState
class_name PlayerJump

func _ready():
	state_name = "PlayerJump"
	animation = "jump"
	 
func enter():
	player_action_setup()
	run_player_action()
	
func player_action_setup():
	player.is_active = true
	
func run_player_action():
	player.velocity.y = player.jump_velocity
	player.ap.play(animation)

func on_animation_finished(_anim_name):
	transition.emit(self, "PlayerInactive")

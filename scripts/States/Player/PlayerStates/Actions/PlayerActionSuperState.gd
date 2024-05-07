extends State
class_name PlayerActionSuperState

@onready var player : PlayerSuperClass

func enter():
	get_player_ref()
		
func get_player_ref():
	player = get_tree().get_first_node_in_group("Player")

func player_action_setup():
	player.is_active = true
	player.ap.animation_finished.connect(on_animation_finished)

func run_player_action():
	player.ap.play(animation)
	
func on_animation_finished(anim_name):
	transition.emit(self, "PlayerInactive")

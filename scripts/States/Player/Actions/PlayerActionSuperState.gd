extends State
class_name PlayerActionSuperState

@onready var player : PlayerSuperClass

# Hitbox stats
# Chose to put this here so there isn't a child of 'Hitbox.gd' for each 
# type of hitbox, the hitbox can just pull from the current action 
# which is hopefully always the correct one... 
var hitbox_priority: int
var damage: float 
var knockback_base: float
var knockback_growth: float 
var angle: float

	
func enter():
		pass
		
func get_player_ref():
	player = get_tree().get_first_node_in_group("Player")

func player_action_setup():
	player.is_active = true
	player.ap.animation_finished.connect(on_animation_finished)

func run_player_action():
	player.ap.play(animation)
	
func on_animation_finished(_anim_name):
	transition.emit(self, "PlayerInactive")
	
func state_initialize():
	get_player_ref()
	player.ap.animation_finished.connect(on_animation_finished)

extends PlayerActionSuperState
class_name PlayerDown

# TODO: This class should be interrutpable by other actions

func _ready():
	state_name = "PlayerDown"
	animation = "down"
	animation2 = "falling"

func enter():
	player_action_setup()
	# run_player_action()
	
func state_physics_update(_delta):
	if Input.is_action_pressed("move_down"):
		run_player_action()
	else:
		transition.emit(self, "PlayerInactive")
    
func player_action_setup():
	player.is_active = true
	
func run_player_action():
	# Apply movement
	player.position.y += 1
	
	# Determine which down animation to play 
	if player.current_condition == player.condition.GROUNDED:
		player.ap.play(animation)
	# else:
	# 	player.jump_counter += 1
	# 	player.ap.play(animation2)
		
func on_animation_finished(_anim_name):
	player.is_active = false
	# Remove the transition to inactive, because this
	# action uses go_to_inactive() (Can find in animation player)

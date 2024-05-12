extends PlayerActionSuperState
class_name PlayerJump

# TODO: This class should be interrutpable by other actions

func _ready():
	state_name = "PlayerJump"
	animation = "jump"
	animation2 = "jump_in_air"
	  
func enter():
	player_action_setup()
	run_player_action()
	
func player_action_setup():
	player.is_active = true
	
func run_player_action():
	# Apply movement
	player.velocity.y = player.jump_velocity
	
	# Determine which jump animation to play 
	if player.jump_counter == 0:
		player.jump_counter += 1
		player.ap.play(animation)
	else:
		player.jump_counter += 1
		player.ap.play(animation2)
		
func on_animation_finished(_anim_name):
	player.is_active = false
	# Remove the transition to inactive, because this
	# action used go_to_inactive()

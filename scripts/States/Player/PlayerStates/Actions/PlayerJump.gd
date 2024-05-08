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
	print("jump counter: ", player.jump_counter)
	# Determine which jump animation to play 
	if player.jump_counter == 0:
		print("First jump")
		player.jump_counter += 1
		player.ap.play(animation)
	else:
		print("Second jump")
		player.jump_counter += 1
		player.ap.play(animation2)
	print("jump counter: ", player.jump_counter)

func on_animation_finished(_anim_name):
	#print("trans")
	transition.emit(self, "PlayerInactive")

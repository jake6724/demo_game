extends PlayerActionSuperState
class_name PlayerDown

# TODO: This class should be interrutpable by other actions

func _ready():
	state_name = "PlayerDown"
	animation = "down"
	animation2 = "falling"
	animation3 = "crouch_walk"

func enter():
	player_action_setup()
	player.set_collision_mask_value(9, false)

func exit(): 
	player.set_collision_mask_value(9, true)
	
func state_physics_update(_delta):
	# Handle fast falling
	# TODO: This doesn't feel right
	if not player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y += player.gravity * get_process_delta_time() * player.fast_fall_velocity
	
	# Continue to run state actions until down is released
	if Input.is_action_pressed("move_down"):
		run_player_action()
	else:
		# Reset is_active here manually. This is generally handled by on_animation_finished()
		# But since we want to hold the action do it this way
		player.is_active = false
		transition.emit(self, "PlayerInactive")
	
func run_player_action():	
	# Determine which down animation to play 
	if player.current_condition == player.condition.GROUNDED:
		if player.current_movement_state.state_name == "PlayerWalk":
			player.ap.play(animation3)
		else:
			player.ap.play(animation)
	elif player.current_condition == player.condition.IN_AIR:
		player.ap.play(animation2)

func state_initialize():
	get_player_ref()
		
func on_animation_finished(_anim_name):
	# Don't use for this action because we want to hold the position until player releases
	pass
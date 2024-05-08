extends PlayerMovementSuperState
class_name PlayerRun

# Maybe states that can be transition into should be an enum or something?

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerRun"
	animation = "run"

func state_physics_update(_delta):
	check_for_transitions()
	state_move()
	state_animate()
	
func check_for_transitions():
	if abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
		transition.emit(self, "PlayerWalk")
	
	elif abs(player.x_input) == 0:
		transition.emit(self, "PlayerIdle")
	
func state_move():
	# Check if action is running
	if player.is_active:
		# Only apply movement if character is in the air
		if player.current_condition == player.condition.IN_AIR:
			player.velocity.x = player.x_input * player.air_speed
		elif player.current_condition == player.condition.GROUNDED:
			transition.emit(self, "PlayerIdle")
	# Apply movement in both conditions (grounded/in_air) if no action
	else:
		if player.current_condition == player.condition.IN_AIR:
			player.velocity.x = player.x_input * player.air_speed
		elif player.current_condition == player.condition.GROUNDED:
			player.velocity.x = player.x_input * player.run_speed
			
func state_animate():
	if not player.is_active: 
		player.ap.play(animation)

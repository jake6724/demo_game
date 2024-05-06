extends PlayerMovementSuperState
class_name PlayerIdle

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerIdle"
	animation = "idle"
	animation2 = "falling"

func state_physics_update(delta):
	check_for_transitions()
	state_move()
	state_animate()
	
func check_for_transitions():
	if abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
		transition.emit(self, "PlayerWalk")
	
	elif abs(player.x_input) >= player.run_threshold:
		transition.emit(self, "PlayerRun")
	
func state_move():
	#if abs(player.x_input) >= player.run_threshold:
	player.velocity.x = move_toward(player.velocity.x, 0, player.run_speed)
	
func state_animate():
	if not player.is_active: 
		if player.current_condition == player.condition.GROUNDED:
			player.ap.play(animation)
		elif player.current_condition == player.condition.IN_AIR:
			player.ap.play(animation2)

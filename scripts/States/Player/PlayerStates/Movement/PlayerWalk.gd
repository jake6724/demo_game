extends PlayerMovementSuperState
class_name PlayerWalk

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerWalk"
	animation = "walk"

func state_physics_update(delta):
	check_for_transitions()
	state_move()
	state_animate()
	
func check_for_transitions():
	if abs(player.x_input) >= player.run_threshold:
		transition.emit(self, "PlayerRun")
	
	elif abs(player.x_input) == 0:
		transition.emit(self, "PlayerIdle")
	
func state_move():
	#if abs(player.x_input) >= player.run_threshold:
	player.velocity.x = player.x_input * player.walk_speed
	
func state_animate():
	if not player.is_active: 
		player.ap.play(animation)
	

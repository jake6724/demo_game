extends PlayerMovementSuperState
class_name PlayerDodge

func _ready():
	# Used in state_logger() (part of base state class)
	state_name = "PlayerDodge"
	animation = "dodge"
	animation2 = "airdodge"

func state_physics_update(_delta):
	check_for_transitions()
	state_move()
	state_animate()
	
func check_for_transitions():
	pass
	# Do not check for transitions if the player is active and grounded
	# If the player is inactive, always check for transitions
	if player.is_active:
		if player.current_condition == player.condition.IN_AIR:
			if abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
				transition.emit(self, "PlayerWalk")
			
			elif abs(player.x_input) >= player.run_threshold:
				transition.emit(self, "PlayerRun")
	else:
		if abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
				transition.emit(self, "PlayerWalk")
			
		elif abs(player.x_input) >= player.run_threshold:
			transition.emit(self, "PlayerRun")
	
func state_move():
	pass
	# Keep player from moving
	player.velocity.x = move_toward(player.velocity.x, 0, player.run_speed)
	
func state_animate():
	pass
	# Only play animation if player is inactive
	if not player.is_active: 
		if player.current_condition == player.condition.GROUNDED:
			player.ap.play(animation)
		elif player.current_condition == player.condition.IN_AIR:
			player.ap.play(animation2)

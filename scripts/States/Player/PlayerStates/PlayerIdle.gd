extends PlayerMovementSuperState
class_name PlayerIdle

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerIdle"

func state_physics_update(delta):
	if abs(player.x_input) >= player.run_threshold:
		transition.emit(self, "PlayerRun")
	
	elif abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
		transition.emit(self, "PlayerWalk")
	
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.run_speed)
		# Determine whether to play grounded or in air idle animation
		if player.current_condition == player.condition.GROUNDED:
			player.ap.play("idle")
		elif player.condition.IN_AIR:
			player.ap.play("falling")
	

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
		player.ap.play("idle")
	

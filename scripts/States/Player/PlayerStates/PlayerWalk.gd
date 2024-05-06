extends PlayerMovementSuperState
class_name PlayerWalk

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerWalk"

func state_physics_update(delta):
	if abs(player.x_input) >= player.run_threshold:
		transition.emit(self, "PlayerRun")
	
	elif abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
		player.velocity.x = player.x_input * player.walk_speed
		set_player_sprite_direction(player.x_input)
		player.ap.play("walk")
	
	else:
		transition.emit(self, "PlayerIdle")

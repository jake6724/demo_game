extends PlayerMovementSuperState
class_name PlayerRun

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerRun"

func state_physics_update(delta):
	if abs(player.x_input) >= player.run_threshold:
		player.velocity.x = player.x_input * player.run_speed
		set_player_sprite_direction(player.x_input)
		player.ap.play("run")
	
	elif abs(player.x_input) < player.run_threshold and abs(player.x_input) > 0:
		transition.emit(self, "PlayerWalk")
	
	else:
		transition.emit(self, "PlayerIdle")

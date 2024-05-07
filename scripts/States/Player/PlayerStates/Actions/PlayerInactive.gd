extends PlayerActionSuperState
class_name PlayerInactive

func state_physics_update(delta):
	player.is_active = false
	
	if Input.is_action_just_pressed("forward_tilt"):
		transition.emit(self, "PlayerForwardTilt")
		
	if Input.is_action_just_pressed("jab"):
		transition.emit(self, "PlayerJab")

func run_player_action():
	pass

func player_action_setup():
	pass

func on_animation_finished(anim_name):
	pass


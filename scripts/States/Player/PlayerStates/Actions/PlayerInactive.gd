extends PlayerActionSuperState
class_name PlayerInactive

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerInactive"

func state_physics_update(_delta):
	player.is_active = false
	
	if Input.is_action_just_pressed("forward_tilt"):
		transition.emit(self, "PlayerForwardTilt")
		
	if Input.is_action_just_pressed("jab"):
		transition.emit(self, "PlayerJab")
		
	if Input.is_action_just_pressed("move_up"):
		transition.emit(self, "PlayerJump")

func run_player_action():
	pass

func player_action_setup():
	pass

func on_animation_finished(_anim_name):
	pass


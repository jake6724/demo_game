extends PlayerActionSuperState
class_name PlayerInactive

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerInactive"

func state_physics_update(_delta):
	# Reset action state values 
	player.is_active = false
	
	# Reset jump. This is done here and not PlayerSuperClass _p_p
	# because it will get reset on same frame as first jump
	if player.is_on_floor():  
		player.jump_counter = 0
	
	if Input.is_action_just_pressed("forward_tilt"):
		transition.emit(self, "PlayerForwardTilt")
		
	if Input.is_action_just_pressed("jab"):
		transition.emit(self, "PlayerJab")
		
	if Input.is_action_just_pressed("move_up"):
		# Only allow to enter jump if jump count valid 
		if player.jump_counter < player.jump_max:
			transition.emit(self, "PlayerJump")

func run_player_action():
	pass

func player_action_setup():
	pass

func on_animation_finished(_anim_name):
	pass


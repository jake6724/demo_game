extends PlayerActionSuperState
class_name PlayerInactive

func _ready():
	# Used in state_logger() (part of base State class)
	state_name = "PlayerInactive"

func state_physics_update(_delta):
	# Reset jump. This is done here and not PlayerSuperClass _p_p
	# because it will get reset on same frame as first jump
	if player.is_on_floor():  
		player.jump_counter = 0
		
	# Grounded jab actions
	if Input.is_action_just_pressed("jab"):
		if player.current_condition == player.condition.GROUNDED:
			if abs(player.x_input) > player.ftilt_threshold:
				transition.emit(self, "PlayerForwardTilt")
			elif player.y_input < player.utilt_threshold:
				transition.emit(self, "PlayerUpTilt")
			else:
				transition.emit(self, "PlayerJab")

	# Aerial jab actions go here 
	
	# Grounded smash actions
	if Input.is_action_just_pressed("forward_smash_right"):
		# Manually set correction player direction
		player.set_character_direction(1)
		if player.current_condition == player.condition.GROUNDED:	
			transition.emit(self, "PlayerForwardSmash")
			
	if Input.is_action_just_pressed("forward_smash_left"):
		# Manually set correction player direction
		player.set_character_direction(-1)
		if player.current_condition == player.condition.GROUNDED:	
			transition.emit(self, "PlayerForwardSmash")

	# Jump
	if Input.is_action_just_pressed("move_up"):
		# Only allow to enter jump if jump count valid 
		if player.jump_counter < player.jump_max:
			transition.emit(self, "PlayerJump")

	# Move down 
	if Input.is_action_pressed("move_down"):
		transition.emit(self, "PlayerDown")

func run_player_action():
	pass

func player_action_setup():
	pass

func on_animation_finished(_anim_name):
	pass


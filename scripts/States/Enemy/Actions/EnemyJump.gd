extends EnemySuperState
class_name EnemyJump

func state_physics_update(_delta):
	enemy.velocity.y = enemy.jump_velocity
	enemy.ap.play("jump")
	
	# Figure out how to wait for jump to play or something ?
	
	transition.emit(self, "EnemyIdle")

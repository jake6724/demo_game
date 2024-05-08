extends EnemySuperState
class_name EnemyFollow

# TODO: Resolve falling/stuck to platform issues.
	
func state_physics_update(_delta: float):
	# Determine the global distance between player and enemy
	var distance2D = player.global_position - enemy.global_position

	if abs(distance2D.x) > x_distance_max:
		enemy.velocity.x = sign(distance2D.x) * enemy.move_speed
		x_target_reached = false
	else: 
		enemy.velocity.x = 0
		x_target_reached = true 
		
	if distance2D.y < y_distance_max and enemy.velocity.y >= 0:
		enemy.velocity.y += enemy.jump_velocity
		y_target_reached = false
	else:
		y_target_reached = true
		
	if x_target_reached and y_target_reached:
		transition.emit(self, "EnemyAttackContinuous")
	else:
		enemy.ap.play("run")

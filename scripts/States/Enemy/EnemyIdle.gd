extends EnemySuperState
class_name EnemyIdle

func state_physics_update(_delta: float):
	enemy.ap.play("idle")
	enemy.velocity.x = move_toward(player.velocity.x, 0, player.run_speed)
	
	#if not is_player_in_range():
		#transition.emit(self, "EnemyFollow")
	#else:
		#enemy.ap.play("idle")

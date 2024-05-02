extends EnemySuperState
class_name EnemyIdle

func state_physics_update(delta: float):
	if not is_player_in_range():
		Transitioned.emit(self, "EnemyFollow")
	else:
		enemy.ap.play("idle")

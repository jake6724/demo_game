extends EnemyMovementSuperState
class_name EnemyAttackContinuous

func state_physics_update(_delta: float):
	if not is_player_in_range():
		transition.emit(self, "EnemyFollow")
	else:
		enemy.ap.play("attack_continuous")

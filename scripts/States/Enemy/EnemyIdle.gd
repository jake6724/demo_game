extends EnemySuperState
class_name EnemyIdle

#func state_physics_update(delta: float):
	#if not is_player_in_range():
		#Transitioned.emit(self, "EnemyFollow")
	#else:
		#enemy.ap.play("idle")
		
var idle_time: float

func randomize_attack():
	var attack = "shoot"
	idle_time = randf_range(1, 2)

func enter():
	randomize_attack()
	
func state_physics_update(delta: float):
	if idle_time > 0:
		idle_time -= delta
	else:
		Transitioned.emit(self, "EnemyAttack")
	enemy.ap.play("idle")
	#if not is_player_in_range():
		#Transitioned.emit(self, "EnemyAttack")
	#else:
		#enemy.ap.play("idle")

extends State
class_name EnemyIdle

@export var enemy : EnemySuperClass

func state_physics_update(delta: float):
	enemy.ap.play("idle")
	

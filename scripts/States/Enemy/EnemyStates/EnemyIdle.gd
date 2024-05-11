extends EnemySuperState
class_name EnemyIdle

func _ready():
	state_name = "EnemyIdle"

func state_physics_update(_delta: float):
	enemy.ap.play("idle")
	enemy.velocity.x = move_toward(player.velocity.x, 0, player.run_speed)
	
	transition.emit(self, "EnemyFollow")

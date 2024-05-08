extends Hurtbox
class_name PlayerHurtbox

func _init():
	collision_layer = 0 # No layer
	collision_mask = 6  # EnemyHitbox

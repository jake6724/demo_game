extends Hurtbox
class_name EnemyHurtbox

func _init():
	collision_layer = 0 # No layer 
	collision_mask = 4  # PlayerHitbox
	

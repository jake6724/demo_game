extends EnemySuperState
class_name EnemyKnockback

var knocked_frames = 30
var frame_counter = 0 

func _ready():
	enemy = get_tree().get_first_node_in_group("Enemy")
	state_name = "EnemyKnockback"
	
func enter():
	#enemy = get_tree().get_first_node_in_group("Enemy")
	frame_counter = 0 
	enemy.velocity.x += 100
	enemy.velocity.y += -200

func state_physics_update(_delta):
	print(frame_counter)
	if frame_counter != knocked_frames:
		enemy.ap.play("knockback")
		frame_counter += 1 
	else:
		transition.emit(self, "EnemyIdle")

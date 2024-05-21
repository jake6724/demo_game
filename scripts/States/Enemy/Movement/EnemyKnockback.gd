extends EnemyMovementSuperState
class_name EnemyKnockback

var knocked_frames
var frame_counter = 0 
var slowdown = 10 # 0.051

func _ready():
	enemy = get_tree().get_first_node_in_group("Enemy")
	state_name = "EnemyKnockback"
	
func enter():
	frame_counter = 0
	knocked_frames = enemy.hs
	enemy.velocity = enemy.lv

func state_physics_update(_delta):
	if frame_counter != knocked_frames:
		if enemy.knocked_right: # Attack hit this character to the right
			if (enemy.velocity.x - slowdown) >= 0:
				enemy.velocity.x -= slowdown
			else:
				enemy.velocity.x = 0
			#else: Subtract just enough to make velocity 0
				#enemy.velocity.x - a = 0
				
		else: # Attack hit this character to the left
			if (enemy.velocity.x + slowdown) <= 0:
				enemy.velocity.x += slowdown
			else:
				enemy.velocity.x = 0

		enemy.ap.play("knockback")
		frame_counter += 1 
	else:
		transition.emit(self, "EnemyIdle")

func set_enemy_knockback():
	pass

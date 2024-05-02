extends State
class_name EnemyFollow

@export var enemy : EnemySuperClass
@export var move_speed := 250

var x_distance_max = 30.0
var y_distance_max = -50
var x_target_reached : bool = false 
var y_target_reached : bool = false 

# TODO: Temp
var jump_velocity = -400

var player : player_superclass

func enter():
	player = get_tree().get_first_node_in_group("Player")
	
func state_physics_update(delta: float):
	# Determine the global distance between player and enemy
	var distance2D = player.global_position - enemy.global_position
	#print("Distance2D:", distance2D)
	#print("EnemyVelY:", enemy.velocity.y)
	
	if abs(distance2D.x) > x_distance_max:
		# Move in a constant move speed
		# distance2D is determined by the sign of distance.x 
		enemy.velocity.x = sign(distance2D.x) * move_speed
	else: 
		enemy.velocity.x = 0
		x_target_reached = true 
		
	if distance2D.y < y_distance_max and enemy.velocity.y >= 0:
		#print("EnemyVelY:", enemy.velocity.y)
		#print("able to jump")
		enemy.velocity.y += jump_velocity
		
	if x_target_reached:
		print("Transmit")
		Transitioned.emit(self, "EnemyIdle")
		
	enemy.ap.play("run")
	

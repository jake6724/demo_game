extends State
class_name EnemyUnarmedFollow

@export var enemy : EnemyUnarmed
@export var move_speed := 250

var x_distance_max = 30.0
var y_distance_max = 1

# TODO: Temp
var jump_velocity = -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player : player_superclass

func enter():
	player = get_tree().get_first_node_in_group("Player")
	print("Target found")
	
func Physics_Update(delta: float):
	# TODO: Temp
	# Add the gravity.
	
	# Determine the global distance between player and enemy
	var distance2D = player.global_position - enemy.global_position
	print(distance2D)
	
	if abs(distance2D.x) > x_distance_max:
		# Move in a constant move speed
		# distance2D is determined by the sign of distance.x 
		enemy.velocity.x = sign(distance2D.x) * move_speed
	
	else: 
		enemy.velocity = Vector2()

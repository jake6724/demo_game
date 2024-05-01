extends State
class_name EnemyUnarmedFollow

@export var enemy : EnemyUnarmed
@export var move_speed := 250

var max_distance_from_player = 30.0

var player : player_superclass

func enter():
	player = get_tree().get_first_node_in_group("Player")
	print("Target found")
	
func Physics_Update(delta: float):
	print("Running Physics_Update")
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > max_distance_from_player:
		print("Need to be closer")
		enemy.velocity = direction.normalized() * move_speed
	else: 
		print("Close enough")
		enemy.velocity = Vector2()

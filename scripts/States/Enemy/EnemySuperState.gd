extends State
class_name EnemySuperState

@export var enemy : EnemySuperClass
var player : player_superclass


func enter():
	# Load reference to player 
	player = get_tree().get_first_node_in_group("Player")

func get_player_pos(): # Eventually account for hit box sizes
	var distance2D = player.global_position - enemy.global_position
	
	return player.global_position

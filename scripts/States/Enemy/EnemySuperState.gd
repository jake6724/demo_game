extends State
class_name EnemySuperState

# Find a way to make this set to an enemy by default 
# so it isn't required to do manually in inspector
@export var enemy : EnemySuperClass
var player : PlayerSuperClass

# Used for is_player_in_range(), and follow
var x_distance_max = 30
var x_distance_offset = 15
var y_distance_max = -50
var x_target_reached : bool = false 
var y_target_reached : bool = false 
var player_in_range : bool

func enter():
	# Load reference to player 
	player = get_tree().get_first_node_in_group("Player")

func is_player_in_range(): # Eventually account for hit box sizes
	var distance2D = player.global_position - enemy.global_position
	
	if abs(distance2D.x) > x_distance_max:
		return false 
	elif distance2D.y < y_distance_max:
		return false 
	else:
		return true 

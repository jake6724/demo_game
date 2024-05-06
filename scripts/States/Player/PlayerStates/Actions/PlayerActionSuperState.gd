extends State
class_name PlayerActionSuperState

var player : PlayerSuperClass

func enter():
	# Load reference to player 
	player = get_tree().get_first_node_in_group("Player")


extends State
class_name PlayerMovementSuperState

@onready var player : PlayerSuperClass

func enter():
	get_player_ref()
		
func get_player_ref():
	player = get_tree().get_first_node_in_group("Player")

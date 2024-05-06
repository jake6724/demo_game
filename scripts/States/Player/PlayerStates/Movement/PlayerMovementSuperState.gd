extends State
class_name PlayerMovementSuperState

var player : PlayerSuperClass

func enter():
	# Load reference to player 
	player = get_tree().get_first_node_in_group("Player")

func set_player_sprite_direction(direction):
	if direction != 0:
		player.sprite.flip_h = (direction <= -0.001)
		player.sprite.position.x = direction * 4

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var player = get_node("player_main")
	$player_main.health_updated.connect(on_player_health_updated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_player_health_updated(health):
	$HUD.update_player_health(health)
	

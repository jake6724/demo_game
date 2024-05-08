extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerHealthLabel.text = str(0) + "%"
	$EnemyHealthLabel.text = str(0) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_player_health(health):
	$PlayerHealthLabel.text = str(health) + "%"
	
func update_enemy_health(health):
	$EnemyHealthLabel.text = str(health) + "%"

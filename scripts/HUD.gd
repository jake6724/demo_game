extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_player_health(damage):
	# This needs to increment not set ! 
	$PlayerHealthLabel.text = str(damage)
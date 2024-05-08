extends Node2D

# Initialize variables
var arena_screen = "res://scenes/Arena.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Switch between screens (temp for testing) 
	if Input.is_action_just_pressed("change_screen"):
		go_to_arena_screen()
	
func go_to_arena_screen():
	get_tree().change_scene_to_file(arena_screen)

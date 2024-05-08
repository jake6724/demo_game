extends Node2D

# Initialize variables
var character_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	# Pre-load character scene
	character_screen = preload("res://scenes/CharacterScene.tscn")
	
	# Connect to character signals
	$PlayerMain.health_updated.connect(on_player_health_updated)
	$EnemyMain.health_updated.connect(on_enemy_health_updated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Switch between screens (temp for testing) 
	if Input.is_action_just_pressed("change_screen"):
		go_to_character_screen()

# Triggered when player emits 'health_updated' 
func on_player_health_updated(health):
	$HUD.update_player_health(health)
	
func on_enemy_health_updated(health):
	$HUD.update_enemy_health(health)

func go_to_character_screen():
	get_tree().change_scene_to_packed(character_screen)

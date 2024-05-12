extends Area2D
class_name Hitbox

var hitbox_collision_node: CollisionShape2D

func _init():
	# Need to be updated based on player or enemy
	collision_layer = 0
	collision_mask = 0 

func _ready():
	# Could set hitbox_priority here 
	pass

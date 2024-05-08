extends Hitbox
class_name PlayerHitbox

func _init():
	collision_layer = 4 # PlayerHitbox
	collision_mask = 0  # None
	damage = 10.0

func _ready():
	# Set collider to child of hitbox node 
	hitbox_collision_node = get_child(0)

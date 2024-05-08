extends Area2D
class_name Hurtbox

var hurtbox_collision_node: CollisionShape2D

func _init():
	# Need to be updated based on player or enemy
	collision_layer = 0
	collision_mask = 0
	
func _ready():
	self.area_entered.connect(on_area_entered) 
	
func on_area_entered(hitbox: Hitbox):
	if hitbox.owner == self.owner:
		return 
		
	if hitbox == null:
		return 
	
	#print(self.owner,": Detected hitbox owner: ", hitbox.owner)
	
	if self.owner.has_method("hurtbox_entered"):
		self.owner.hurtbox_entered(hitbox.damage)
		

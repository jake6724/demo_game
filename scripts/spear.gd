extends CharacterBody2D


var spear_velocity = Vector2(0, 0)
var speed = 250

func _physics_process(delta):
	var collision_info = move_and_collide(spear_velocity.normalized() * delta * speed)
	print(collision_info)
	
func _move_and_slide():
	pass
	

extends CharacterBody2D
class_name EnemyUnarmed

@onready var ap = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		print("Here comes gravity")
		velocity.y += gravity * delta
	else:
		print("Is on floor")
		
	print("other v", velocity.y)
		
	if velocity.length() > 0:
		ap.play("run")
	else:
		ap.play("idle")
		
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
	
	move_and_slide()

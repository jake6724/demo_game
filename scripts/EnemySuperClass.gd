extends CharacterBody2D
class_name EnemySuperClass

@onready var ap = $AnimationPlayer
@export var shotFrame: bool
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#if velocity.length() > 0:
		#ap.play("run")
	#else:
		#ap.play("idle")
		
	if ap.current_animation == "attack":
		var frame = float(ap.current_animation_position * (10/1.5))
		if frame > 5.5 and frame < 5.7:
			shotFrame = true
		else:
			shotFrame = false
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
	
	move_and_slide()

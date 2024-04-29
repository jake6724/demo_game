extends CharacterBody2D
class_name PlayerParent

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var fast_fall_velocity = 20

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("fast_fall") and not is_on_floor() and velocity.y >= 0:
		velocity.y += gravity * delta * fast_fall_velocity

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity # negative values go up 

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if direction != 0:
		switch_direction(direction)

	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0: 
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
			
func switch_direction(direction):
	sprite.flip_h = (direction == -1)
	sprite.position.x = direction * 4

extends CharacterBody2D
class_name EnemySuperClass

var health:float = 0.0
signal health_updated
signal enemy_hurtbox_entered

@onready var ap = $AnimationPlayer
@onready var sm = $EnemyMovementStateMachine
@onready var label_current_state = $LabelCurrentState

# Enemy Stats
@export var move_speed : float = 275.0 
@export var jump_velocity : float = -400.0 


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready(): 
	label_current_state.text = str(sm.initial_state.state_name)
	
	# Connect to StateMachine signals
	sm.change_current_state.connect(on_change_current_state)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
	
	move_and_slide()

func on_change_current_state(new_state_name):
	label_current_state.text = new_state_name
	
func hurtbox_entered(damage):
	update_health(damage)
	enemy_hurtbox_entered.emit()
	#velocity.x += 1000
	
func update_health(damage:float):
	health += float(damage)
	health_updated.emit(health)
	
func on_change_current_movement_state(new_state_name):
	label_current_state.text = new_state_name
	
	

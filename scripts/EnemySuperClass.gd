extends CharacterBody2D
class_name EnemySuperClass

signal health_updated
signal enemy_hurtbox_entered

@onready var ap = $AnimationPlayer
@onready var sm = $EnemyMovementStateMachine
@onready var label_current_state = $LabelCurrentState

# Character stats
#Movement
var jump_counter: int = 0
var jump_max: int = 2
var run_speed: float = 300.0 
var walk_speed:float = 200.0
var run_threshold: float = .8
var air_speed: float = 250.0
var jump_velocity: float = -400.0
var fast_fall_velocity:float = 20.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Combat
var damage: float = 10.0
var health: float = 0.0
var weight: float = 100.0 # Lower values are heavier
var knockback_resistance: float = 1.0 
#Knockback state values
var kb: float
var ls: float
var lv: Vector2
var ad: Vector2
var knocked_right: bool # true = left, false = right
var knocked_down: bool # true = up, left = down
var hs: int 

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

func on_change_current_state(new_state):
	label_current_state.text = new_state.state_name
	
func hurtbox_entered(damage, new_kb, new_ls, new_lv, new_ad, new_hs):
	update_health(damage)
	
	kb = new_kb
	ls = new_ls
	lv = new_lv
	ad = new_ad
	hs = new_hs
	
	if ad.x <= 0:
		knocked_right = true
	else:
		knocked_right = false 
		
	if ad.y >= 0: # TODO: I don't think this is set up correctly
		knocked_down = true
	else:
		knocked_down = false 
		
	#print("Attacker is left: ", attacker_is_left)
	#print("Attacker is above: ", attacker_is_above)
	
	enemy_hurtbox_entered.emit()
	
func update_health(damage:float):
	health += float(damage)
	health_updated.emit(health)
	
func on_change_current_movement_state(new_state_name):
	label_current_state.text = new_state_name
	
	

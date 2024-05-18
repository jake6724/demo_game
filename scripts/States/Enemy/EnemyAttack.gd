extends EnemySuperState
class_name EnemyAttack

@export var move_speed := 250 # Move this to EnemySuperClass
@onready var s: Marker2D = get_parent().get_parent().get_node("Node2D").get_node("Marker2D")
const spearPath = preload('res://scenes/spear.tscn')
var hasShot = false
	
func state_physics_update(delta: float):
	if enemy.ap.current_animation == "idle":
		hasShot = false
		enemy.ap.play("attack")
	elif enemy.ap.current_animation == "attack":
		if enemy.shotFrame and not hasShot:
			shoot()
			hasShot = true
	if not enemy.ap.is_playing():
		Transitioned.emit(self, "EnemyIdle")

func shoot():
	var spear = spearPath.instantiate()
	get_parent().get_parent().add_child(spear)
	spear.global_position = s.global_position
	var distance = s.global_position - player.global_position
	spear.spear_velocity = Vector2(-1 * distance.x, -1 * distance.y)
	var angle = ((-1*distance.y) / (abs(distance.x) * -1))
	
	if distance.x > 0:
		spear.rotate(atan(angle))
	elif distance.y < 0:
		spear.rotate(atan(angle) - (PI/2))
	else:
		spear.rotate(atan(angle) + (PI/2))
	

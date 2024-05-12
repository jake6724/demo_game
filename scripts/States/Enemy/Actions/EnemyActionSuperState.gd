extends State
class_name EnemyActionSuperState

@onready var enemy : EnemySuperClass

func get_enemy_ref():
	enemy = get_tree().get_first_node_in_group("Enemy")

func state_initialize():
	get_enemy_ref()
	enemy.ap.animation_finished.connect(on_animation_finished)

func on_animation_finished(_anim_name):
	transition.emit(self, "EnemyInactive")

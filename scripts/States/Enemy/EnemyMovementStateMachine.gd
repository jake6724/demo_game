extends StateMachine
class_name EnemyMovementStateMachine

func _ready():
	return
	# Check through all children of 'StateMachine' node 
	# and add to states dict if child is of 'State' class
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			# Connect to child's transition signal
			child.transition.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
	# Connect to enemy signals 
	enemy = get_tree().get_first_node_in_group("Enemy")
	enemy.character_hurtbox_entered.connect(on_enemy_hurtbox_entered)
	
func on_enemy_hurtbox_entered():
	on_child_transition(current_state, "EnemyKnockback")
	

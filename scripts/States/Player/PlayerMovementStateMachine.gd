extends StateMachine
class_name PlayerMovementStateMachine

func _ready():
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
		
	# Get reference to player 
	player = get_tree().get_first_node_in_group("Player")

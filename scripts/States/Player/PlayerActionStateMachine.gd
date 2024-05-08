extends StateMachine
class_name PlayerActionStateMachine

func on_player_ready():
	initialize_states()
	
func initialize_states():
	var state_to_initialize: State
	for s in states:
		state_to_initialize = states[s]
		state_to_initialize.state_initialize()

extends Node2D

var current_state : State
var states : Dictionary = {} 

func ready(): 
	# Check through all children of 'StateMachine' node 
	# and add to states dict if child is of 'State' class
	for child in get_children():
		if child is State:
			states[child.name] = child
			
func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if  current_state:
		current_state.Physics_Update(delta)
		
		
		

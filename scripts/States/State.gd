extends Node
class_name State
var state_name = "State"

signal transition 

func enter():
	pass
	
func exit():
	pass

func state_update(_delta: float):
	pass
	
func state_physics_update(_delta: float):
	pass

func state_logger(message):
	print(state_name,": ", message)

extends Node
class_name State
var state_name = "State"
var animation = "RESET"
var animation2

signal transition 

func enter():
	pass
	
func exit():
	pass

func state_update(_delta: float):
	pass
	
func state_physics_update(_delta: float):
	pass
	
func check_for_transitions():
	pass
	
func state_move():
	pass

func state_animate():
	pass

func state_logger(message):
	print(state_name,": ", message)

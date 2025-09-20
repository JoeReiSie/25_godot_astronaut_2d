extends Node
class_name StateFsmNode

var fsm

func enter():
	pass


func update(_delta):
	pass


func physics_update(_delta):
	pass


func exit():
	pass

func change_state(next_state):
	fsm.change_state(self, next_state)

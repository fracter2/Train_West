extends Node


var activated:bool = true #Change this when actually having the propper game

func _physics_process(delta):
	if not activated: return
	
	

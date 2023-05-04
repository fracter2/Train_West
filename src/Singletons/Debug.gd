extends Node


var activated:bool = true #Change this when actually having the propper game

func _physics_process(delta):
	if not activated: return
	
	

func _input(event):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen

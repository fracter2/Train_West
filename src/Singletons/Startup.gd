extends Node


func _ready():
	center_screen()
	
	OS.set_window_title("Train West: the train that goes West...")
	OS.window_resizable = false


func center_screen():
	var screen_size = OS.get_real_window_size()
	var window_size = OS.window_size
	OS.center_window()
	
	

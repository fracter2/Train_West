extends Control

func _ready():
	$"%Start".grab_focus()
	

func _on_Start_pressed():
	get_tree().change_scene("res://src/Level/Train.tscn")

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()


func _on_Fullscreen_button_down():
	OS.window_fullscreen = not OS.window_fullscreen

extends Node

onready var rng = RandomNumberGenerator.new()

onready var pause_menu = preload("res://src/UI/Pause_Menu.tscn")
var pause_menu_active:bool = false
var pause_menu_just_escaped:bool = false


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_pause_menu"):
		if get_node_or_null("/root/World") != null and not (pause_menu_active or pause_menu_just_escaped):
			get_node("/root/World").add_child(pause_menu.instance())
			pause_menu_active = true
	
	if pause_menu_just_escaped: 
			pause_menu_just_escaped = false
			pause_menu_active = false



func get_random_num(var from:float = 0, var to:float = 1) -> float:
	return rng.randf_range(from, to)



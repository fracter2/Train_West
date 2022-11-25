class_name HighlightState
extends Resource


var spinning:bool = false 
var spin_speed:float = 1
var spin_mod:float = 1
var spin_responsiveness:float = 5

var move_speed:Vector2 = Vector2(15,20)
var move_mod:Vector2 = Vector2(1,1)


var dim_speed:Vector2 = Vector2(10,15)					# Dim is for "Dimensions"
var dim_mod:Vector2 = Vector2(1,1)
var dimentions:Vector2 = Vector2(1,1)
var dim_dist_mod:float = 1								# Vector2 or float?

var target_dimentions:Vector2 = Vector2(1, 1)
var target_size:float = 2
var target_rot:float = 0
var target_pos:Vector2 = Vector2.ZERO


var state:int
enum STATES { DEFAULT, FOLLOW_MOUSE, FOLLOW_MOUSE_RESIZE}


func _init(settings:Array = ["Nothing"]):
	if settings[0] == "Nothing":
		#spinning = false 
		#spin_speed = 1
		pass

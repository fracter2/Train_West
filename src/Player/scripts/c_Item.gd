extends Node2D
class_name Item


var equiped:bool = false
var stack_size:int = 1
var stack_size_max:int  = 1

export var item_name:String = "Item"
export var description:String = "This is a very nice and cool item"

export var refire_time:float = 0.5


# Position Offset, for the purpose of moving it, between for example the back/holding/aiming/reloading/etc
var default_poffset: Vector3 = Vector3.ZERO										# The z axis is fo rotation, in radians (2 = 360)
var cur_poffset: Vector3 = Vector3.ZERO

# export various aim stats later, maybe?
var highlight_settings:HighlightState
var highlight_aim_info:Array = [Vector2(1,1), AIM_STATES.FOLLOW_MOUSE, Vector2(1,1), 3, -0.25, false]
enum AIM_STATES { DEFAULT, FOLLOW_MOUSE, FOLLOW_MOUSE_RESIZE }



func equip():
	pass

func fire():
	pass

func reload():
	pass

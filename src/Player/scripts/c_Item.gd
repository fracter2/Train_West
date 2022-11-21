extends Node2D
class_name Item


var item_name:String = "Item"
var description:String = "This is a very nice and cool item"

var highlight_aim_info:Array = [Vector2(1,1), AIM_STATES.FOLLOW_MOUSE, Vector2(1,1), 3, -0.25, false]
enum AIM_STATES { DEFAULT, FOLLOW_MOUSE, FOLLOW_MOUSE_RESIZE}

func equip():
	pass

func fire():
	pass

func reload():
	pass

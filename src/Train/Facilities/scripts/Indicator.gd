extends Polygon2D

export var value_node_string:String
export var value_node_signal:String
var value_node:Node
#export var val_node_deffered:String
var val:float = 0
var coordinate_empty_top:Vector2
var coordinate_full_top:Vector2
var coordinate_empty_bot:Vector2
var coordinate_full_bot:Vector2

var indicator_node: Node


func _ready():
	indicator_node = $Indicator
	
	# This assumes point 0 and 3 travel to 1 and 2
	coordinate_empty_top = indicator_node.polygon[0]
	coordinate_full_top = indicator_node.polygon[1]
	coordinate_full_bot = indicator_node.polygon[2]
	coordinate_empty_bot = indicator_node.polygon[3]
	#indicator_node.get_node_and_resource("/root/Train_manager")
	value_node = get_node(value_node_string)
	value_node.connect(value_node_signal, self,"set_value")


func set_value(value:float):
	value = clamp(value, 0, 1)
	
	indicator_node.polygon[1] = coordinate_empty_top.linear_interpolate(coordinate_full_top, value)
	indicator_node.polygon[2] = coordinate_empty_bot.linear_interpolate(coordinate_full_bot, value)
	

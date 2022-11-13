extends Position2D

var spinning:bool = false setget set_state
var spin_speed:float = 180

var dimentions:Vector2 = Vector2(1,1)
var target_dimensions:float = 2
var target_pos:Vector2 = Vector2.ZERO



func _process(delta):
	global_position.x = lerp(global_position.x, target_pos.x, 0.4)
	global_position.y = lerp(global_position.y, target_pos.y, 0.7)
	
	if spinning:
		rotation_degrees += spin_speed * delta
		dimentions.x = lerp(dimentions.x, target_dimensions, 0.7)
		dimentions.y = lerp(dimentions.y, target_dimensions, 0.7)

	
	$Polygon2D1.position = dimentions * Vector2(-1, 1)	*8
	$Polygon2D2.position = dimentions * Vector2(-1, -1)	*8
	$Polygon2D3.position = dimentions * Vector2(1, -1)	*8
	$Polygon2D4.position = dimentions * Vector2(1, 1)	*8
	#print(dimentions)
	
	

func set_state(state:bool):
	spinning = state
	rotation = 0
	

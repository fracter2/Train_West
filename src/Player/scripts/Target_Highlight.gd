extends Position2D

var spinning:bool = false setget set_state
var spin_speed:float = 0.3

var dimentions:Vector2 = Vector2(1,1)
var target_dimentions:Vector2 = Vector2(1, 1)
var target_size:float = 2
var target_rot:float = 0
var target_pos:Vector2 = Vector2.ZERO

#var rotation_speed
#var global move_speed: Vector2()


#var default_stats: HighlightStats

#var state
#enum STATES { FOLLOW_OBJ, FOLLOW_MOUSE, FOLLOW_MOUSE_RESIZE}



func _process(delta):
	global_position.x = lerp(global_position.x, target_pos.x, 15 *delta)
	global_position.y = lerp(global_position.y, target_pos.y, 20 *delta)
	
	if spinning:
		target_rot += spin_speed * PI * delta
		
	
	rotation = lerp(rotation, target_rot *PI, 5 *PI *delta)
	
	
	dimentions.x = lerp(dimentions.x, target_size * target_dimentions.x, 10 * delta)
	dimentions.y = lerp(dimentions.y, target_size * target_dimentions.y, 15 * delta)
	
	#var reverse_dim = Vector2(dimentions.y, dimentions.x)
	$Polygon2D1.position = dimentions * Vector2(-1, 1)	*8
	$Polygon2D2.position = dimentions * Vector2(-1, -1)	*8
	$Polygon2D3.position = dimentions * Vector2(1, -1)	*8
	$Polygon2D4.position = dimentions * Vector2(1, 1)	*8
	#print(dimentions)
	
	

func set_state(state:bool):
	spinning = state
	#if state == false:
	#	target_rot = 0

	

extends Position2D

var spinning:bool = false setget set_state
var spin_speed:float = 0.9
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

var prev_setting:HighlightState = HighlightState.new()

func _ready():
	print(prev_setting.target_pos)

func _process(delta):
	
	var p:Vector2 = target_pos #+ global_position - get_parent().velocity
	var d:Vector2 = target_dimentions
	if state == STATES.FOLLOW_MOUSE:
		p = get_global_mouse_position()
	elif state == STATES.FOLLOW_MOUSE_RESIZE:
		p = get_global_mouse_position()
		d = target_dimentions * dim_dist_mod * (get_parent().global_position - p).length() 
	
	
	if spinning:
		target_rot += spin_speed * spin_mod * delta 
	
	rotation = lerp(rotation, target_rot * PI, spin_responsiveness *PI *delta)
	
	var v = get_parent().position - get_parent().last_pos 
	global_position.x = lerp(global_position.x - v.x, p.x, move_speed.x * move_mod.x *delta)
	global_position.y = lerp(global_position.y - v.y, p.y, move_speed.y * move_mod.y *delta)
	
	
	
	dimentions.x = lerp(dimentions.x, target_size * d.x, dim_speed.x * dim_mod.x *delta)
	dimentions.y = lerp(dimentions.y, target_size * d.y, dim_speed.y * dim_mod.y *delta)
	
	$Polygon2D1.position = dimentions * Vector2(-1, 1)	*8
	$Polygon2D2.position = dimentions * Vector2(-1, -1)	*8
	$Polygon2D3.position = dimentions * Vector2(1, -1)	*8
	$Polygon2D4.position = dimentions * Vector2(1, 1)	*8
	
	
	
	

func set_state(state:bool):
	spinning = state
	#if state == false:
	#	target_rot = 0

func set_targets(pos:Vector2, new_state:int = 1, dim:Vector2 = Vector2(1,1), size:float = 2, rot:float = 0, spin:bool = false):
	state = new_state
	target_pos = pos
	target_dimentions = dim
	target_size = size
	target_rot = rot
	spinning = spin


#func set_speeds(move_speed:Vector2 = Vector2(1,1), spin_speed:float = 0.3)
#	pass


	

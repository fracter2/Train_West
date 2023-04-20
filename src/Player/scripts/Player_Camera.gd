extends Camera2D

export var zoom_k_min:float = 0.2
export var zoom_k_max:float = 1.6
var zoom_k:float = 1
var zoom_k_t:float
onready var zoom_default:Vector2 = zoom

export(float, 0, 1) var interpolation_strength := 0.3

func _physics_process(delta):
	position = get_local_mouse_position() * interpolation_strength
	
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		zoom_k += Input.get_axis("ui_down", "ui_up") * 0.2 						# 0.2 are the steps up and down per press
		zoom_k = clamp(zoom_k, zoom_k_min, zoom_k_max)
	zoom_k_t = lerp(zoom_k_t, zoom_k, 4*delta)
	zoom = zoom_default * zoom_k_t

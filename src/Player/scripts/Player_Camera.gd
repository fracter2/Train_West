extends Camera2D

export(float, 0, 1) var interpolation_strength := 0.3

func _physics_process(delta):
	position = get_local_mouse_position() * interpolation_strength

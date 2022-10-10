extends Area2D



func _on_Out_of_bounds_Area_body_exited(body):
	body.global_position = Vector2(0, -500)

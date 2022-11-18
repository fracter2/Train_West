extends Area2D

export var vel_force_Ko:Vector2 = Vector2(0.03,0)

func _physics_process(delta):
	gravity_vec = -Vector2(Train_manager.velocity * vel_force_Ko.x, 0)		# Negative, cuz left is negative
	
	

func _on_Out_of_bounds_Area_body_exited(body):
	if not body.is_in_group("vanity"):
		body.global_position = Vector2(0, -500)

extends Polygon2D

func _physics_process(delta):
	rotation += Train_manager.train_velocity * 0.02 

#func set_speed(var train_vel):
	

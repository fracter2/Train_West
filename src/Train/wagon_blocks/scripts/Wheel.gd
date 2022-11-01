extends Polygon2D

export(float, 0, 1) var speed_variable:float = 1

func _physics_process(delta):
	rotation += Train_manager.train_velocity * 0.02 * speed_variable



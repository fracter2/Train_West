extends RigidBody2D


export var fuel_amount:int = 30
export var throw_force:int = 50


func _on_Despawn_Timer_timeout():
	queue_free()

func consume():
	fuel_amount = 0
	$"Despawn Timer".start()




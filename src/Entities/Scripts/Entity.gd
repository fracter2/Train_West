extends KinematicBody2D

class_name Entity

var hp: int

func take_damage(var dmg:int):
	hp -= dmg;
	if hp < 0:
		die()
		

func die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends KinematicBody2D

class_name Entity


var hp: int = 100
export(int) var hp_max: int = 100

func _ready():
	hp = hp_max


# This function is intented to maybe be overriden when creating new script
func take_damage(var dmg:int):
	hp -= dmg;
	if hp < 0:
		die()
		
    
# This function is intented to maybe be overriden when creating new script
func die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends KinematicBody2D

class_name Entity


var hp: int = 100
export(int) var hp_max: int = 100
var queued_knockback:Vector2 = Vector2.ZERO

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
	
func take_knockback(var knockback:Vector2):
	queued_knockback += knockback
	



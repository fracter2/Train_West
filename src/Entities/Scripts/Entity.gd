extends KinematicBody2D

class_name Entity


var hp: int = 100
export(int) var hp_max: int = 100
var queued_knockback:Vector2 = Vector2.ZERO
var inside:bool = false

func _ready():
	hp = hp_max


# This function is intented to maybe be overriden when creating new script
func take_damage(dmg:int, node):
	hp -= dmg;
	if hp < 0:
		die()
	
	queued_knockback += Vector2(0, node.knockback).rotated(node.get_angle_to(position))

# This function is intented to maybe be overriden when creating new script
func die():
	queue_free()
	




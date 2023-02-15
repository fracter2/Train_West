extends Node2D

var chunk = preload("res://src/Items/Coal_Chunk.tscn")
export var throw_force:int = 100

func _input(event):
	if event.is_action_pressed("action_2"):
		var dir:Vector2 = get_global_mouse_position() - global_position
		dir = dir.normalized() * throw_force + get_parent().velocity * 0.35
		
		var c = chunk.instance()
		c.global_position = global_position
		c.linear_velocity = dir
		
		$"/root/World/Projectiles".add_child(c)
		queue_free()
		

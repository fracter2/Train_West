extends RigidBody2D


export(int, -100, 100) var target_dmg:int = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Despawn_Timer_timeout():
	queue_free()


func _on_Hitbox_body_entered(body):
	body.take_damage(target_dmg)
	queue_free()


func _on_Hitbox_area_entered(area):
	area.get_parent().take_damage(target_dmg)
	queue_free()

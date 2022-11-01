extends Area2D


func _ready():
	pass


func _on_Force_Override_body_entered(body):
	if body.is_in_group("Entity"):
		body.inside = true


func _on_Force_Override_body_exited(body):
	if body.is_in_group("Entity"):
		body.inside = false

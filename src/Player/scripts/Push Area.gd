extends Area2D

export var knockback:int = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Push_Area_body_entered(body):
	if body.is_in_group("Entity"):
		body.velocity.x += knockback
		

func get_entity_list():
	pass

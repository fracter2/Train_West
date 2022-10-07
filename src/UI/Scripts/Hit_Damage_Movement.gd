extends Position2D

var speed: int = 100
var text: String = "None"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = text
	
func _physics_process(delta):
	position.y += speed * delta


func _on_Despawn_Timer_timeout():
	queue_free()

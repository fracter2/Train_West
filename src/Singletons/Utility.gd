extends Node

onready var rng = RandomNumberGenerator.new()

	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_random_num(var from:float = 0, var to:float = 1) -> float:
	return rng.randf_range(from, to)

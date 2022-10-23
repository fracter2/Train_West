extends Position2D

export var spawn_on_enter:bool = false
var enemy_preload = preload("res://src/Entities/Enemy_Hugger.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn_on_enter:
		spawn()
	


func spawn():
	var enemy = enemy_preload.instance()
	enemy.position = global_position
	$"/root/World/Entities".add_child(enemy)
	print("attempt spawn")
	

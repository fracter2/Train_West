extends Position2D

export var spawn_on_enter:bool = false
export var entity_path:String = "res://src/Entities/Enemy_Runner.tscn" #"res://src/Entities/Enemy_Runner.tscn"
onready var entity_preload = load(entity_path)
#var enemy_preload = preload("res://src/Entities/Enemy_Runner.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn_on_enter:
		spawn()
	


func spawn():
	var entity = entity_preload.instance()
	entity.position = global_position
	$"/root/World/Entities".add_child(entity)
	

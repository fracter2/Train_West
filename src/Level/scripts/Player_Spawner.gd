extends Position2D

export var spawn_on_enter:bool = false
var player = preload("res://src/Player/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn_on_enter:
		spawn()
	
	$"/root/Player_manager".respawn_points.append(self)


func _exit_tree():
	var spawner_index:int = $"/root/Player_manager".respawn_points.find(self)
	if spawner_index != -1:
		$"/root/Player_manager".respawn_points.remove(spawner_index)


func spawn():
	var plr = player.instance()
	plr.position = global_position
	print("Player_spawner_used")
	$"/root/World".add_child(plr)
	

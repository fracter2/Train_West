extends Node

signal player_spawned
signal player_died

var respawn_points: Array = []
var players: Array = []

# Settings
var mouse_aim:bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_spawnpoint(var Node):
	pass


func spawn_player():
	if respawn_points.size() == 0:
		return
	respawn_points[0].spawn()

func player_disable(state:bool = true):
	if not get_node_or_null("/root/World/Players/Player") == null:
		$"/root/World/Players/Player".disabled = state
	else: print("player imasen")
	

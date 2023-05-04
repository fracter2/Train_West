extends Node

signal spawnWave
var active:bool = false

var progress_max:float = 20000
var progress_procent:float = 0

var spawn_amount:int = 0
onready var spawners = $Spawners.get_children()

func _ready():
	pass

func _physics_process(delta):
	progress_procent = (Train_manager.distance_traveled / progress_max) * 100


func spawn_wave():
	# calculate how many to spawn
	spawn_amount = 2 + floor(progress_procent)
	
	
	print("spawn Wave")
	print("spawned")

func spawn_wave_part():
	if spawn_amount <= 0: return
	var s:int = spawn_amount%4
	spawners[s].spawn()
	spawn_amount -= 1
	if spawn_amount <= 0: spawn_amount = 0

func _on_SpawnTimer_timeout():
	if active:
		spawn_wave()
	print("active")
	print(active)


func _on_Button_interacted(player):
	active = not active


func _on_SpawnTimer2_timeout():
	spawn_wave_part()

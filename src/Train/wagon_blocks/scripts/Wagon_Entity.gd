extends StaticBody2D

class_name Wagon_Entity

var hp:int = 100
export var hp_max: int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = hp_max


func take_damage(var dmg:int):
	hp -= dmg
	hp = clamp(hp, 0, hp_max)
	if hp == 0:
		pass
	

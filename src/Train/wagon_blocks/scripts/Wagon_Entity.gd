extends StaticBody2D

class_name Wagon_Entity

var hp:int = 100
export var hp_max: int = 100

enum STATES {ALIVE, DEAD}
var state: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = hp_max


func take_damage(var dmg:int):
	hp -= dmg
	hp = clamp(hp, 0, hp_max)
	
	if hp == 0:
		state = STATES.DEAD
		toggle_disabled(false)
	else:
		if state == STATES.DEAD:
			toggle_disabled(true)
		state = STATES.ALIVE
	

func toggle_disabled(var value:bool):
	get_node("CollisionBase").set_deferred("Disabled", value)
	get_node("PolygonBase").visible = not value
	print("atempt disable")
	

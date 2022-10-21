class_name Wagon_Entity
extends StaticBody2D


var hp:int = 100
export var hp_max: int = 100
export var revive_threshold:float = 0.4 #the relative hp to max, for it to be revived

signal repaired_fully

enum STATES {ALIVE, DEAD}
var state: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = hp_max


func take_damage(var dmg:int):
	hp -= dmg
	hp = clamp(hp, 0, hp_max)
	
	if hp <= 0:
		state = STATES.DEAD
		toggle_disabled(true)
	

func repair(var repair:int):
	hp = clamp(hp + repair, 0, hp_max)
	if hp > hp_max * revive_threshold and state == STATES.DEAD:
		toggle_disabled(false)
		state = STATES.ALIVE
	
	if hp == 100:
		emit_signal("repaired_fully")


func toggle_disabled(var value:bool):
	get_node("CollisionBase").set_deferred("disabled", value)
	get_node("PolygonBase").visible = not value
	

class_name Wagon_Entity
extends StaticBody2D


var hp:float = 100
export var hp_max: int = 100
export(float, 0, 1) var revive_threshold:float = 1 #the relative hp to max, for it to be revived

signal repaired_fully

enum STATES {ALIVE, DEAD}
var state: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = hp_max


func take_damage(dmg:int, node):
	hp -= dmg
	hp = clamp(hp, 0, hp_max)
	update_effects(0) 				# Normal damage instance
	
	if hp <= 0:
		state = STATES.DEAD
		toggle_disabled(true)
		update_effects(3)			# Death Instance
	

func repair(repair:int, node):
	hp = clamp(hp + repair, 0, hp_max)
	if hp >= hp_max * revive_threshold and state == STATES.DEAD:
		toggle_disabled(false)
		state = STATES.ALIVE
	
	if hp == hp_max: 				# In case of absolute max health reached, instance
		update_effects(2)
		emit_signal("repaired_fully")
	else:
		update_effects(1) 			# Normal repair instnace



func toggle_disabled(var value:bool):
	get_node("CollisionBase").set_deferred("disabled", value)
	get_node("PolygonBase").visible = not value
	

func update_effects(variable:int = 0):
	pass
	

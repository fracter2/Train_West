extends Facility

var opened:bool = false #setget set_opened

export var color_offset = 170
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second


func _ready(): set_opened(opened)

# Call this when you want to change it's opened state. A normal "opened = true" wont work
func set_opened(var state:bool):
	opened = state
	$PolygonBase.visible = not state
	$PolygonBase2.visible = state
	set_collision_layer_bit(7, not state)
	print("door just ->" + String(state))


func interact(var player):
	emit_signal("interacted", player)
	set_opened(not opened)
	print("door interaction")


# The fancy darkening + flash effect
func toggle_disabled(var value:bool): set_opened(true)

func update_effects(variable:int = 0):
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	$PolygonBase2.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	if variable == 0: # 0 -> If it was an attack
		$PolygonFlash.modulate.a = flash_ammount







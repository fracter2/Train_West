extends Wagon_Entity

var opened:bool = false setget set_opened

var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second


func set_opened(var state:bool):
	opened = state
	$PolygonBase.visible = not state
	$PolygonBase2.visible = state
	$CollisionBase.set_deferred("disabled", state) 


func toggle_disabled(var value:bool):
	opened = true


func update_effects(variable:int = 0):
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	
	if variable == 0: # If it was an attack
		$PolygonFlash.modulate.a = flash_ammount



extends Wagon_Entity

export var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second

export var spawn_area:Vector2 = Vector2(512, 112)



func update_effects(variable:int = 0):
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	
	if variable == 0: # If it was an attack
		$PolygonFlash.modulate.a = flash_ammount



# TODO make it so leak spots appear, in staed of repairing the whole thing
func spawn_leak():
	pass


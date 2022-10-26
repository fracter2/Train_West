extends Wagon_Entity


var color_offset = 50


func update_effects(variable:int = 0):
	var hp_fullness:float = (hp_max + color_offset) / (hp + color_offset)
	
	$AnimationPlayer.play("Damage_flash")
	
	modulate = Color(color_offset)
	

extends Wagon_Entity
class_name Wagon_Segment

export(bool) var left_corner_shadows:bool = false #setget set_left_corner
export(bool) var right_corner_shadows:bool = false #setget set_right_corner



var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second




func update_effects(variable:int = 0):
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	
	if variable == 0: # If it was an attack
		$PolygonFlash.modulate.a = flash_ammount


func on_ready_LC_check():
	if left_corner_shadows:
		set_left_corner(left_corner_shadows)

func on_ready_RC_check():
	if right_corner_shadows:
		set_right_corner(right_corner_shadows)


func set_left_corner(state:bool):
	var poly = $PolygonBase/LightOccluderBaseLeft.occluder.polygon
	if state and poly.size() <= 2:					# If it wants to enable it
		poly.append(poly[1] * Vector2(1, -1))		# Reverse the Y coordinate
	
	elif not state and poly.size() >= 3:
		poly.remove(2)								# Removes the last vertex
	
	$PolygonBase/LightOccluderBaseLeft.occluder.polygon = poly


func set_right_corner(state:bool):
	var poly = $PolygonBase/LightOccluderBaseRight.occluder.polygon
	if state and poly.size() <= 2:					# If it wants to enable it
		poly.append(poly[1] * Vector2(1, -1))		# Reverse the Y coordinate
	
	elif not state and poly.size() >= 3:
		poly.remove(2)								# Removes the last vertex
	
	$PolygonBase/LightOccluderBaseRight.occluder.polygon = poly

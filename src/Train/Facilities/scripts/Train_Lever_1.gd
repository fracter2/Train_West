extends Facility_Button

export(float, -10, 10) var rotation_active: float = -30
export(float, -10, 10) var rotation_inactive: float = 0


func _ready():
	toggle = true


func toggle_lever_pos(var _player):
	if pressed == true:
		$ButtonBase/Lever.rotation_degrees = rotation_active
	else:
		$ButtonBase/Lever.rotation_degrees = rotation_inactive
	
	Train_manager.engine_active = not Train_manager.engine_active
	print("engine state set to " + String(Train_manager.engine_active))



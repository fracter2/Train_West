extends Facility

export var heal_ammount:int = 25

export var mouse_input:bool = false


# Setup secondary interaction from playter on release / out of range
func interact(var player): # override
	emit_signal("interacted", player)
	player.heal()



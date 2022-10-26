extends Facility

export var toggle:bool = false
var pressed:bool = false

export var mouse_input:bool = false

signal button_just_pressed()
signal button_just_released()

# Setup secondary interaction from playter on release / out of range
func interact(var player): # override
	emit_signal("interacted", player)
	emit_signal("button_just_pressed")
	pressed = true
	print("Button pressed!")

func interact_end(var player):
	emit_signal("button_just_released")
	pressed = false
	print("Button released!")


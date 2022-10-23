extends Facility

export var toggle:bool = false
var pressed:bool = false

export var mouse_input:bool = false

signal button_just_pressed()
signal button_just_released()

# Setup secondary interaction from playter on release / out of range


func _on_Button_interacted(player):
	emit_signal("button_just_pressed")
	print("button pressed")

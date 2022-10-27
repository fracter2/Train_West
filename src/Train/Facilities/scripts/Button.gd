extends Facility

export var toggle:bool = false
var pressed:bool = false

#export var mouse_input:bool = false #Now Redundant
export(Color) var color_DEFAULT:Color = Color.lime
export(Color) var color_PRESSING:Color = Color.limegreen
export(Color) var color_TOGGLED:Color = Color.gold
export(Color) var color_DISABLED:Color = Color.crimson# This one might be redundant

onready var COLORS = {0:color_DEFAULT, 1:color_PRESSING, 2:color_TOGGLED, 3:color_DISABLED}

signal button_just_pressed()
signal button_just_released()

func _ready():
	$ButtonBase/ButtonRect.color = color_DEFAULT

# Setup secondary interaction from playter on release / out of range
func interact(var player): # override
	emit_signal("interacted", player)
	if not pressed:
		emit_signal("button_just_pressed")
		pressed = true
		$ButtonBase/ButtonRect.color = COLORS[1]
		print("Button just pressed!")
	
	#This happens if it was toggled on, already
	else: 
		emit_signal("button_just_released")
		pressed = false
		$ButtonBase/ButtonRect.color = COLORS[0]
		print("Button just released!")

func interact_end(var player):
	emit_signal("interacted_end")
	
	if not toggle:
		emit_signal("button_just_released")
		pressed = false
		$ButtonBase/ButtonRect.color = COLORS[0]
		print("Button just released!")
	
	# Toggled interaction
	elif pressed:
		$ButtonBase/ButtonRect.color = COLORS[2]
		print("Button just toggled!")



func _on_Button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print("button mouse event")
			#interact()
			#// Shit how do i pass on the player node?
			#// Guess this will have to be done from the player

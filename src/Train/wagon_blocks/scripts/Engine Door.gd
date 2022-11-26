extends Facility

export var opened := false
export var hatch1_open_pos:Vector2  = Vector2(0, 64)
export var hatch2_open_pos:Vector2  = Vector2(0, -64)
var hatch1_default_pos:Vector2
var hatch2_default_pos:Vector2

func _ready():
	hatch1_default_pos = $"Hach 1".position
	hatch2_default_pos = $"Hach 2".position
	update_doors()


func interact(var player):
	emit_signal("interacted", player)
	opened = not opened
	update_doors()

func update_doors():
	if opened
	$"Hach 1".position = hatch1_default_pos + hatch1_open_pos
	$"Hach 2".position = hatch2_default_pos + hatch2_open_pos
	else:
	$"Hach 1".position = hatch1_default_pos
	$"Hach 2".position = hatch2_default_pos 

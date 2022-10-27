#tool # Doesn't work
extends Polygon2D

export(Color) var c := Color.bisque setget set_color

#func _ready():
#	if not Engine.editor_hint:
#		queue_free()

func _process(delta):
	if Engine.editor_hint:
		#get_parent().get_node("ButtonBase/ButtonRect").color = get_parent().color_DEFAULT
		color = c


func set_color(new_c:Color):
	c = new_c

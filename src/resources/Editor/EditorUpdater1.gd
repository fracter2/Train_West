#tool # Disabled cause no work
extends Node

export(NodePath) var node
export(Color) var color = Color.cyan setget set_color


func _ready():
	if not Engine.editor_hint:
		queue_free()

# This thing is not working
func _process(delta):
	if Engine.editor_hint:
		if node == null: return
		node.color = color


func set_color(new_color):
	color = new_color

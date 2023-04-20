extends Facility

var coal = preload("res://src/Items/Coal_Chunk.tscn")

func interact(var player):
	emit_signal("interacted", player)

extends Facility

var chunk = preload("res://src/Items/Coal_Chunk_Inv.tscn")

func interact(player):
	emit_signal("interacted", player)
	
	if player.get_node_or_null("Coal_Chunk_Inv") == null:
		var c = chunk.instance()
		player.add_child(chunk.instance())

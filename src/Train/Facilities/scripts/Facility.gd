class_name Facility
extends Wagon_Entity

# Chance to erode, every second roughly, maybe
export(float, 0, 1) var erode_chance:float

signal interacted(player)
signal interacted_end(player)


func toggle_disabled(var value:bool):
	#get_node("CollisionBase").set_deferred("disabled", value)
	get_node("PolygonBase").visible = not value


func interact(var player):
	emit_signal("interacted", player)
	

func interact_end(var player):
	pass


func erode():
	pass

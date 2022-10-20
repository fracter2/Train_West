extends Area2D

signal player_interacted
var objects_in_range:int = 0

func _ready():
	pass

func interact_check():
	if objects_in_range == 0:
		return
	elif objects_in_range == 1:
		interact()
	else:
		pass # Code to calculate which is closest
		# interact(body_index)

func interact(var index:int = 0):
	var body = get_overlapping_bodies()[index] 
	if body.is_in_group("non-interactable") or body.is_in_group("broken"):
		return
	
	body.interact(get_parent()) # Send the parent body, just in case it wasnt to do something to the player
	emit_signal("player_interacted")

func _on_Interaction_Range_body_entered(body):
	objects_in_range += 1


func _on_Interaction_Range_body_exited(body):
	objects_in_range -= 1

extends Area2D

signal player_interacted
var objects_in_range:int = 0



func _physics_process(delta):
	if Input.is_action_just_pressed("Interact"):
		interact()
	# Move this to player script later maybe?


func interact():
	if objects_in_range == 0:
		return
	elif objects_in_range == 1:
		interact_target_index()
	else:
		pass # Code to calculate which is closest
		# interact(body_index)


func interact_target_index(var index:int = 0):
	var body = get_overlapping_bodies()[index] 
	if body.is_in_group("non-interactable") or body.is_in_group("broken"):
		return
	
	body.interact(get_parent()) # Send the player body, just in case it wasnt to do something to the player
	emit_signal("player_interacted")
	


func _on_Interaction_Range_body_entered(body):
	objects_in_range += 1


func _on_Interaction_Range_body_exited(body):
	objects_in_range -= 1

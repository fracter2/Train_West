extends Area2D

signal player_interacted
var objects_in_range:int = 0

var last_interacted_body



func _physics_process(delta):
	if Input.is_action_just_pressed("Interact"):
		interact()
	# Move this to player script later maybe?
	
	if Input.is_action_just_released("Interact"):
		interact_end()


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
	if body.is_in_group("non-interactable") or body.is_in_group("broken"): return
	
	body.interact(get_parent()) # Send the player body, just in case it wasnt to do something to the player
	emit_signal("player_interacted")
	
	last_interacted_body = body


func interact_end():
	if last_interacted_body == null: return
	last_interacted_body.interact_end(get_parent())
	
	last_interacted_body = null



func _on_Interaction_Range_body_entered(body):
	objects_in_range += 1

func _on_Interaction_Range_body_exited(body):
	objects_in_range -= 1
	if body == last_interacted_body:
		interact_end()

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
		
	else: # More than 1 # Code to calculate which is closest
		var bodies = get_overlapping_bodies()
		
		#var closest_body
		var closest_body_dist:float = -1
		var closest_body_index:int = 0
		for body in bodies:
			var dist = Vector2(global_position - body.global_position).length_squared() # It is squared because we dont want negative values
			
			# If it is closer...
			if closest_body_dist == -1 or dist < closest_body_dist : 
				closest_body_dist = dist
				closest_body_index = bodies.find(body)
			
		interact_target_index(closest_body_index)


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

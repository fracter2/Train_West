extends Area2D

signal player_interacted
var objects_in_range:int = 0

var last_interacted_body
var mouse_interact:bool = true

var highlight_frames_skip:int = 6
var frames_skipped:int = 0
var highlight_interacted_prev_body

func _physics_process(delta):
	if get_parent().aiming:
		#var mouse
		#$Target_Highlight.target_pos = get_global_mouse_position()
		#$Target_Highlight.target_size = 0.006 * (position - get_local_mouse_position()).length()	# Times accurasy later
		
		#$Target_Highlight.target_dimentions = Vector2(1,1)
		#$Target_Highlight.target_rot = -0.25
		
		#$Target_Highlight.spinning = false
		pass
	else:
		#$Target_Highlight.target_dimentions = Vector2(1, 1)
		#$Target_Highlight.spinning = true
		
		if Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("action_1"):
			if not get_parent().disabled:
				interact()
	
	if Input.is_action_just_released("Interact") or (Input.is_action_just_released("action_1")):
		interact_end()
	
	# Skip most of the frames, because this is an expensive operation
	#if frames_skipped <= highlight_frames_skip:
	#	frames_skipped += 1
	
	# On the frame where it updates the highlight
	#elif not get_parent().aiming:
		#var index:int = find_closest_object_index()
		#if index == null or index == -1: # if there is none in range 
			#$Target_Highlight.target_pos = get_global_mouse_position()
			#$Target_Highlight.target_size = 2
			#$Target_Highlight.target_rot = 0
			
		#else:
			#$Target_Highlight.visible = true
			#var body = get_overlapping_bodies()[index]
			#$Target_Highlight.target_pos = body.get_global_position() - body.highlight_offset
			#$Target_Highlight.target_size = body.highlight_size
		
		#if body == highlight_interacted_prev_body:
		#	pass
		#else:
		#	body.highlight_start()
		#	if not highlight_interacted_prev_body == null:
		#		highlight_interacted_prev_body.highlight_end()
		#	
		#	highlight_interacted_prev_body = body
		
		frames_skipped = 1

# Make selection of an object it's own method
func interact():
	var closest_obj_index = find_closest_object_index()
	if not closest_obj_index == -1:
		interact_target_index(closest_obj_index)


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


func find_closest_object_index() -> int:
	if objects_in_range == 0:
		return -1
	elif objects_in_range == 1:
		return 0
		
	else: # More than 1 # Code to calculate which is closest
		var bodies = get_overlapping_bodies()
		
		#var closest_body
		var closest_body_dist:float = -1
		var closest_body_index:int = 0
		for body in bodies:
			var pos:Vector2
			if mouse_interact: pos = get_global_mouse_position()
			else: pos = global_position
			var dist:float = Vector2(pos - body.global_position).length_squared() # It is squared because we dont want negative values
			
			# If it is closer...
			if closest_body_dist == -1 or dist < closest_body_dist : 
				closest_body_dist = dist
				closest_body_index = bodies.find(body)
		return closest_body_index


func _on_Interaction_Range_body_entered(body):
	objects_in_range += 1

func _on_Interaction_Range_body_exited(body):
	objects_in_range -= 1
	if body == last_interacted_body:
		interact_end()

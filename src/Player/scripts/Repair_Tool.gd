extends Node2D


export var repair_ammount:int = 20
export var repair_cooldown_frames:int = 5 # per 1 action frame
var cooldown_frame:int = 0

export var blowback_force:Vector2 = Vector2(100, 0)


func _physics_process(delta):
	
	# Aiming
	look_at(get_global_mouse_position())
	
	# Particle and effects
	if Input.is_action_just_pressed("action_2"):
		$Particles2D.emitting = true
		$Repair_Box.space_override = Area2D.SPACE_OVERRIDE_COMBINE
		
	elif Input.is_action_just_released("action_2"):
		$Particles2D.emitting = false
		$Repair_Box.space_override = Area2D.SPACE_OVERRIDE_DISABLED
	
	# Make sure the physics bodies dont sleep while we are blowing them
	if Input.is_action_pressed("action_2"):
		var bodies = $Repair_Box.get_overlapping_bodies()
		for i in bodies:
			if i is RigidBody2D:
				i.sleeping = false
		
		# rotate blowing force
		if global_rotation >= 1 and global_rotation <= 2:
			$Repair_Box.gravity_vec = -1 * blowback_force.rotated(global_rotation)
		else:
			$Repair_Box.gravity_vec = blowback_force.rotated(global_rotation)
	
	
	
	# Actual repair logic
	if cooldown_frame == repair_cooldown_frames: 
		if Input.is_action_pressed("action_2"):  
			cooldown_frame = 0
			var unsorted_targets = $Repair_Box.get_overlapping_areas()
			
			for i in unsorted_targets: # this can repair multiple areas, as it's now
				if not i.is_in_group("non-repirable"):
					i.get_parent().repair(repair_ammount)
	
	else:
		cooldown_frame += 1


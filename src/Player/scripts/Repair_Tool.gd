extends Item


export var repair_ammount:int = 20
export var repair_cooldown_frames:int = 5 # per 1 action frame
var cooldown_frame:int = 0

export var blowback_force:Vector2 = Vector2(100, 0)
export var recoil_force:Vector2 = Vector2(-100, 0)
export(float, 0, 2) var horizontal_recoil_modifyer:float = 1

export(int, 0, 1000) var resource_max := 100
var resource := 100
export(float, 0, 1000) var resource_recharge:float = 7


var default_particle_lifetime:float
func _ready(): default_particle_lifetime = $Particles2D.lifetime

var was_equiped:bool = false


func _physics_process(delta):
	
	# Aiming
	look_at(get_global_mouse_position())
	
	if get_parent().aiming and equiped:
		# Particle and effects
		if Input.is_action_just_pressed("action_1") or (not was_equiped and equiped and Input.is_action_pressed("action_1")):		# if it wasn't, but now IS equiped
			$Particles2D.emitting = true
			$Repair_Box.space_override = Area2D.SPACE_OVERRIDE_COMBINE
		
		
	if Input.is_action_just_released("action_1") or (was_equiped and not equiped):													# If it was, but now IS NOT equiped
		$Particles2D.emitting = false
		$Repair_Box.space_override = Area2D.SPACE_OVERRIDE_DISABLED
	
	was_equiped = equiped
	
	# Make sure the physics bodies dont sleep while we are blowing them
	if Input.is_action_pressed("action_1") and equiped:
		var bodies = $Repair_Box.get_overlapping_bodies()
		for i in bodies:
			if i is RigidBody2D:
				i.sleeping = false
		
		# Experimental
		#$Particles2D.lifetime = default_particle_lifetime * (1 +(2000 / get_parent().velocity.length_squared()))
		#$RayCast2D.
		
		
		# rotate blowing force, and apply
		if global_rotation >= 0.33*PI and global_rotation <= 0.66*PI:
			$Repair_Box.gravity_vec = -1 * blowback_force.rotated(global_rotation)
		else:
			$Repair_Box.gravity_vec = blowback_force.rotated(global_rotation)
	
	
	
	# Actual repair logic
	if cooldown_frame == repair_cooldown_frames: 
		if Input.is_action_pressed("action_1") and equiped:  
			cooldown_frame = 0
			var unsorted_targets = $Repair_Box.get_overlapping_areas()
			
			for i in unsorted_targets: 											# this can repair multiple areas, as it's now
				if not i.is_in_group("non-repirable"):
					i.get_parent().repair(repair_ammount, self)
			
			# Recoil
			var r = recoil_force.rotated(rotation)								# limit y recoil, we dont care about the recoil upwards, only down
			get_parent().velocity_recoil += Vector2(r.x * horizontal_recoil_modifyer, clamp(r.y, -100, 7))
	
	
	else:
		cooldown_frame += 1


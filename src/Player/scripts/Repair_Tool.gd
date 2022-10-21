extends Node2D


export var repair_ammount:int = 20
export var repair_cooldown_frames:int = 5 # per 1 action frame
var cooldown_frame:int

func _ready():
	cooldown_frame = 0



func _physics_process(delta):
	if Input.is_action_just_pressed("action_2"):
		$Particles2D.emitting = true
		
	elif Input.is_action_just_released("action_2"):
		$Particles2D.emitting = false
	
	if cooldown_frame == repair_cooldown_frames: 
		if Input.is_action_pressed("action_2"):  
			cooldown_frame = 0
			
			# Fire of a welding arc
			
			var unsorted_targets = $Repair_Box.get_overlapping_areas()
			
			for i in unsorted_targets: # this can repair multiple areas, as it's now
				if not i.is_in_group("non-repirable"):
					i.repair(repair_ammount)
	
	else:
		cooldown_frame += 1


extends Node2D

var back_vel_k:float = 40				# K is for koefficient

var background1 = preload("res://src/Level/Enviornment/Background1.tscn")
var background2 = preload("res://src/Level/Enviornment/Background2.tscn")

var backg_width = 20200			# Both th ebackgrounds are the same, so im just gona ignore the other
#var back2_width = 20200

var velocity:float = 0


	#for i in range(3):			# add backgrounds, 3 times

func _physics_process(delta):
	velocity = Train_manager.velocity * back_vel_k
	
	var bg1 = $"Background-1".get_child($"Background-1".get_child_count() -1)
	var bg2 = $"Background-2".get_child($"Background-1".get_child_count() -1)
	
	$"Background-1".get_child(0).position.x += -velocity *delta		# Negative vel, since left x is negative x
	$"Background-1".get_child(1).position.x += -velocity *delta
	$"Background-2".get_child(0).position.x += -velocity *delta
	$"Background-2".get_child(1).position.x += -velocity *delta
	#bg2.position.x += -velocity *delta								# and velocity is not a vector...
																	# shit, it should be called speed instead.
	
	if bg1.position.x < backg_width * -1 :	# if its middle is psat the worlds middle
		var bg1_instance = background1.instance()
		bg1_instance.position.x = bg1.position.x + backg_width * 2
		
		var bg2_instance = background2.instance()
		bg2_instance.position.x = bg2.position.x + backg_width * 2
		
		
		$"Background-1".add_child(bg1_instance)
		$"Background-2".add_child(bg2_instance)
		
		bg1.queue_free()
		bg2.queue_free()
		print("Background Updated")

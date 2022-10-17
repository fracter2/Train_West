extends Node2D

export(Vector2) var force:Vector2 = Vector2(-5000, 0)
export(Vector2) var knockback:Vector2 = Vector2(100, 0)
export var rechamber_time:float = 0.2


var projectile = preload("res://src/Player/Projectile1.tscn")

enum STATES {READY, RECHAMBERING, RELOADING, DISABLED}
var state:int = STATES.READY


#func _ready():
#	$Rechamber_Timer.set



func _physics_process(delta):
	if Input.is_action_pressed("action_1") and state == STATES.READY:
		fire()


func fire():
	var proj = projectile.instance()
	
	proj.global_position = $"Firing Point".global_position
	proj.rotation = global_position.angle_to_point(get_global_mouse_position())
	print(global_position.angle_to_point(get_global_mouse_position()))
	proj.apply_central_impulse(force.rotated(proj.rotation))
	$"/root/World".add_child(proj)
	#proj.look_at(get_global_mouse_position())
	
	state = STATES.RECHAMBERING
	$Rechamber_Timer.start(rechamber_time)
	

func _on_Rechamber_Timer_timeout():
	if state == STATES.RECHAMBERING:
		state = STATES.READY

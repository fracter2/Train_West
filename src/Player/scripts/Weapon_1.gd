extends Node2D

export(Vector2) var force:Vector2 = Vector2(3000, 0)		# Firing force
export(Vector2) var recoil:Vector2 = Vector2(100, 0)		# Player recoil
export(float, 0, 1000) var knockback = 100					# Target knockback

export var refire_time:float  = 0.35
export var rechamber_time:float = 0.35
export var reload_time:float = 3.25
export var proj_dmg:int = 25

var projectile = preload("res://src/Player/Projectile1.tscn")
var shell = preload("res://src/Player/Shell1.tscn")

enum STATES {READY, RECHAMBERING, RELOADING, RELOAD_PARTIAL, DISABLED}
var state:int = STATES.READY setget set_state
var equiped = false

var default_poffset: Vector3 = Vector3.ZERO
var cur_poffset: Vector3 = Vector3.ZERO
var rcbr_poffset: Vector3 = Vector3 (-1, 0.5, 0)
var rld_poffset:Vector3 = Vector3 (0, 3, -0.35)
#var rld_time:float = 3.25
#var rld_time_partial:float = 0.35
# The Z axis is used for rotation, in degrees

onready var firing_particles = $"%Particles1".duplicate(7)


func _ready(): default_poffset = Vector3(position.x, position.y, rotation)


func _physics_process(delta):
	if get_parent().aiming and equiped:
		if Input.is_action_pressed("action_1") and state == STATES.READY:
			fire()
	

func set_state(new_state: int):		# I will work on this whole thing later
	if new_state == STATES.READY:
		cur_poffset = default_poffset


func fire():
	$"Firing Point".look_at(get_global_mouse_position())
	var proj = projectile.instance()
	
	# Projectile logic
	proj.target_dmg = proj_dmg
	proj.knockback = knockback
	proj.global_position = $"Firing Point".global_position
	proj.rotation = proj.global_position.angle_to_point(get_global_mouse_position())
	proj.apply_central_impulse(force.rotated(proj.rotation))
	$"/root/World/Projectiles".add_child(proj)
	
	# Rechamber
	state = STATES.RECHAMBERING
	$Rechamber_Timer.start(refire_time)
	
	# Recoil, and other feel-good things
	var r: Vector2 = recoil.rotated(proj.rotation)
	get_parent().velocity_recoil += Vector2(r.x, clamp(r.y, -20, 20))			# Limit y velocity to something that seems about right
	
	fire_particles()
	
	# Shell casing thing
	var shll = shell.instance()
	shll.global_position = $"Firing Point".global_position
	$"/root/World/Projectiles".add_child(shll)
	
	


func fire_particles(): # Logic to make sure no particle effect gets cut off. 3 should be enough
	var new_partcle = firing_particles.duplicate(7)
	new_partcle.emitting = true
	$"%Firing Point".add_child(new_partcle)


func _on_Rechamber_Timer_timeout():
	if state == STATES.RECHAMBERING:
		state = STATES.READY

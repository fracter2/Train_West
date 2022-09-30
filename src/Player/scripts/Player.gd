extends KinematicBody2D

# Movement variables
export (int) var walk_speed = 600
export (int) var run_speed = 1000
export (int) var jump_speed = -1800
export (int) var gravity = 4000

var velocity = Vector2.ZERO

export (float, 0, 1.0) var friction:float = 0.1
export (float, 0, 1.0) var acceleration:float = 0.25


# Health and state
signal health_changed
signal max_health_changed
signal died

export var max_health:int = 100
var health:float
var invincible: bool = false

# When the character dies, we fade the UI
enum STATES {ALIVE, DEAD}
var state = STATES.ALIVE


func _ready():
	health = max_health
	emit_signal("max_health_changed", max_health)
	emit_signal("health_changed", health)

func _physics_process(delta):
	# Movement code
	get_input()
	velocity.y += gravity * delta
	velocity = .move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("move_up"):
		if .is_on_floor():
			velocity.y = jump_speed


func take_damage(count):
	if state == STATES.DEAD:
		return
	if invincible:
		return
	
	health -= count
	invincible = true
	$InvincibilityTimer.start()
	emit_signal("health_changed", health)
	print ("Player damaged" + String(health))
	
	if health <= 0:
		health = 0
		state = STATES.DEAD
		emit_signal("died")
		die()


func get_input():
	var dir = 0
	dir = Input.get_axis("move_left", "move_right")
	if dir != 0:
		var speed:int
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		
	else:
		velocity.x = lerp(velocity.x, 0, friction)



# Unsure what this will be used for, but it excists for now, remove later if redundant
func die():
	# this craches it for now
	#var dead_msg = preload("res://src/Player/Dead_Message.tscn")
	#add_child(dead_msg) 
	state = STATES.DEAD
	print("player dead")


func _on_InvincibilityTimer_timeout():
	invincible = false

extends KinematicBody2D

# Movement variables
export (int) var walk_speed = 600
export (int) var run_speed = 1000
export (int) var jump_speed = -1800
export (int) var gravity = 4000

var velocity = Vector2.ZERO
var frame_jump:int = 0
var velocity_queued: int = 0

export (float, 0, 1.0) var friction:float = 0.1
export (float, 0, 1.0) var acceleration:float = 0.25

# Player Parameters
var input_dir: Vector3 = Vector3(0,0,0)


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


# Movement
func _physics_process(delta):
	# Movement code
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir.y = Input.get_axis("move_down","move_up")
	input_dir.z = Input.get_action_strength("move_jump")
	horizontal_movement()
	
	velocity.y += gravity * delta - input_dir.y * 75
	if velocity.y > -3:
		#velocity.y += 20 - input_dir.y * 50
		pass
	else:
		velocity.y -= input_dir.z * 20
		pass
	
	if Input.is_action_just_released("move_jump") and not frame_jump == 20 and not velocity.y > 0:
		frame_jump = 20
		velocity.y = 0
	
	#if Input.is_action_just_pressed("move_jump"):
	#	if .is_on_floor():
	#		velocity.y = jump_speed
	#		velocity.x -= jump_speed * input_dir.x  # this makes it lunge forward a bit
	
	if Input.is_action_pressed("move_jump"):
		if frame_jump < 4:
			velocity.y = jump_speed * 0.5
			velocity.x -= -60 * input_dir.x
			frame_jump += 1
	
	if .is_on_floor():
		frame_jump = 0
	
	velocity = .move_and_slide(velocity, Vector2.UP)


func horizontal_movement(): # This actually sets the horizontal speed
	if input_dir.x != 0:
		var speed:int
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed
		velocity.x = lerp(velocity.x, input_dir.x * speed, acceleration)
		
	else:
		velocity.x = lerp(velocity.x, 0, friction)




# Health
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



func die(): # Unsure what this will be used for, but it excists for now, remove later if redundant
	# this craches it for now
	#var dead_msg = preload("res://src/Player/Dead_Message.tscn")
	#add_child(dead_msg) 
	state = STATES.DEAD
	print("player dead")


func _on_InvincibilityTimer_timeout():
	invincible = false

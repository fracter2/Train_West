extends KinematicBody2D

# Movement variables
export (int) var walk_speed := 600
export (int) var run_speed := 1000
export (int) var jump_speed := -1800
export (int) var gravity := 4000
export(float, 0, 20) var fake_train_vel_k := 1

var velocity := Vector2.ZERO
var frame_jump := 0
var velocity_queued := Vector2.ZERO 		# Knockback
var velocity_recoil := Vector2.ZERO			# Recoil

export (float, 0, 1.0) var friction := 0.1
export (float, 0, 1.0) var acceleration := 0.25

# Player Parameters
var input_dir := Vector3(0,0,0)


# Health and state
signal health_changed
signal max_health_changed
signal died

export var max_health:int = 100
var health:float
var invincible: bool = false

var Hit_Damage_Indicator = preload("res://src/UI/Hit_Damage.tscn")

# When the character dies, we fade the UI
enum STATES {ALIVE, DEAD, DISABLED}
var state = STATES.ALIVE
var alive: bool = true
var disabled: bool = false

var aiming := false
var inside := false

var equiped_slot:int = 0



func _ready():
	health = max_health
	emit_signal("max_health_changed", max_health)
	emit_signal("health_changed", health)


# Movement
func _physics_process(delta):
	# Movement code
	if alive:
		movement(delta)
		if not disabled:
			input_dir.x = Input.get_axis("move_left", "move_right")
			input_dir.y = Input.get_axis("move_down","move_up")
			input_dir.z = Input.get_action_strength("move_jump")
	


func movement(delta:float):			# Non-controlls
	velocity.y += gravity * delta - input_dir.y * 75			# Gravity
	if not velocity.y > -30:									# If gaining height at around > -3 speed, increase lift, from jump
		velocity.y -= input_dir.z * 16							# 20 is a bit arbituary, just felt right
	
	
	# Various Input reactions
	vertical_movement()
	horizontal_movement()
	
	
	# Fake train velocity
	if not inside:
		velocity.x -= Train_manager.velocity * fake_train_vel_k
	
	# Queued velocity, AKA KNOCKBACK & RECOIL
	velocity += velocity_queued						# Knockback
	velocity_queued *= Vector2(0.75, 0.35)			# Custom drag, so it lasts for more than a frame
	
	# Recoil portion
	var r := velocity_recoil
	if velocity.y < -300: r.y = clamp(velocity_recoil.y, -60, 100)
	else: r.y = clamp(velocity_recoil.y, -30, 100)
	
	velocity += Vector2(r.x, r.y)					# Limit recoil up, we dont care about down (positive direction)
	velocity_recoil *= Vector2(0.75, 0.35)



func vertical_movement():			# Up_down controlls
	if Input.is_action_just_released("move_down") and not velocity.y > 0:
		frame_jump = 20
		velocity.y = 0
	
	if Input.is_action_just_released("move_jump"):
		frame_jump = 20 							# 20 is an arbituary large number. It just signifies that the "jump" part has ended
	
	if Input.is_action_pressed("move_jump"):
		if frame_jump < 3:
			velocity.y = jump_speed * 0.5 			# times 0.5 to make the inputed jump_speed not stray too much, since it gets applied thru 3 frames. might be redundant
			velocity.x -= -60 * input_dir.x 		# Boosts the player in the inputed direction, left or right, when jumping. -60 is the strength
			frame_jump += 1
	
	if .is_on_floor(): # Reset jump
		frame_jump = 0


func horizontal_movement(): 		# Left-Right controlls
	if input_dir.x != 0:
		var speed:int
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed
		velocity.x = lerp(velocity.x, input_dir.x * speed, acceleration)
		
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		


# Movement and collision is executed here, every frame, not every physics frame
func _process(delta):
	if alive:
		velocity = .move_and_slide(velocity, Vector2.UP)




# Health
func take_damage(count):
	if not alive or invincible:
		return
	
	health -= count
	invincible = true
	$InvincibilityTimer.start()
	emit_signal("health_changed", health)
	
	# To add hit-dmg indicators
	spawn_indicator(count)
	
	if health <= 0:
		health = 0
		die()


func heal(count):
	health += count
	emit_signal("health_changed", health)



func spawn_indicator(count):
	var dmg_indicator_instance = Hit_Damage_Indicator.instance()
	dmg_indicator_instance.text = String(count)
	#dmg_indicator_instance.global_position = $Tittle.global_position  			# Use this for when global positions will be used
	dmg_indicator_instance.position = $Tittle.global_position
	$"/root/World".add_child(dmg_indicator_instance)



func die(): 
	alive = false
	emit_signal("died")
	print("player dead")
	queue_free()
	$"/root/Player_manager".spawn_player()


func revive():
	alive = true
	print("player revived")


func _on_InvincibilityTimer_timeout():
	invincible = false




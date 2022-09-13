extends Entity

export (int) var walk_speed = 600
export (int) var run_speed = 1000
export (int) var jump_speed = -1800
export (int) var gravity = 4000

var velocity = Vector2.ZERO

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

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

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = .move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("move_up"):
		if .is_on_floor():
			velocity.y = jump_speed

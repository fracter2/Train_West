extends Entity


export (int) var run_speed = 1000
export (float, 0,1) var drag:float = 0.94
export (int) var gravity = 3500
var velocity = Vector2.ZERO
var player = null



export(int) var attack_dmg := 20
export var attack_knockback:Vector2 = Vector2(300, 100)

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null


# Movement, and misc
func _physics_process(delta):
	
	
	#var target_dir: Vector2 = Vector2(clamp(player.position.x, -1, 1), clamp(player.position.y, -1, 1))
	
	if player != null:
		var tpos:Vector2 = position.direction_to(player.position)
		if tpos.x < 0: tpos.x = -1
		else: tpos.x = 1
		velocity.x += tpos.x * run_speed * delta * 3		# The 3 is a magic variable
		get_target()
		
	velocity.y += gravity * delta
	
	if queued_knockback.y < 0: queued_knockback.y *= -1
	velocity += queued_knockback
	queued_knockback = Vector2.ZERO
	
	velocity *= drag
	# velocity = move_and_slide(velocity, Vector2.UP)
	
	queued_knockback = Vector2.ZERO
	
	attackBoxUpdate()


func _process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	

# Updates the "Player" position, for chasing it
func get_target():
	var overlapping_bodies: Array= $VisionBox.get_overlapping_bodies()
	if overlapping_bodies.size() == 0:
		return
	for i in overlapping_bodies:
		if i.is_in_group("Player"):
			player = i
			return

# This is the current solution for damaging the opponent
func attackBoxUpdate():
	var targets: Array = $AttackBox.get_overlapping_bodies()
	if targets.size() == 0: 
		return # Skips the rest of this function
	for i in targets:
		i.take_damage(attack_dmg)
	
	
	
	
	

extends Entity


export (int) var run_speed = 1000
export (int) var gravity = 3500
var velocity = Vector2.ZERO
var player = null

export(int) var attack_dmg := 20

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null


# Movement, and misc
func _physics_process(delta):
	#velocity.x = 0
	if player != null:
		velocity.x += position.direction_to(player.position).x * run_speed * delta * 3
		get_target()
	velocity.y += gravity * delta
	velocity *= 0.94
	# velocity = move_and_slide(velocity, Vector2.UP)
	
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
	
	
	
	
	

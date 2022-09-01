extends KinematicBody2D


export (int) var run_speed = 1000
export (int) var gravity = 3500
var velocity = Vector2.ZERO
var player = null

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null

func _physics_process(delta):
	var overlapping_bodies: Array= $Area2D.get_overlapping_bodies()
	for i in overlapping_bodies:
		if i.is_in_group("Player"):
			player = i
	velocity.y += gravity * delta
	
	velocity = Vector2.ZERO
	if player != null:
		velocity = position.direction_to(player.position) * run_speed
	velocity = move_and_slide(velocity, Vector2.UP)
	
	

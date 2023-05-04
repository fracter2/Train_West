extends Entity

export (int) var run_speed = 1000
#export (int) var gravity = 3500
var velocity = Vector2.ZERO
var player = null

var state = 0
var old_state = 0
var targetPos:Vector2

export(int) var attack_dmg := 15
export(int) var attack_Wagon := 35

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null


# Movement, and misc
func _physics_process(delta):
	# Knockback
	#if queued_knockback.y > 0:  queued_knockback *= -1
	velocity += queued_knockback 
	queued_knockback *= 0.3
	# Rest of movement
	if old_state == state:
		targetPos = position + Vector2(1000,-1000)
		old_state == state
	if state == 0:
		var tops:Vector2
		if player != null: tops = position.direction_to(player.position - Vector2(0,-50))
		else: tops = position.direction_to(Vector2(0, -2500))
		
		if tops.x < 0: tops.x = -1
		else: tops.x = 1
		if tops.y < 0: tops.y = -1
		else: tops.y = 1
		velocity.x += tops.x * run_speed * delta * 3
		velocity.y += tops.y * run_speed * delta * 3
		get_target()
		
			
	if state == 1:
		var targetPosangel:Vector2 = position.direction_to(targetPos)
		if targetPosangel.x < 0: targetPosangel.x = -1
		else: targetPosangel.x = 1
		if targetPosangel.y < 0: targetPosangel.y = -1
		else: targetPosangel.y = 1
		velocity.x += targetPosangel.x * run_speed * delta * 3
		velocity.y += targetPosangel.y * run_speed * delta * 3
	velocity *= 0.94
	attackBoxUpdate(delta)


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
func attackBoxUpdate(delta):
	var targets: Array = $AttackBox.get_overlapping_bodies()
	if targets.size() == 0: 
		return # Skips the rest of this function
	for i in targets:
		i.take_damage(attack_dmg)
	if state == 0:
		state = 1
		$Timer.start()


func _on_Timer_timeout():
	state = 0
	old_state = state


# This is for destorying walls
func attack(var body):
	if body.is_in_group("non-targetable"):
		return
	if body.is_in_group("Player"):
		return
	body.take_damage(attack_Wagon, self)
	state = 1
	$Timer.start(3)


#The area for destorying walls
func _on_DestroyBox_body_entered(body):
	attack(body)

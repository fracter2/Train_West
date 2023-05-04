extends Entity


export (int) var run_speed = 1000
export (float, 0,1) var drag:float = 0.94
export (int) var gravity = 3500
var velocity = Vector2.ZERO
var player = null

var attack_disabled:bool = false
var attack_on_enabled:bool = true

export(int) var attack_dmg := 20
export(int) var attack_dmg_wagon := 40
#export var knockback:Vector2 = Vector2(300, 100)
export var knockback:float = 300
export var recoil: float = 400

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null


# Movement, and misc
func _physics_process(delta):
	
	
	#var target_dir: Vector2 = Vector2(clamp(player.position.x, -1, 1), clamp(player.position.y, -1, 1))
	var tpos:Vector2
	
	if player != null:
		tpos = position.direction_to(player.position)
		if tpos.x < 0: tpos.x = -1
		else: tpos.x = 1
		velocity.x += tpos.x * run_speed * delta * 3		# The 3 is a magic number
		get_target()
	else: 
		tpos = position.direction_to(Vector2(0, -1000))
		if tpos.x < 0: tpos.x = -1
		else: tpos.x = 1
		velocity.x += tpos.x * run_speed * delta * 3		# The 3 is a magic number
		
	velocity.y += gravity * delta
	if tpos.y < 0 and is_on_floor():
		velocity.x *= 1.4
		velocity.y += -1000
	
	if queued_knockback.y > 0: queued_knockback.y *= -1
	velocity += queued_knockback * 2
	queued_knockback *= 0.5
	
	velocity *= drag
	# velocity = move_and_slide(velocity, Vector2.UP)
	
	#queued_knockback = Vector2.ZERO
	
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
		
		var attack_angle:Vector2 = position.direction_to(i.position)
		if attack_angle.x > 0: velocity.x -= recoil
		else: velocity.x += recoil
		velocity.y += -recoil 
	
	

func attack(var body):
	if body.is_in_group("non-targetable"): return
	if body.is_in_group("Player"): return
	
	var attack_angle:Vector2 = position.direction_to(body.position)
	#if abs(attack_angle.y) < abs(attack_angle.x): # Horizontal attack
	body.take_damage(attack_dmg_wagon, self)
	velocity.x += -recoil * attack_angle.x
	velocity.y += -recoil *0.4 * attack_angle.y
	#else:	# Vertical attack 
	#	body.take_damage(attack_dmg_wagon * 0.2, self)
	
	attack_disabled = true
	$Timer.start()


#The area for destorying walls
func _on_Destroy_Box_body_entered(body):
	if not attack_disabled: attack(body)
	else: attack_on_enabled = true
	


func _on_Timer_timeout():
	attack_disabled = false
	attack_on_enabled = false
	
	if $Destroy_Box.get_overlapping_bodies().size() != 0:
		attack($Destroy_Box.get_overlapping_bodies()[0])


func _on_Destroy_Box_Top_body_entered(body):
	body.take_damage(attack_dmg_wagon * 0.1
	, self)
	
	attack_disabled = true
	$Timer.start()

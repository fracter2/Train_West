extends RigidBody2D


#export(int, -100, 100) var target_dmg:int = 10				# Removed from export because its unnessessary; the weapon applies new dmg value
var target_dmg:int = 10
var knockback:int = 10

onready var current_pos:Vector2 = global_position
onready var previous_pos:Vector2 = global_position

#func _ready(): $"%Firing_Particles".emitting = true

func _physics_process(delta): 
	previous_pos = current_pos
	current_pos = global_position

func _process(delta):
	var f = Engine.get_physics_interpolation_fraction()
	$Visuals.global_position = previous_pos.linear_interpolate(global_position, f)
	


# player_body.global_transform.origin = last_physics_pos.linear_interpolate(global_transform.origin, fraction)

func attack(var body):
	if body.is_in_group("non-targetable"):
		return
	body.take_damage(target_dmg, self)
	queue_free()


func _on_Despawn_Timer_timeout():queue_free()

func _on_Hitbox_body_entered(body): attack(body)

func _on_Hitbox_area_entered(area): attack(area.get_parent())

# On standard physics collision
func _on_Projectile_body_entered(body): queue_free()

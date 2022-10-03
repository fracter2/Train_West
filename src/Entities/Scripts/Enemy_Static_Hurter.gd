extends Entity

var damage: int = 10
var attacking: bool = false
var attackers: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if attacking:
		var target = get_targets()
		target[0].take_damage(damage)


func get_targets() -> Array:
	var targets: Array 
	var area_input = $AttackBox.get_overlapping_bodies()
	
	for i in area_input:
		if i.is_in_group("Player"):
			targets.append(i)
	
	return targets


func _on_AttackBox_body_entered(body):
	attacking = true
	attackers += 1



func _on_AttackBox_body_exited(body):
	attackers -= 1
	if attackers == 0:
		attacking = false

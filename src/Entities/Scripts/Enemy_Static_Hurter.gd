extends Entity

var damage: int = 10
var attacking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if atacking:
		var target = get_targets()
		

func get_targets() -> Array:
	var targets: Array 
	var area_input = $AttackBox.get_overlapping_bodies()
	for i in area_input:
		if i.is_in_group("Player"):
			targets.append(i)
	
	return targets


func _on_AttackBox_body_entered(body):
	pass # Replace with function body.


func _on_AttackBox_body_exited(body):
	pass # Replace with function body.

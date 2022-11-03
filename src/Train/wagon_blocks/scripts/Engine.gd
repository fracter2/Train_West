extends Wagon_Entity

export var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second

export var spawn_area:Vector2 = Vector2(512, 112)

onready var smoke_emitter = $PolygonBase/Particles2D
onready var smoke_default_material = $PolygonBase/Particles2D.process_material
onready var smoke_default_gravity = $PolygonBase/Particles2D.process_material.gravity

#func _ready():
#	$PolygonBase/Particles2D.process_material.gravity.x


func _physics_process(delta):
	var new:Vector3 = smoke_default_gravity
	new.x = Train_manager.velocity * -3
	smoke_emitter.process_material.set_deferred("gravity", new)

func update_effects(variable:int = 0):
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	
	if variable == 0: # If it was an attack
		$PolygonBase/PolygonFlash.modulate.a = flash_ammount



# TODO make it so leak spots appear, in staed of repairing the whole thing
func spawn_leak():
	pass


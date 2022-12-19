extends Facility

export var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second

export var spawn_area:Vector2 = Vector2(512, 112)

onready var smoke_emitter = $PolygonBase/Particles2D
onready var smoke_default_material = $PolygonBase/Particles2D.process_material
onready var smoke_default_gravity = $PolygonBase/Particles2D.process_material.gravity
onready var heat_radiance = $HeatRadiance
export var heat_radiance_min:float = 0.3
export var heat_radiance_max:float = 1
onready var heat_max = Train_manager.engine_heat_max
var sup:int = 0																# Simple update timer, for expensive operations
var supm:int = 2
#func _ready():
#	$PolygonBase/Particles2D.process_material.gravity.x


func _physics_process(delta):
	# Smoke particles effect
	var new:Vector3 = smoke_default_gravity
	new.x = Train_manager.velocity * -3
	smoke_emitter.process_material.set_deferred("gravity", new)
	if sup >= supm:		# Simple frame_based timer, since this seems a little expensive
		heat_radiance.energy = lerp(heat_radiance_min, heat_radiance_max, Train_manager.engine_heat / heat_max)
		sup = 0
	else:
		sup += 1


func update_effects(variable:int = 0):
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	if variable == 0: # If it was an attack
		$PolygonBase/PolygonFlash.modulate.a = flash_ammount



# TODO make it so leak spots appear, in staed of repairing the whole thing
func spawn_leak():
	pass


extends Facility

export var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second

export var spawn_area:Vector2 = Vector2(512, 112)

onready var smoke_emitter = $PolygonBase/Particles_Smoke
onready var smoke_default_material = $PolygonBase/Particles_Smoke.process_material
onready var smoke_default_gravity = $PolygonBase/Particles_Smoke.process_material.gravity
onready var heat_radiance = $HeatRadiance
export var heat_radiance_min:float = 0.3
export var heat_radiance_max:float = 1
onready var heat_max = Train_manager.engine_heat_max
var sup:int = 0																# Simple update timer, for expensive operations
var supm:int = 2
#func _ready():
#	$PolygonBase/Particles_Smoke.process_material.gravity.x


func _physics_process(delta):
	
	if sup >= supm:																# Simple frame_based timer, since this seems a little expensive
		var engine_heat_koefficient = Train_manager.engine_heat / heat_max
		heat_radiance.energy = lerp(heat_radiance_min, heat_radiance_max, engine_heat_koefficient)
		
		update_smoke(engine_heat_koefficient)
		
		
		sup = 0
	else:
		sup += 1

func update_smoke(var heat_k):
	var new:Vector3 = smoke_default_gravity										# Force on the smoke
	new.x = Train_manager.velocity * -3
	smoke_emitter.process_material.set_deferred("gravity", new)

func update_fire(var heat_k):
	pass
	# set efects that increase/decrease with heat. Like lifetime, and ammount
	# 0-0.25   is   8 - 16, 1.3
	# 0.25-0-5 is  16 - 32, 1.6
	# 0.5-0.75 is  32 - 64, 1.9
	# 0.75-1   is  64 - 128, 2.2


func update_effects(variable:int = 0):											# this is just for hp. Might be redundant
	var hp_fullness:float = (hp + color_offset) / (hp_max + color_offset) 
	$PolygonBase.modulate = Color(hp_fullness, hp_fullness, hp_fullness)
	
	if variable == 0: # If it was an attack
		$PolygonBase/PolygonFlash.modulate.a = flash_ammount


func hatch_close():
	$Particles_Fire.emitting = false

func hatch_open():
	$Particles_Fire.emitting = true


# TODO make it so leak spots appear, in staed of repairing the whole thing
func spawn_leak():
	pass



func _on_Coal_Intake_body_entered(body):
	if body.fuel != 0:
		Train_manager.engine_fuel += 30
		body.consume()

extends Facility

export var color_offset = 30
export(float, 0, 1) var flash_ammount:float = 0.4 # (flash range: 0 - 1 )
export(float, 0, 10) var flash_recovery_rate:float = 4 # how much it recovers per second

export var spawn_area:Vector2 = Vector2(512, 112)

onready var smoke_emitter = $PolygonBase/Smoke_Emitter
onready var smoke_default_material = $PolygonBase/Smoke_Emitter.process_material
onready var smoke_default_gravity = $PolygonBase/Smoke_Emitter.process_material.gravity
export(float, -10,0) var smoke_velocity_ko:float = -3
onready var fire_emitter = $Fire_Emitter
export var fire_emit_min:float = 8
export var fire_emit_max:int = 64
export var fire_time_min:float = 0.5
export var fire_time_max:float = 2.2
onready var heat_radiance = $HeatRadiance
export var heat_radiance_min:float = 0.3
export var heat_radiance_max:float = 1
#func _ready():
#	$PolygonBase/Particles_Smoke.process_material.gravity.x


func _ready():
	pass
	$"/root/Train_manager".connect("heat_updated", self, "set_heat")
	$"/root/Train_manager".connect("velocity_updated", self, "set_smoke")


func set_heat(val:float):
	heat_radiance.energy = lerp(heat_radiance_min, heat_radiance_max, val)
	#fire_emitter.amount = lerp(fire_emit_min, fire_emit_max, val)
	fire_emitter.lifetime = lerp(fire_time_min, fire_time_max, val)
	
	


func set_smoke(val:float):
	# Smoke particles effect
	var new:Vector3 = smoke_default_gravity
	new.x = val * smoke_velocity_ko
	smoke_emitter.process_material.set_deferred("gravity", new)
	


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

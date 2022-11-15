extends Node


signal velocity_updated

var hull_integrity = 1000
var hull_integrity_max = 1000

# Movement
var velocity: float = 0
var velocity_drag:float = 0.2 				# Currently does nothing
var velocity_static_drag:float = -0.15
var velocity_accelleration:float = 2


# Wagons
var wagons:Array = []

var resource_water := 1000
var resource_water_max := 2000
var resource_fuel:= 1000
var resource_fuel_max := 2000

# Engine
var engine_heat := 20
var engine_heat_max := 100
var engine_fuel := 50
var engine_fuel_max := 200
var engine_active := false


func apply_train_impulse(var impulse:float):
	velocity += impulse
	emit_signal("velocity_updated", velocity)



func _physics_process(delta):
	if engine_active:
		velocity += velocity_accelleration * delta * 4			# Remove the * 4 later, was for a quick debug
	
	velocity *= (1 - velocity_drag * delta) 
	
	emit_signal("velocity_updated", velocity)




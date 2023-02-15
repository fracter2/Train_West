extends Node


signal velocity_updated
signal heat_updated
signal fuel_updated

var hull_integrity = 1000
var hull_integrity_max = 1000

# Movement
var velocity: float = 0
var velocity_drag_scalable:float = 0.2
var velocity_drag_static:float = 3
var velocity_accelleration:float = 2											# Currently does nothing


# Wagons
var wagons:Array = []

var resource_water := 1000
var resource_water_max := 2000
var resource_fuel:= 1000
var resource_fuel_max := 2000

# Engine
var engine_heat: float = 200													# Heat goes from 0 to 200
var engine_heat_max := 200
var engine_heat_loss_scalable := 1									# Multiplied by ( heat/heat_max )
var engine_heat_loss_static := 2										# Doesn't scale with heat
var engine_heat_loss_ko :float = 1										# Heat-loss koefficient, to easily increase/decrease loss from...
var engine_heat_per_accel:float = 0.1										# ...other factors. Like the engine door being open

var engine_fuel:float = 100
var engine_fuel_max := 100
var engine_fuel_per_heat:float = 0.04
var engine_fuel_loss_scalable:float = 0.02
var engine_fuel_loss_static:float = 3

var engine_active := false							# This shall function as a sort of breaks function


var simple_frame_count:int = 0


func apply_train_impulse(var impulse:float):
	velocity += impulse
	emit_signal("velocity_updated", velocity)



func _physics_process(delta):
	# Fuel & Heat logic
	var h:float = 0
	h -= engine_heat_loss_static  
	h -= (engine_heat / engine_heat_max) * engine_heat_loss_scalable
	h *= engine_heat_loss_ko
	
	# Fuel can be done in two ways: it gets transformed statically, or, the more fuel, the more effect
	# For now, let's test the latter
	h += engine_fuel * engine_fuel_per_heat
	
	var f:float = 0
	f -= engine_fuel_loss_static 
	f -= (engine_fuel/engine_fuel_max) * engine_fuel_loss_scalable 
	
	# This actually applies the logic
	engine_fuel = clamp(engine_fuel + f * delta, 0, engine_fuel_max)
	engine_heat = clamp(engine_heat + h * delta, 0, engine_heat_max)
	
	
	
	# Velocity logic
	var a:float = 0
	
	if engine_active:
		a += engine_heat * engine_heat_per_accel
	else:
		# Brake mode maybe?
		pass
	
	# Drag
	a -= velocity * (1 - velocity_drag_scalable) 
	a -= velocity_drag_static
	
	velocity += a * delta 
	velocity = clamp(velocity, 0, 1000)
	
	
	if simple_frame_count >= 10:
		print("Heat: " + String(engine_heat) + "  Fuel: " + String(engine_fuel) + "  accell: " + String(a), "  Vel: " + String(velocity))
		simple_frame_count = 0
	else:
		simple_frame_count += 1
	
	emit_signal("heat_updated", engine_heat/engine_heat_max)
	emit_signal("fuel_updated", engine_fuel/engine_fuel_max)
	emit_signal("velocity_updated", velocity)




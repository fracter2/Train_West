extends Node


signal velocity_updated

var hull_integrity = 1000
var hull_integrity_max = 1000
var train_velocity: float = 0

var wagons:Array = []

var resource_water := 1000
var resource_water_max := 2000
var resource_fuel:= 1000
var resource_fuel_max := 2000

var engine_heat := 20
var engine_heat_max := 100
var engine_fuel := 50
var engine_fuel_max := 200


func velocity_change(var vel:float):
	train_velocity += vel
	emit_signal("velocity_updated", train_velocity)




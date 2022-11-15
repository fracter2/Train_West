extends Node2D

var back_vel_k:float = 40				# K is for koefficient

var background1 = preload("res://src/Level/Enviornment/Background1.tscn")
var background2 = preload("res://src/Level/Enviornment/Background2.tscn")

var back1_width = 20200
var back2_width = 20200

var velocity:float = 0


func _physics_process(delta):
	velocity = Train_manager.velocity * back_vel_k
	
	$"Background-1/Background1".position.x += -velocity *delta	# Negative, since left is negative
	$"Background-2/Background2".position.x += -velocity *delta	# and velocity is not a vector...
															# shit, it should be called speed instead.

extends Node2D

var heal_ammount:int = 100

func activate(var body):
	body.heal(heal_ammount)

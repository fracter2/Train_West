extends Facility

export var heal_ammount:int = 20
var heal_charges_max:int = 3
var heal_charges:int = 3

export var recharge_time:float = 10

export var mouse_input:bool = false


# Setup secondary interaction from playter on release / out of range
func interact(var player): # override
	emit_signal("interacted", player)
	if heal_charges == 0: return
	
	player.heal(heal_ammount)
	update_charges(-1)
	
	if $Recharge_Timer.is_stopped():
		$Recharge_Timer.start(recharge_time)


func update_charges(count:int): # Count may only be 1, or -1
	#update_charge_visiblity(heal_charges + clamp(count, 0, 1), count)
	get_node("PolygonBase/Charge" + String(heal_charges + clamp(count,0,1))).visible = count
	# Clamped because, if its negative -> current one is turned off
	# and if positive, above charge is turned on
	
	heal_charges += clamp(count, 0, heal_charges_max) # Dont really have to clamp
	

#func update_charge_visiblity(index:int, on_off:int):
	

func _on_Recharge_Timer_timeout():
	update_charges(+1)
	if not heal_charges == heal_charges_max:
		$Recharge_Timer.start(recharge_time)

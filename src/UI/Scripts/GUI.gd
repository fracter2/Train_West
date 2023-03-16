extends Control

onready var number_label = $CanvasLayer/UI/Bars/Lifebar/Backround/Number # $Bars/LifeBar/Count/Background/Number
onready var bar = $CanvasLayer/UI/Bars/Lifebar/Gauge
onready var tween = $CanvasLayer/UI/Tween
onready var number_label_en = $CanvasLayer/UI/Bars/EnergyBar/Backround/Number
onready var bar_energy = $CanvasLayer/UI/Bars/EnergyBar/Gauge
var tween2:SceneTreeTween
var animated_health:float = 0
var animated_energy:float = 0
var animated_energy_target:float = 0


func _ready():
	tween2 = get_tree().create_tween()
	tween2.set_ease(Tween.EASE_OUT)
	tween2.set_trans(Tween.TRANS_EXPO)
	tween2.set_speed_scale(0.8)
	
	

func _process(delta):
	var round_value_hp = round(animated_health)
	number_label.text = str(round_value_hp)
	bar.value = round_value_hp
	
	animated_energy = lerp(animated_energy, animated_energy_target, 0.8)
	number_label_en.text = str(round(animated_energy_target))
	bar_energy.value = animated_energy
	
	

# Player health updates
func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT)
	if not tween.is_active():
		tween.start()

func _on_Repair_Tool_resource_changed(new_val:float):
	animated_energy_target = new_val
	
	
	
	# Let's ditch this
	#tween2.tween_property(self, "animated_energy", animated_energy, animated_energy_target)
	#if not tween2.is_running():
	#	tween2.play()
	#tween2.tween_property(self, "animated_energy", animated_energy, new_val)
	#if not tween2.is_running():
	#	tween2.play()
	


func update_max_health(new_value:int):
	bar.max_value



func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property()

# Misc functions




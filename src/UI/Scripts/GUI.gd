extends Control

onready var number_label = $CanvasLayer/UI/Bars/Lifebar/Backround/Number # $Bars/LifeBar/Count/Background/Number
onready var bar = $CanvasLayer/UI/Bars/Lifebar/Gauge
onready var tween = $CanvasLayer/UI/Tween

var animated_health = 0


#func _ready():

func _process(delta):
	var round_value = round(animated_health)
	number_label.text = str(round_value)
	bar.value = round_value



func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.8, Tween.TRANS_EXPO, Tween.EASE_OUT)
	if not tween.is_active():
		tween.start()


func update_max_health(new_value:int):
	bar.max_value


func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)

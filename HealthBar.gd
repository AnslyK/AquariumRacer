extends Control


onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $Tween

# Called when the node enters the scene tree for the first time.
func _on_health_updated(health, amount):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	update_tween.start()
func _on_max_health_updated(max_health):
	print("_on_max_health_updated")
	health_over.max_value = max_health
	health_under.max_value = max_health

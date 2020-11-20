extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	new_timer(1)

func new_timer(time):
	var value
	if time < 20:
		value = 5
	elif time >= 20 && time < 50:
		value = 3
	elif time >= 50 && time < 80:
		value = 2
	else:
		value = 1
	value = randi() %  value
	set_wait_time(value/10)

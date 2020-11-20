extends Area2D


export var speed = 200

func _ready():
	pass

func _process(delta):
	$AnimatedSeaWeed.animation = "default"
	var velocity = Vector2()
	velocity.y += 1
	velocity = velocity.normalized() * speed
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

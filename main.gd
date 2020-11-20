extends Node

signal change_life

export (PackedScene) var Shark
export (PackedScene) var Food
export (PackedScene) var SeaWeed

var rand = RandomNumberGenerator.new()
var score
var life
const totalLife = 5
var speed

func _ready():
	randomize()

func _on_player_hit():
	life -= 1
	emit_signal("change_life", life, -1)
	print(str("life: ",life))
	if life <= 0:
		print("game over")
		game_over()

func game_over():
	$ScoreTimer.stop()
	$SharkTimer.stop()
	$FoodTimer.stop()
	$SeaWeedTimer.stop()
	$HUD.show_game_over()
	$Player.visible = false

func new_game():
	life = totalLife
	score = 0
	speed = 300
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	print(str($HUD/HealthBar/HealthOver.value))
	$HUD/HealthBar.visible = true
	$StartTimer.start()

func _on_SharkTimer_timeout():
	var shark = Shark.instance()
	shark.position.y = -30
	shark.position.x = randi() % 1024
	
	add_child(shark)
	
	if score < 50:
		shark.linear_velocity.y = rand_range(shark.min_speed, shark.max_speed) * 2
	elif score >= 50 && score < 100:
		shark.linear_velocity.y = rand_range(shark.min_speed, shark.max_speed) * 3
	elif score >= 100 && score < 150:
		shark.linear_velocity.y = rand_range(shark.min_speed, shark.max_speed)
	elif score >= 150 && score < 200:
		shark.linear_velocity.y = rand_range(shark.min_speed, shark.max_speed) * 4
	else:
		shark.linear_velocity.y = rand_range(shark.min_speed, shark.max_speed) * 8


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$SharkTimer.start()
	$ScoreTimer.start()
	$FoodTimer.start()
	$SeaWeedTimer.start()


func _on_Player_eat(area):
	if life < totalLife:
		life += 1
		score += 3
		emit_signal("change_life", life, +1)
	else:
		score += 10
	print(str("eat Life :", life))
	$HUD.update_score(score)
	area.free()


func _on_FoodTimer_timeout():
	var food = Food.instance()
	food.position.y = 2
	food.position.x = randi() % 1024
	
	add_child(food)


func _on_SeaWeedTimer_timeout():
	var seaWeed = SeaWeed.instance()
	seaWeed.position.y = -2
	seaWeed.position.x = randi() % 1024
	
	add_child(seaWeed)

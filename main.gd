extends Node

export (PackedScene) var Shark
export (PackedScene) var Food
var rand = RandomNumberGenerator.new()
var score
var life
const totalLife = 5
var speed

func _ready():
	randomize()
	new_game()

func _on_player_hit():
	life -= 1
	print(str("life: ",life))
	if life <= 0:
		print("game over")
		game_over()

func game_over():
	$ScoreTimer.stop()
	$SharkTimer.stop()
	$FoodTimer.stop()

func new_game():
	life = totalLife
	score = 0
	speed = 300
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_SharkTimer_timeout():
	var shark = Shark.instance()
	shark.position.y = -30
	shark.position.x = randi() % 1024
	
	add_child(shark)
	
	shark.linear_velocity.y = 500


func _on_ScoreTimer_timeout():
	score += 1


func _on_StartTimer_timeout():
	$SharkTimer.start()
	$ScoreTimer.start()
	$FoodTimer.start()


func _on_Player_eat(area):
	if life < totalLife:
		life += 1
	print(str("eat Life :", life))
	area.free()


func _on_FoodTimer_timeout():
	var food = Food.instance()
	food.position.y = 2
	food.position.x = randi() % 1024
	
	add_child(food)

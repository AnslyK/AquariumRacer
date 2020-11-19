extends Node

export (PackedScene) var Shark
var score
var life

func _ready():
	randomize()

func _on_player_hit():
	life -= 1
	if life <= 1:
		game_over()

func game_over():
	$ScoreTimer.stop()
	$SharkTimer.stop()

func new_game():
	life = 5
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_player_eat():
	if life < 5:
		life += 1

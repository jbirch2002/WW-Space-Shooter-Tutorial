extends Node

var Laser = preload("res://Scenes/player_laser.tscn")
var score = 0

func _on_player_spawn_laser(location):
	var laser = Laser.instantiate()
	laser.global_position = location
	add_child(laser)

func score_increase():
	score += 10
	$Score.text = "SCORE: " + str(score)


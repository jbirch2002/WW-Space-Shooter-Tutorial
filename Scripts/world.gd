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

func pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$PauseMenu.show()
	
func unpause():
	if Input.is_action_just_pressed("pause"):
		$PauseMenu.hide()
		get_tree().paused = false

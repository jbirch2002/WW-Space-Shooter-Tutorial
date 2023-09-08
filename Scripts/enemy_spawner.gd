extends Node2D

signal add_score
signal give_player_power_up

var spawn_positions = null
var Enemy = preload("res://Scenes/enemy.tscn")
var PowerUp = preload("res://Scenes/power_up.tscn")

func _ready():
	randomize()
	spawn_positions = $SpawnPositions.get_children()

func spawn_enemy():
	var index = randi() % spawn_positions.size()
	var enemy = Enemy.instantiate()
	enemy.global_position = spawn_positions[index].global_position
	enemy.enemy_died.connect(_on_enemy_died)
	add_child(enemy)

func spawn_power_up():
	var index = randi() % spawn_positions.size()
	var power_up = PowerUp.instantiate()
	power_up.global_position = spawn_positions[index].global_position
	power_up.collected_power_up.connect(_give_player_power_up)
	add_child(power_up)
	
func _on_spawn_timer_timeout():
	spawn_enemy()

func _on_power_up_spawn_timer_timeout():
	spawn_power_up()

func _on_enemy_died():
	emit_signal("add_score")

func _give_player_power_up():
	give_player_power_up.emit()

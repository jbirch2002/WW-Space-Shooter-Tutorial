extends Area2D

signal collected_power_up

var spawn_positions = null
@export var speed = 450

func _physics_process(delta):
	power_up_movement(delta)
	
func power_up_movement(delta):
	global_position.y += speed * delta

func _on_power_up_area_entered(area):
	if area is Player:
		print("Power-up area entered by player")
		collected_power_up.emit()
		queue_free()

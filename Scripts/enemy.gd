extends Area2D

signal enemy_died

@export var speed = 150
@export var health = 1

func _physics_process(delta):
	enemy_movement(delta)
	
func enemy_movement(delta):
	global_position.y += speed * delta
	
func take_damage(damage):
	health -= damage 
	if health <= 0:
		queue_free()
		emit_signal("enemy_died")

func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(1)

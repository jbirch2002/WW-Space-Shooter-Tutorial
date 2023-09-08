extends Area2D
class_name Player

signal spawn_laser(location)

@export var speed = 300
@export var health = 3
@export var power_up_duration = 5
@onready var muzzle = $Muzzle

var input_vector = Vector2.ZERO 
var has_power_up = false
var current_direction = Vector2.UP


func _physics_process(delta):
	player_controls(delta)

func player_controls(delta):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	global_position += input_vector * speed * delta
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()
	elif has_power_up:
		shoot_laser()

func take_damage(damage):
	health -= damage 
	if health <= 0:
		queue_free()

func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(1)
		
func shoot_laser():
	emit_signal("spawn_laser", muzzle.global_position)

func collect_power_up():
	has_power_up = true
	$PowerUpEnd.start(power_up_duration)

func _on_power_up_end_timeout():
	has_power_up = false

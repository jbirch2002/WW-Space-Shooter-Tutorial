extends Area2D
class_name Player

signal spawn_laser(location)

@export var speed: float = 300
@export var min_distance: float = 10
@export var health = 3
@export var power_up_duration = 5
@onready var muzzle = $Muzzle
@onready var power_up_timer = $PowerUpEnd

var has_power_up = false

func _physics_process(delta):
	player_controls(delta)

func player_controls(delta):
	var target_position: Vector2 = get_global_mouse_position()
	var distance_to_target: float = global_position.distance_to(target_position)
	
	if distance_to_target > min_distance:
		var direction: Vector2 = (target_position - global_position).normalized()
		global_position += direction * speed * delta

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
	power_up_timer.start(power_up_duration)

func _on_power_up_end_timeout():
	has_power_up = false

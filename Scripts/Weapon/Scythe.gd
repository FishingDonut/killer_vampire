class_name Scythe
extends Node2D

@export var damage: float = 1
@export var direction: Vector2 = Vector2(1, 1)
@export var move_speed: float = 100

@onready var cooldown = $Timer
@onready var hit_box = $HitBox

func _physics_process(delta):
	position += (move_speed * direction) * delta


func _on_visible_on_screen_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	if body is Enemy:
		body._update_heart(damage)
		hit_box.set_deferred("monitoring", false)
		cooldown.start()


func _cooldown():
	hit_box.set_deferred("monitoring", true)

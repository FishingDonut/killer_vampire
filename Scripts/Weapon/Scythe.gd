class_name Scythe
extends Node2D

@export var damage: float = 1
@export var direction: Vector2 = Vector2(1, 1)
@export var move_speed: float = 100

func _physics_process(delta):
	position += (move_speed * direction) * delta


func _on_visible_on_screen_screen_exited():
	queue_free()


func _on_hit_box_area_entered(area):
	if area.is_in_group('enemies'):
		area.update_health.emit(damage)

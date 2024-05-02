extends Node2D

@export var xp_value: float = randi_range(1, 3)
@export var speed := 1

var direction : Vector2

func _ready():
	pass


func _process(delta):
	if direction:
		position += direction * speed


func _on_collision_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().collect_xp.emit(xp_value)
		queue_free()


func _on_area_collect_body_entered(body):
	if body is Player:
		_folow_body(body)

func _folow_body(body) -> void:
	direction = (body.position - position).normalized()


func _on_area_collect_body_exited(body):
	direction = Vector2.ZERO

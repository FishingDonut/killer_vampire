extends Node2D

@export var xp_value: float = randi_range(1, 3)

func _ready():
	pass


func _process(delta):
	pass


func _on_collision_area_body_entered(body):
	pass


func _on_collision_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().collect_xp.emit(xp_value)
		queue_free()

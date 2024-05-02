extends Node2D

@export var xp_value: float = randi_range(1, 3)
@export var speed: float = 0.1

var body_inside : bool = false
var player : Player
var direction : Vector2

func _ready():
	pass


func _process(delta):
	if body_inside and player:
		direction = (player.position - position).normalized()
		position += direction * speed

func _on_collision_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().collect_xp.emit(xp_value)
		queue_free()


func _on_area_collect_area_entered(area):
	if area.get_parent() is Player:
		player = area.get_parent()
		body_inside = true


func _on_area_collect_area_exited(area):
	if area.get_parent() is Player:
		body_inside = false

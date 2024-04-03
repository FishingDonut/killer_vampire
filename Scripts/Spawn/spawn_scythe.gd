class_name SpawnScythe
extends Node2D

@export var scythe := preload("res://Prefabs/Weapon/scythe.tscn")
@export var player: Player
@export var move_speed: float = 300
@export var time_cool_down: float = 5.5
@export var damage: float = 5.0

@onready var cool_down = $CoolDown

var direction := Vector2(1, 0)
var is_cool_down := false


func _ready():
	pass

func _process(delta):
	if player.direction.x != 0:
		direction.x = player.direction.x
		
	if is_cool_down:
		return
	
	_spawn_scythe()

func _spawn_scythe() -> void:
	var scythe_instantiate = scythe.instantiate()
	scythe_instantiate.move_speed = move_speed
	scythe_instantiate.damage = damage
	scythe_instantiate.direction = direction
	scythe_instantiate.position = player.position
	scythe_instantiate.position += direction * 16
	player.get_parent().call_deferred("add_child", scythe_instantiate)
	is_cool_down = true
	cool_down.start(time_cool_down)

func _on_cool_down_timeout():
	is_cool_down = false

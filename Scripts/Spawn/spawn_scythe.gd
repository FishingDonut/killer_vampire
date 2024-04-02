class_name SpawnScythe
extends Node2D

@export var scythe := preload("res://Prefabs/Weapon/scythe.tscn")
@export var player: Player
@export var current_world: World

@onready var cool_down = $CoolDown

var direction := Vector2(1, 0)
var is_cool_down := false


func _ready():
	current_world = Global.current_world


func _process(delta):
	if current_world == null:
		current_world = Global.current_world
	
		
	if player.direction.x != 0:
		direction.x = player.direction.x
		
	if is_cool_down:
		return
	
	var scythe_instantiate = scythe.instantiate()
	scythe_instantiate.direction = direction
	scythe_instantiate.position = player.position
	scythe_instantiate.position += direction * 16
	current_world.call_deferred("add_child", scythe_instantiate)
	is_cool_down = true
	cool_down.start()
	


func _on_cool_down_timeout():
	is_cool_down = false

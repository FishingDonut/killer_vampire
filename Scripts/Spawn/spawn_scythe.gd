class_name SpawnScythe
extends Node2D

@export var scythe := preload("res://Prefabs/Weapon/scythe.tscn")
@export var player: Player
var current_world: World

@onready var cool_down = $CoolDown

var direction := Vector2.ZERO
var is_cool_down := false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_world = Global.current_world


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_world == null:
		print('nulo')
		current_world = Global.current_world
	if player.direction.x == 0 or is_cool_down:
		return
	
	global_position = player.global_position
	position += direction * 16
	direction.x = player.direction.x
	
	var scythe_instantiate = scythe.instantiate()
	scythe_instantiate.direction = direction
	current_world.call_deferred("add_child", scythe_instantiate)
	is_cool_down = true
	cool_down.start()
	


func _on_cool_down_timeout():
	is_cool_down = false

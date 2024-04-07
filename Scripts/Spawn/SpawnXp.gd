extends Node2D

@onready var position_spawn = $PositionSpawn

var xp_preload = preload("res://Prefabs/Enemies/xp.tscn")

signal spawn_xp

func _ready() -> void:
	spawn_xp.connect(_spawn_xp)

func _spawn_xp() -> void:
	var xp_instantiate = xp_preload.instantiate()
	xp_instantiate.global_position = position_spawn.global_position
	get_parent().get_parent().call_deferred("add_child", xp_instantiate)

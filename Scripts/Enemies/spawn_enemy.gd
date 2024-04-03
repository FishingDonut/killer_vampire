extends Node2D

@export var enemy = preload("res://Prefabs/Enemies/ghost_enemy.tscn")
@export var player: Player
@export var move_speed := 40.0
@export var max_hp := 1.0

@onready var timer = $Timer

var distance : Vector2 
var is_cool_down: bool = false

func _ready() -> void:
	_new_distance()

func _process(delta):
	if is_cool_down:
		return
	if player == null:
		return
		
	var enemy_instantiate = enemy.instantiate()
	enemy_instantiate.max_hp = max_hp
	enemy_instantiate.position = player.position + distance
	enemy_instantiate.move_speed = move_speed
	player.get_parent().call_deferred("add_child", enemy_instantiate)
	_new_distance()
	is_cool_down = true
	timer.start()

func _new_distance() -> void:
	distance = Vector2(randi_range(-1, 1), randi_range(-1, 1)) * 400
	while distance == Vector2.ZERO:
		distance = Vector2(randi_range(-1, 1), randi_range(-1, 1)) * 400


func _on_timer_timeout():
	is_cool_down = false

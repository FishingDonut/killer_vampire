extends Node2D

@export var enemy = preload("res://Prefabs/Enemies/ghost_enemy.tscn")
@export var player: Player
@export var move_speed := 40.0
@export var max_hp := 1.0
@export var time_interval := 0.3
@export var max_enemies: int
@export var min_distance: int
@export var max_distance: int

@onready var timer = $Timer

var direction := Vector2(1, 0)
var distance : Vector2 = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * randi_range(min_distance, max_distance)
var is_cool_down: bool = false

func _ready() -> void:
	_new_distance()

func _process(delta):
	if Global.counter_enemies >= max_enemies:
		return
	
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
	timer.start(time_interval)
	

func _new_distance() -> void:
	if player.direction:
		direction = player.direction
	distance = direction * randf_range(min_distance, max_distance)


func _on_timer_timeout():
	is_cool_down = false

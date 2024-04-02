class_name Enemy
extends CharacterBody2D


@export var move_speed: float
@export var max_hp: float

var direction: Vector2
var current_hp: float
var damage: float = 1.0

func  _ready():
	current_hp = max_hp

func _physics_process(delta):
	if !Global.player:
		return
	direction = (Global.player.position - position).round().normalized()

	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.y = move_toward(velocity.y, 0, move_speed)

	move_and_slide()

func _update_heart(damage) -> void:
	current_hp -= damage
	print(current_hp)
	if current_hp <= 0:
		queue_free()

class_name GhostEnemy
extends CharacterBody2D

@onready var animation = $Animation
@onready var sprite = $Sprite
@onready var hurt_area_collision = $HurtAreaCollision


@export var move_speed: float
@export var max_hp: float


var direction: Vector2
var current_hp: float
var damage: float = 1.0


func  _ready():
	Global.counter_enemies += 1
	current_hp = max_hp
	hurt_area_collision.update_health.connect(_update_heart)

func _physics_process(delta) -> void:
	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.y = move_toward(velocity.y, 0, move_speed)

	if round(direction.x) != 0:
		sprite.scale.x = round(direction.x)
		pass
	move_and_slide()
	if !Global.player:
		return
	direction = (Global.player.position - position).normalized()

func _update_heart(damage: float) -> void:
	current_hp -= damage
	if current_hp <= 0:
		Global.counter_score += randi_range(100, 300)
		Global.counter_kill += 1
		Global.counter_enemies -= 1
		queue_free()

func _no_player() -> void:
	direction = -direction

class_name Enemy
extends CharacterBody2D

@onready var animation = $Animation
@onready var sprite = $Sprite

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
	direction = round((Global.player.position - position).normalized())

	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.y = move_toward(velocity.y, 0, move_speed)

	if direction.x != 0:
		sprite.scale.x = direction.x
		
	move_and_slide()

func _update_heart(damage) -> void:
	current_hp -= damage
	if current_hp <= 0:
		queue_free()
